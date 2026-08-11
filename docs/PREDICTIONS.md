# Predictions — prior to experiment

**Author:** Nathan Omana 301596662  
**Date committed:** 2026-08-06 (before any benchmarking)

These predictions are falsifiable claims. Each will be revisited in the report
with the actual result and an explanation of why it held or failed.

---

## P1 — Branchless loses on `sorted` input

**Hypothesis:** `quicksort_branchy` will perform better than `quicksort_branchless`
on sorted/reverse sorted input for all tested input sizes.

**Explanation:** In the case of sorted input, the condition in the Lomuto
partition is entirely predictable because each element compares identically to
the pivot and thus produces zero misprediction penalties on the part of the
branch predictor. The branch version incurs no penalty from mispredictions.
The branchless variant has the additional instruction overhead in the form of
both the swap and the index increment operation which are done regardless
of the comparison result.

---

## P2 — Crossover near the L2 boundary 

**Prediction**: The performance crossovers of the branchy versus branchless (with
random input) will be around 512K elements, since this is where working set size
is bigger than the per-core L2 cache.

**Explanation**: Below L2 capacity, the main cost will be the branch
misprediction, since random input produces 50% mispredictions, and the penalty is
~15–20 cycles on a modern out-of-order CPU core. The branchless variant does not
have this cost, therefore it performs better. Above L2 capacity and when the
array is in L3 (or lower) cache, each miss costs 40-100+ cycles, way more than
the misprediction penalty. Now both variants are memory-bound, and branchless
one is at a disadvantage due to the additional instructions.
---

## P3 — Past L3, branchy and branchless approaches meet

**Prediction:** With datasets beyond the shared L3 cache (~36 MB, ~9M int32_t
elements), the difference in execution time between branchy and branchless
will be small enough to be inside the measurement noise.

**Explanation:** Since the working set exceeds L3, memory latency (~100 ns
per access, ~600 clock cycles at 5.8 GHz) fully determines the runtime of
both approaches with a miss being much more costly than mispredictions (~15
clock cycles) or additional instructions (~1-3 clock cycles). In other words,
the out-of-order engine cannot hide the memory latency with any instruction
stream.
---

## Secondary predictions (these are not the thesis, but are interesting to follow)

**P4:** GCC at `-O2` will replace the `if` conditional swap in `quicksort_branchy`
with a `cmov` instruction, at least for some input distributions, thus nullifying
the distinction made with this implementation approach.

**P5:** glibc `qsort` will be the slowest for all input sizes and input
distributions because of the function-pointer call for every element compare,
which precludes inlining and incurs call overhead for every element.

**P6:** `duplicates` input distribution will be the slowest for Lomuto
implementations (most equal pivot splits compared to any other input distribution,
thus worst case partitioning), but fastest for insertion sort (already mostly sorted
in value buckets).
