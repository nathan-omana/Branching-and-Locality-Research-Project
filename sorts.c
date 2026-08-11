/* sorts.c — four sorting implementations*/

#include "sorts.h"
#include <stdlib.h>
#include <stdint.h>
#include <stddef.h>

/* swap two int32 values */
static inline void swap32(int32_t *a, int32_t *b)
{
    int32_t tmp = *a;
    *a = *b;
    *b = tmp;
}

/* sort a[lo], a[mid], a[hi] and return the median as pivot
 * source: sedgewick, "implementing quicksort programs", cacm 1978 */
static inline int32_t median_of_three(int32_t *a, size_t lo, size_t mid, size_t hi)
{
    if (a[lo] > a[mid]) swap32(&a[lo], &a[mid]);
    if (a[lo] > a[hi])  swap32(&a[lo], &a[hi]);
    if (a[mid] > a[hi]) swap32(&a[mid], &a[hi]);
    return a[mid]; /* a[lo] <= a[mid] <= a[hi] */
}

/*1. insertion sort — o(n^2) baseline, capped at 64k in bench.*/

void insertion_sort(int32_t *a, size_t n)
{
    for (size_t i = 1; i < n; i++) {
        int32_t key = a[i];
        size_t j = i;
        while (j > 0 && a[j - 1] > key) {
            a[j] = a[j - 1];
            j--;
        }
        a[j] = key;
    }
}

/* --- 2. quicksort_branchy — lomuto partition with if-guarded swap*/

static size_t partition_branchy(int32_t *a, size_t lo, size_t hi)
{
    size_t mid = lo + (hi - lo) / 2;
    median_of_three(a, lo, mid, hi);
    swap32(&a[mid], &a[hi]);
    int32_t pivot = a[hi]; /* pivot parked at hi */

    size_t i = lo; /* i = next slot for a left-side element */
    for (size_t j = lo; j < hi; j++) {
        if (a[j] < pivot) { /* data-dependent branch*/
            swap32(&a[i], &a[j]);
            i++;
        }
    }
    swap32(&a[i], &a[hi]); /* place pivot */
    return i;
}

/* iterative quicksort using an explicit work-stack (depth <= log2(n) */
#define QS_STACK_DEPTH 64
typedef struct { size_t lo, hi; } range_t;

static void qs_branchy_impl(int32_t *a, size_t n)
{
    if (n < 2) return;
    range_t stk[QS_STACK_DEPTH];
    int top = 0;
    size_t lo = 0, hi = n - 1;
    for (;;) {
        while (lo < hi) {
            size_t p = partition_branchy(a, lo, hi);
            size_t left_n  = (p > lo) ? (p - lo) : 0;
            size_t right_n = (p < hi) ? (hi - p) : 0;
            if (left_n <= right_n) {
                if (right_n > 0) { stk[top].lo = p + 1; stk[top].hi = hi; top++; }
                hi = (left_n > 0) ? p - 1 : lo;
            } else {
                if (left_n > 0) { stk[top].lo = lo; stk[top].hi = p - 1; top++; }
                lo = (right_n > 0) ? p + 1 : hi;
            }
        }
        if (top == 0) break;
        --top; lo = stk[top].lo; hi = stk[top].hi;
    }
}

void quicksort_branchy(int32_t *a, size_t n) { qs_branchy_impl(a, n); }

/* --- 3. quicksort_branchless — lomuto partition, unconditional swap + cinc index advance
 * swap unconditionally,
 * only advance i conditionally. i += (comparison) compiles to cinc/cmov 
 * source: cmpt 295 project spec §4.2; stavenga, "branchless lomuto partition" (2022) */

static size_t partition_branchless(int32_t *a, size_t lo, size_t hi)
{
    size_t mid = lo + (hi - lo) / 2;
    median_of_three(a, lo, mid, hi);
    swap32(&a[mid], &a[hi]);
    int32_t pivot = a[hi];

    size_t i = lo;
    for (size_t j = lo; j < hi; j++) {
        swap32(&a[i], &a[j]);       /* unconditional — always safe */
        i += (a[i] < pivot);       
    }
    swap32(&a[i], &a[hi]);
    return i;
}

static void qs_branchless_impl(int32_t *a, size_t n)
{
    if (n < 2) return;
    range_t stk[QS_STACK_DEPTH]; /* same explicit-stack approach as branchy */
    int top = 0;
    size_t lo = 0, hi = n - 1;
    for (;;) {
        while (lo < hi) {
            size_t p = partition_branchless(a, lo, hi);
            size_t left_n  = (p > lo) ? (p - lo) : 0;
            size_t right_n = (p < hi) ? (hi - p) : 0;
            if (left_n <= right_n) {
                if (right_n > 0) { stk[top].lo = p + 1; stk[top].hi = hi; top++; }
                hi = (left_n > 0) ? p - 1 : lo;
            } else {
                if (left_n > 0) { stk[top].lo = lo; stk[top].hi = p - 1; top++; }
                lo = (right_n > 0) ? p + 1 : hi;
            }
        }
        if (top == 0) break;
        --top; lo = stk[top].lo; hi = stk[top].hi;
    }
}

void quicksort_branchless(int32_t *a, size_t n) { qs_branchless_impl(a, n); }

/* --- 4. stdlib_qsort — wrapper around c standard library qsort*/

static int cmp_int32(const void *a, const void *b)
{
    int32_t x = *(const int32_t *)a;
    int32_t y = *(const int32_t *)b;
    return (x > y) - (x < y);
}

void stdlib_qsort(int32_t *a, size_t n)
{
    qsort(a, n, sizeof(int32_t), cmp_int32);
}
