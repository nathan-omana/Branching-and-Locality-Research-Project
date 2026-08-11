#ifndef SORTS_H
#define SORTS_H

#include <stdint.h>
#include <stddef.h>

/*
 * Uniform sort signature
 */
typedef void (*sort_fn)(int32_t *a, size_t n);

/* Cap insertion sort to avoid O(n^2) blowup at large n */
#define INSERTION_SORT_MAX_N 65536UL

void insertion_sort(int32_t *a, size_t n);
void quicksort_branchy(int32_t *a, size_t n);
void quicksort_branchless(int32_t *a, size_t n);
void stdlib_qsort(int32_t *a, size_t n);

#endif /* SORTS_H */
