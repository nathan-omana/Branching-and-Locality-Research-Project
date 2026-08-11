#ifndef VERIFY_H
#define VERIFY_H

#include <stdint.h>
#include <stddef.h>

/*
 * verify_sort — checks two necessary conditions:
 *   1. Sortedness: a[i] <= a[i+1] for all i.
 *   2. the sorted result contains the same elements as the original (ref).  This catches bugs where a sort produces a
 *      sorted output by losing or duplicating elements.
 */
int verify_sort(const int32_t *sorted, const int32_t *ref, size_t n);

/*
 * array_checksum — simple XOR checksum 
 */
uint64_t array_checksum(const int32_t *a, size_t n);

#endif /* VERIFY_H */
