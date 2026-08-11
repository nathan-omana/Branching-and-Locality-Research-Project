# Assembly Annotation — CMPT 295 Mini-Project

**Platform:** Apple Silicon (arm64), Apple clang 17, `-march=native`  
---

## Key finding: partition_branchy inner loop (O2)

Sourced from `sorts_O2.s`, lines 129–143 (`_qs_branchy_impl`, inner loop).

```asm
; ── partition_branchy inner loop ────────────────────────────────────────
LBB2_10:                         ; j++ and loop-back
    add  x9, x9, #1              ; j++
    cmp  x21, x9                 ; j == hi?
    b.eq LBB2_13                 ; exit if so (loop-exit branch — predictable)

LBB2_11:                         ; inner loop header
    ldr  w10, [x19, x9, lsl #2] ; w10 = a[j]
    cmp  w10, w8                 ; a[j] < pivot?
    b.ge LBB2_10                 ; ← DATA-DEPENDENT BRANCH: skip swap if a[j] >= pivot
                                 ;   ~50% misprediction on random input

; (fall-through when a[j] < pivot — do the swap)
    ldr  w11, [x19, x22, lsl #2] ; w11 = a[i]
    str  w10, [x19, x22, lsl #2] ; a[i] = a[j]
    str  w11, [x19, x9,  lsl #2] ; a[j] = old a[i]
    add  x22, x22, #1            ; i++
    b    LBB2_10
```

**The `b.ge` at line 137 is data-dependent.** On random input, pivot
falls approx. in the middle of the value range. Due to this, half of elements are < pivot and half are >=.  The branch predictor sees a near-random pattern — ~50% misprediction rate.

**Apple clang at O2 did NOT convert `if` into a conditional instruction.**

---

## Key finding: partition_branchless inner loop (O2)

Sourced from `sorts_O2.s`, lines 261–272 (`_qs_branchless_impl`, inner loop).

```asm
; ── partition_branchless inner loop ─────────────────────────────────────
LBB4_10:                          ; inner loop (no separate entry needed)
    ldr  w10, [x19, x22, lsl #2]  ; w10 = a[i]
    ldr  w11, [x19, x9,  lsl #2]  ; w11 = a[j]
    str  w11, [x19, x22, lsl #2]  ; a[i] = a[j]  — unconditional swap (part 1)
    str  w10, [x19, x9,  lsl #2]  ; a[j] = old a[i]  — unconditional swap (part 2)
    ldr  w10, [x19, x22, lsl #2]  ; reload a[i] (now holds original a[j])
    cmp  w10, w8                   ; original a[j] < pivot?
    cinc x22, x22, lt              ; ← CONDITIONAL INCREMENT — NO BRANCH
                                   ;   i += (a[i] < pivot), emitted as cinc
    add  x9, x9, #1               ; j++
    cmp  x21, x9                   ; j == hi? (predictable loop counter)
    b.ne LBB4_10                   ; loop back
```

The `cinc x22, x22, lt` instruction, meaning "conditional increment if less-than," is the ARM64 equivalent of `cmov` / `add` with a zero-extended predicate on x86. It is one instruction without any branching; the processor always executes it, and the output is either `x22` or `x22 + 1`.

**No data-dependent branch in the inner loop.** The only branch is `b.ne LBB4_10` (the loop counter), which is highly predictable.

---

## Instruction count comparison

Branchless always executes more instructions..  avoids misprediction.
The crossover depends on whether misprediction cost > extra instruction cost.
