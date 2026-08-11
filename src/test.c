/*
 * test.c — correctness tests
 *
 * Test order:
 *   1. Tiny cases: n = 0, 1, 2, 3
 *   2. Small known arrays (n=10) for all five distributions, (estimate*)
 *   3. Multiset check at n=1000 for all algorithms × all distributions
 *   4. Adversarial: all-identical, already-sorted, reverse at n=100000
 *
 * Exits 0 if all pass, 1 on first failure.
 */

#include "sorts.h"
#include "gen.h"
#include "verify.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define PASS "\033[32mPASS\033[0m"
#define FAIL "\033[31mFAIL\033[0m"

static int total = 0;
static int failed = 0;

/* Test helper*/

static void check(sort_fn fn, const char *fn_name, int32_t *a, size_t n,
                  const char *label)
{
    total++;

    /* Save original for multiset check */
    int32_t *orig = malloc(n * sizeof(int32_t));
    if (!orig && n > 0) { perror("malloc"); exit(1); }
    if (n > 0) memcpy(orig, a, n * sizeof(int32_t));

    fn(a, n);

    int ok = (n == 0) ? 1 : verify_sort(a, orig, n);
    printf("  [%s] %s | %s | n=%zu\n", ok ? PASS : FAIL, fn_name, label, n);
    if (!ok) failed++;

    free(orig);
}

/* Sort using all four algorithms */
static void check_all(int32_t *buf, size_t n, const char *label)
{
    int32_t *copy = malloc(n * sizeof(int32_t));
    if (!copy && n > 0) { perror("malloc"); exit(1); }

    /* insertion sort only up to its cap */
    if (n <= INSERTION_SORT_MAX_N) {
        if (n > 0) memcpy(copy, buf, n * sizeof(int32_t));
        check(insertion_sort, "insertion   ", copy, n, label);
    }

    if (n > 0) memcpy(copy, buf, n * sizeof(int32_t));
    check(quicksort_branchy, "branchy     ", copy, n, label);

    if (n > 0) memcpy(copy, buf, n * sizeof(int32_t));
    check(quicksort_branchless, "branchless  ", copy, n, label);

    if (n > 0) memcpy(copy, buf, n * sizeof(int32_t));
    check(stdlib_qsort, "stdlib      ", copy, n, label);

    free(copy);
}

/* Test groups*/

static void test_tiny(void)
{
    printf("\n=== 1. Tiny cases (n=0,1,2,3) ===\n");

    int32_t a0[1] = {0};  /* n=0 test uses this with size 0 */
    int32_t a1[] = {42};
    int32_t a2a[] = {2, 1};
    int32_t a2b[] = {1, 2};
    int32_t a3a[] = {3, 1, 2};
    int32_t a3b[] = {1, 1, 1};

    check_all(a0, 0, "empty");
    check_all(a1, 1, "single");
    check_all(a2a, 2, "two-reversed");
    check_all(a2b, 2, "two-sorted");
    check_all(a3a, 3, "three-unordered");
    check_all(a3b, 3, "three-identical");
}

static void test_small_distributions(void)
{
    printf("\n=== 2. Small known arrays n=10, all distributions ===\n");

    int32_t buf[10];
    char label[64];

    for (int d = 0; d < (int)DIST_COUNT; d++) {
        gen_fill(buf, 10, (dist_t)d, 0xABCD1234ULL);
        snprintf(label, sizeof(label), "dist=%s", dist_names[d]);
        check_all(buf, 10, label);
    }
}

static void test_multiset_1000(void)
{
    printf("\n=== 3. Multiset check n=1000, all algorithms × all distributions ===\n");

    int32_t buf[1000];
    char label[64];

    for (int d = 0; d < (int)DIST_COUNT; d++) {
        gen_fill(buf, 1000, (dist_t)d, 0xDEAD295ULL);
        snprintf(label, sizeof(label), "dist=%s,n=1000", dist_names[d]);
        check_all(buf, 1000, label);
    }
}

static void test_adversarial(void)
{
    printf("\n=== 4. Adversarial cases (n=100000) ===\n");

    const size_t N = 100000;
    int32_t *buf = malloc(N * sizeof(int32_t));
    if (!buf) { perror("malloc"); exit(1); }

    /* Already sorted */
    gen_fill(buf, N, DIST_SORTED, 0x1ULL);
    check_all(buf, N, "sorted-100k");

    /* Reverse sorted */
    gen_fill(buf, N, DIST_REVERSE, 0x1ULL);
    check_all(buf, N, "reverse-100k");

    /* All identical */
    for (size_t i = 0; i < N; i++) buf[i] = 7;
    check_all(buf, N, "all-identical-100k");

    /* Dupes distribution */
    gen_fill(buf, N, DIST_DUPES, 0x295ULL);
    check_all(buf, N, "dupes-100k");

    free(buf);
}

/*main*/

int main(void)
{
    printf("CMPT 295 Mini-Project — Correctness Tests\n");

    test_tiny();
    test_small_distributions();
    test_multiset_1000();
    test_adversarial();

    printf("Results: %d/%d passed", total - failed, total);
    if (failed == 0)
        printf("  — " PASS " all good\n");
    else
        printf("  — " FAIL " %d FAILURES\n", failed);

    return failed ? 1 : 0;
}
