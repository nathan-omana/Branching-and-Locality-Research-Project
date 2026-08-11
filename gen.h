#ifndef GEN_H
#define GEN_H

#include <stdint.h>
#include <stddef.h>

/*
 * Input distributions for the benchmark.
 *
 * DIST_RANDOM   — uniformly random 32-bit values
 * DIST_SORTED   — ascending order
 * DIST_REVERSE  — descending order
 * DIST_PARTIAL  — 95% sorted, 5% randomly shuffled positions
 * DIST_DUPES    — only ~10 distinct values (stresses equal-key handling)
 */
typedef enum {
    DIST_RANDOM = 0,
    DIST_SORTED,
    DIST_REVERSE,
    DIST_PARTIAL,
    DIST_DUPES,
    DIST_COUNT
} dist_t;

extern const char *dist_names[DIST_COUNT];

/*gen_fill — fill a[0..n-1] with distribution d using seed.*/
void gen_fill(int32_t *a, size_t n, dist_t d, uint64_t seed);

#endif /* GEN_H */
