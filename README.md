# Branch Prediction vs. Memory Locality in Sorting

CMPT 295 mini-project — Nathan Omana

A microbenchmark suite comparing four `int32_t` array sorts to isolate two
separate costs on real hardware: **branch misprediction** and **memory
locality**. The centerpiece is a branchy vs. branchless Lomuto quicksort
partition — same algorithm, same big-O, built to answer one question:

> A branchless Lomuto partition removes the data-dependent branch by using a
> conditional move (`cinc` on ARM64, `cmov` on x86) instead of an `if`. It pays
> for this with extra instructions per element. Where does that trade actually
> pay off, and where does it not?

Full writeup with methodology, disassembly, and results: **[Report.pdf](Report.pdf)**.

## Key results

- **Inside L1d (n < 32K):** branchy wins — the branchless loop's unconditional
  swap costs more than the mispredictions it avoids.
- **At the L1d boundary (n = 32K):** the one crossover point where branchless
  wins, by ~9%.
- **In the L2 range and beyond:** branchy recovers and stays 3–6% faster, then
  the two converge to within noise past ~4M elements (past L2).
- **Sorted/reverse/partial input:** branchy is 2–11x faster — with no
  mispredictions to remove, the branchless version's unconditional swaps are
  pure wasted work.
- **Duplicate-heavy input:** both degrade badly (Lomuto's equal-key weakness
  drives near-quadratic partitions); branchless is ~8x slower than branchy at
  this point.
- **`stdlib qsort`** is 1.2–1.6x slower than the hand-written branchy sort at
  every size — a constant cost from the indirect function-pointer comparator,
  not from branching or cache.
- **`-O0` → `-O1`** is the single biggest speedup for both sorts (~2.4x) — this
  is register allocation removing memory traffic, not the branch/branchless
  distinction itself.

Section 5 of the report also tracks six specific predictions made *before*
benchmarking (see [`docs/PREDICTIONS.md`](docs/PREDICTIONS.md)) against what
was actually measured — four held, one held only partially, one didn't hold
at all (clang does not fold the branchy loop into a `cmov` at `-O2`/`-O3`).

## The four implementations

All sort `int32_t` arrays in place with the signature `void sort(int32_t *a, size_t n)`:

| Name | File | Notes |
|---|---|---|
| `insertion_sort` | `src/sorts.c` | O(n²) baseline, capped at n ≤ 64K |
| `quicksort_branchy` | `src/sorts.c` | Lomuto partition, `if`-guarded swap |
| `quicksort_branchless` | `src/sorts.c` | Same partition, unconditional swap + `i += (a[i] < pivot)` |
| `stdlib_qsort` | `src/sorts.c` | Wraps libc `qsort` as a baseline |

## Repo layout

```
src/          sort implementations, RNG-based array generator, verifier, bench/test harnesses
asm/          annotated compiler output at -O0..-O3 for the partition inner loops
bench         binary produced by `make` — timing harness (built at -O2 by default)
test_runner   binary produced by `make test` — correctness checks
results/      raw CSVs from bench runs (opt-level sweep, full timing sweep)
docs/         PREDICTIONS.md — predictions committed before any benchmarking
notes/        working notes from development
Report.pdf    full writeup: methodology, disassembly, results, discussion
```

## Building and running

Requires a C11 compiler (developed against Apple clang; any recent
gcc/clang on Linux or macOS with `-march=native` support works).

```sh
# build the default benchmark binary (-O2)
make

# run correctness tests
make test

# build one binary per optimization level (-O0 .. -O3)
make all_opt

# dump annotated assembly for the sort routines at each opt level
make asm
```

`bench` takes either a full sweep or a single configuration:

```sh
./bench --all                              # full sweep, all algos x distributions x sizes
./bench --algo=branchless --dist=sorted --n=1048576   # single run

# algos: insertion branchy branchless stdlib
# dists: random sorted reverse partial dupes
```

Output is CSV on stdout: `algorithm,distribution,n,opt_level,trial,ns,checksum`.
Each configuration runs 7 trials; trial 0 is discarded as warm-up, and the
report uses the median of the remaining 6. The checksum guards against the
optimizer eliminating the sort as dead code, and correctness is independently
verified (sortedness + multiset equality against the input) before each
configuration's rows are printed.

## Methodology at a glance

- **Machine:** Apple M2 (ARM64) — 128 KB L1d/core, 16 MB shared L2, no
  conventional L3, 8 GB LPDDR5.
- **Compiler:** Apple clang 17, `-std=c11 -Wall -march=native`, results
  reported at `-O2` unless comparing optimization levels.
- **Timing:** `clock_gettime(CLOCK_MONOTONIC)`, not `rdtsc` (whose counter
  runs at a fixed reference rate, not core clock).
- **Input distributions:** `random`, `sorted`, `reverse`, `partial` (95%
  sorted / 5% shuffled), and `dupes` (~10 distinct values) — chosen to
  isolate the branch predictor's hit rate independent of array size.
- **Limitation:** Valgrind/Cachegrind don't run on Apple Silicon, so branch
  misprediction counts are inferred from controlled timing comparisons rather
  than measured directly. See the report's Limitations section for the full
  list (no core affinity control, ARM64-only, Lomuto is not itself an
  optimized partition scheme).
