/* bench.c — timing harness for cmpt 295 mini-project
 * 7 trials per config, trial 0 discarded (for the cpu warmup), median of trials 1-6 reported
 * pristine array re-copied before each trial (outside timed region)
 * checksum consumed after each sort to prevent dead-code elimination at -o2
 * output: one csv row per trial — algorithm,distribution,n,opt_level,trial,ns,checksum */

#include "sorts.h"
#include "gen.h"
#include "verify.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <stddef.h>
#include <time.h>

#define TRIALS     7
#define WARMUP     1   /* discard first trial */
#define SEED_BASE  0x295ULL

/* opt level string, set at compile time */
#ifndef OPT_LEVEL
#define OPT_LEVEL "O2"
#endif

typedef struct {
    const char *name;
    sort_fn     fn;
    size_t      max_n; /* 0 = no limit */
} algo_entry_t;

static const algo_entry_t algos[] = {
    { "insertion",  insertion_sort,       INSERTION_SORT_MAX_N },
    { "branchy",    quicksort_branchy,    0 },
    { "branchless", quicksort_branchless, 0 },
    { "stdlib",     stdlib_qsort,         0 },
};
static const int N_ALGOS = (int)(sizeof(algos) / sizeof(algos[0]));

static const size_t sweep_sizes[] = {
    8192, 32768, 131072, 524288, 2097152, 8388608, 33554432, 67108864
};
static const int N_SIZES = (int)(sizeof(sweep_sizes) / sizeof(sweep_sizes[0]));

/* clock_gettime(monotonic) — not rdtsc, which is a fixed-rate reference counter not a core clock */
static inline int64_t now_ns(void)
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return (int64_t)ts.tv_sec * 1000000000LL + ts.tv_nsec;
}

/* comparator for qsort-based median */


static int cmp_i64(const void *a, const void *b)
{
    int64_t x = *(const int64_t *)a;
    int64_t y = *(const int64_t *)b;
    return (x > y) - (x < y);
}

/* run one (algo, dist, n) configuration and emit csv rows */

static int64_t run_bench(const algo_entry_t *algo, dist_t dist, size_t n,
                         int32_t *pristine, int32_t *work)
{
    if (algo->max_n > 0 && n > algo->max_n) return -1; /* skip oversized configs */

    gen_fill(pristine, n, dist, SEED_BASE ^ (uint64_t)dist ^ (uint64_t)n);

    int64_t  times[TRIALS];
    uint64_t checksums[TRIALS];

    for (int t = 0; t < TRIALS; t++) {
        memcpy(work, pristine, n * sizeof(int32_t)); /* re-copy outside timed region */
        int64_t t0 = now_ns();
        algo->fn(work, n);
        int64_t t1 = now_ns();
        times[t]     = t1 - t0;
        checksums[t] = array_checksum(work, n);
    }

    gen_fill(pristine, n, dist, SEED_BASE ^ (uint64_t)dist ^ (uint64_t)n);
    if (!verify_sort(work, pristine, n)) {
        fprintf(stderr, "correctness fail: algo=%s dist=%s n=%zu\n",
                algo->name, dist_names[dist], n);
        exit(1);
    }
    gen_fill(pristine, n, dist, SEED_BASE ^ (uint64_t)dist ^ (uint64_t)n); /* restore */

    for (int t = 0; t < TRIALS; t++) {
        printf("%s,%s,%zu,%s,%d,%lld,%llu\n",
               algo->name, dist_names[dist], n, OPT_LEVEL, t,
               (long long)times[t], (unsigned long long)checksums[t]);
    }

    /* return median of post-warmup trials */
    int64_t post[TRIALS - WARMUP];
    for (int i = 0; i < TRIALS - WARMUP; i++) post[i] = times[i + WARMUP];
    qsort(post, TRIALS - WARMUP, sizeof(int64_t), cmp_i64);
    return post[(TRIALS - WARMUP) / 2];
}

static void usage(const char *prog)
{
    fprintf(stderr,
        "usage:\n"
        "  %s --all                         # full sweep\n"
        "  %s --algo=name --dist=name --n=n # single run\n"
        "\nalgos: insertion branchy branchless stdlib\n"
        "dists: random sorted reverse partial dupes\n",
        prog, prog);
    exit(1);
}

int main(int argc, char **argv)
{
    int do_all = 0;
    const char *algo_name = NULL;
    const char *dist_name = NULL;
    size_t single_n = 0;

    for (int i = 1; i < argc; i++) {
        if      (strcmp(argv[i], "--all") == 0)          do_all = 1;
        else if (strncmp(argv[i], "--algo=", 7) == 0)    algo_name = argv[i] + 7;
        else if (strncmp(argv[i], "--dist=", 7) == 0)    dist_name = argv[i] + 7;
        else if (strncmp(argv[i], "--n=", 4) == 0)       single_n = (size_t)strtoull(argv[i] + 4, NULL, 10);
        else usage(argv[0]);
    }

    if (!do_all && (!algo_name || !dist_name || single_n == 0)) usage(argv[0]);

    printf("algorithm,distribution,n,opt_level,trial,ns,checksum\n");

    if (do_all) {
        /* allocate per-size to avoid holding 768 mb for n=64m all at once */
        for (int si = 0; si < N_SIZES; si++) {
            size_t n = sweep_sizes[si];
            int32_t *pristine = malloc(n * sizeof(int32_t));
            int32_t *work     = malloc(n * sizeof(int32_t));
            if (!pristine || !work) { perror("malloc"); return 1; }
            for (int ai = 0; ai < N_ALGOS; ai++)
                for (int di = 0; di < (int)DIST_COUNT; di++)
                    run_bench(&algos[ai], (dist_t)di, n, pristine, work);
            free(pristine); free(work);
        }
    } else {
        const algo_entry_t *algo = NULL;
        for (int i = 0; i < N_ALGOS; i++)
            if (strcmp(algos[i].name, algo_name) == 0) { algo = &algos[i]; break; }
        if (!algo) { fprintf(stderr, "unknown algorithm: %s\n", algo_name); return 1; }

        dist_t dist = DIST_COUNT;
        for (int i = 0; i < (int)DIST_COUNT; i++)
            if (strcmp(dist_names[i], dist_name) == 0) { dist = (dist_t)i; break; }
        if (dist == DIST_COUNT) { fprintf(stderr, "unknown distribution: %s\n", dist_name); return 1; }

        int32_t *pristine = malloc(single_n * sizeof(int32_t));
        int32_t *work     = malloc(single_n * sizeof(int32_t));
        if (!pristine || !work) { perror("malloc"); return 1; }
        run_bench(algo, dist, single_n, pristine, work);
        free(pristine); free(work);
    }

    return 0;
}
