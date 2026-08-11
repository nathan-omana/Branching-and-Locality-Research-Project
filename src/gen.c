/* gen.c — deterministic input generation for cmpt 295 mini-project */

#include "gen.h"
#include <stdint.h>
#include <stddef.h>
#include <string.h>

const char *dist_names[DIST_COUNT] = {
    "random", "sorted", "reverse", "partial", "dupes"
};

/* xorshift64 prng — period 2^64-1, fast, reproducible
 * source: marsaglia, "xorshift rngs", journal of statistical software, 2003
 * shift triple (13,7,17) from table 1 of that paper */
static inline uint64_t xorshift64(uint64_t *state)
{
    uint64_t x = *state;
    x ^= x << 13;
    x ^= x >> 7;
    x ^= x << 17;
    *state = x;
    return x;
}

/* xorshift64 must not start at 0*/
static inline uint64_t safe_seed(uint64_t seed)
{
    return seed ? seed : 0xdeadbeefcafeULL;
}

void gen_fill(int32_t *a, size_t n, dist_t d, uint64_t seed)
{
    if (n == 0) return;
    uint64_t rng = safe_seed(seed);

    switch (d) {

    case DIST_RANDOM:
        for (size_t i = 0; i < n; i++)
            a[i] = (int32_t)(xorshift64(&rng) & 0xFFFFFFFFu);
        break;

    case DIST_SORTED:
        for (size_t i = 0; i < n; i++)
            a[i] = (int32_t)i; /* ascending integers */
        break;

    case DIST_REVERSE:
        for (size_t i = 0; i < n; i++)
            a[i] = (int32_t)(n - 1 - i); /* descending integers */
        break;

    case DIST_PARTIAL: {
        /* start sorted, then swap n/20 random pairs — leaves 95% in place */
        for (size_t i = 0; i < n; i++)
            a[i] = (int32_t)i;
        size_t swaps = n / 20;
        if (swaps < 1) swaps = 1;
        for (size_t k = 0; k < swaps; k++) {
            size_t i = xorshift64(&rng) % n;
            size_t j = xorshift64(&rng) % n;
            int32_t tmp = a[i]; a[i] = a[j]; a[j] = tmp;
        }
        break;
    }

    case DIST_DUPES: {
        /* pick 10 random values, fill array from that pool — stresses equal-key handling */
        int32_t pool[10];
        for (int k = 0; k < 10; k++)
            pool[k] = (int32_t)(xorshift64(&rng) & 0xFFFFFFFFu);
        for (size_t i = 0; i < n; i++)
            a[i] = pool[xorshift64(&rng) % 10];
        break;
    }

    default:
        memset(a, 0, n * sizeof(int32_t));
        break;
    }
}
