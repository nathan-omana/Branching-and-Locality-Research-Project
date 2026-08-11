/* correctness checks */

#include "verify.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include <stddef.h>

static int cmp_i32(const void *a, const void *b)
{
    int32_t x = *(const int32_t *)a;
    int32_t y = *(const int32_t *)b;
    return (x > y) - (x < y);
}

int verify_sort(const int32_t *sorted, const int32_t *ref, size_t n)
{
    /* check 1: array must be in non-decreasing order */
    for (size_t i = 1; i < n; i++) {
        if (sorted[i - 1] > sorted[i]) {
            fprintf(stderr, "fail: not sorted at index %zu (%d > %d)\n",
                    i, sorted[i - 1], sorted[i]);
            return 0;
        }
    }

    /* check 2: sorted must contain exactly the same elements as ref */
    int32_t *ref_sorted = malloc(n * sizeof(int32_t));
    if (!ref_sorted) { fprintf(stderr, "fail: malloc\n"); return 0; }
    memcpy(ref_sorted, ref, n * sizeof(int32_t));
    qsort(ref_sorted, n, sizeof(int32_t), cmp_i32);

    int ok = 1;
    for (size_t i = 0; i < n; i++) {
        if (sorted[i] != ref_sorted[i]) {
            fprintf(stderr, "fail: multiset mismatch at %zu (got %d, expected %d)\n",
                    i, sorted[i], ref_sorted[i]);
            ok = 0;
            break;
        }
    }
    free(ref_sorted);
    return ok;
}

/* position-sensitive xor checksum */
uint64_t array_checksum(const int32_t *a, size_t n)
{
    uint64_t cs = 0;
    for (size_t i = 0; i < n; i++)
        cs ^= (uint64_t)(uint32_t)a[i] ^ (i * 0x9e3779b97f4a7c15ULL);
    return cs;
}
