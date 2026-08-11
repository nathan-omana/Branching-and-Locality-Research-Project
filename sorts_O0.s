	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 26, 0	sdk_version 26, 2
	.globl	_insertion_sort                 ; -- Begin function insertion_sort
	.p2align	2
_insertion_sort:                        ; @insertion_sort
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	str	x0, [sp, #40]
	str	x1, [sp, #32]
	mov	x8, #1                          ; =0x1
	str	x8, [sp, #24]
	b	LBB0_1
LBB0_1:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_3 Depth 2
	ldr	x8, [sp, #24]
	ldr	x9, [sp, #32]
	subs	x8, x8, x9
	b.hs	LBB0_9
	b	LBB0_2
LBB0_2:                                 ;   in Loop: Header=BB0_1 Depth=1
	ldr	x8, [sp, #40]
	ldr	x9, [sp, #24]
	ldr	w8, [x8, x9, lsl #2]
	str	w8, [sp, #20]
	ldr	x8, [sp, #24]
	str	x8, [sp, #8]
	b	LBB0_3
LBB0_3:                                 ;   Parent Loop BB0_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x9, [sp, #8]
	mov	w8, #0                          ; =0x0
	subs	x9, x9, #0
	str	w8, [sp, #4]                    ; 4-byte Folded Spill
	b.ls	LBB0_5
	b	LBB0_4
LBB0_4:                                 ;   in Loop: Header=BB0_3 Depth=2
	ldr	x8, [sp, #40]
	ldr	x9, [sp, #8]
	subs	x9, x9, #1
	ldr	w8, [x8, x9, lsl #2]
	ldr	w9, [sp, #20]
	subs	w8, w8, w9
	cset	w8, gt
	str	w8, [sp, #4]                    ; 4-byte Folded Spill
	b	LBB0_5
LBB0_5:                                 ;   in Loop: Header=BB0_3 Depth=2
	ldr	w8, [sp, #4]                    ; 4-byte Folded Reload
	tbz	w8, #0, LBB0_7
	b	LBB0_6
LBB0_6:                                 ;   in Loop: Header=BB0_3 Depth=2
	ldr	x8, [sp, #40]
	ldr	x9, [sp, #8]
	subs	x9, x9, #1
	ldr	w8, [x8, x9, lsl #2]
	ldr	x9, [sp, #40]
	ldr	x10, [sp, #8]
	str	w8, [x9, x10, lsl #2]
	ldr	x8, [sp, #8]
	subs	x8, x8, #1
	str	x8, [sp, #8]
	b	LBB0_3
LBB0_7:                                 ;   in Loop: Header=BB0_1 Depth=1
	ldr	w8, [sp, #20]
	ldr	x9, [sp, #40]
	ldr	x10, [sp, #8]
	str	w8, [x9, x10, lsl #2]
	b	LBB0_8
LBB0_8:                                 ;   in Loop: Header=BB0_1 Depth=1
	ldr	x8, [sp, #24]
	add	x8, x8, #1
	str	x8, [sp, #24]
	b	LBB0_1
LBB0_9:
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_quicksort_branchy              ; -- Begin function quicksort_branchy
	.p2align	2
_quicksort_branchy:                     ; @quicksort_branchy
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	str	x1, [sp]
	ldr	x0, [sp, #8]
	ldr	x1, [sp]
	bl	_qs_branchy_impl
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function qs_branchy_impl
_qs_branchy_impl:                       ; @qs_branchy_impl
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	sub	sp, sp, #1136
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #96]
	str	x1, [sp, #88]
	ldr	x8, [sp, #88]
	subs	x8, x8, #2
	b.hs	LBB2_2
	b	LBB2_1
LBB2_1:
	b	LBB2_28
LBB2_2:
	str	wzr, [sp, #84]
	str	xzr, [sp, #72]
	ldr	x8, [sp, #88]
	subs	x8, x8, #1
	str	x8, [sp, #64]
	b	LBB2_3
LBB2_3:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_4 Depth 2
	b	LBB2_4
LBB2_4:                                 ;   Parent Loop BB2_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #72]
	ldr	x9, [sp, #64]
	subs	x8, x8, x9
	b.hs	LBB2_25
	b	LBB2_5
LBB2_5:                                 ;   in Loop: Header=BB2_4 Depth=2
	ldr	x0, [sp, #96]
	ldr	x1, [sp, #72]
	ldr	x2, [sp, #64]
	bl	_partition_branchy
	str	x0, [sp, #56]
	ldr	x8, [sp, #56]
	ldr	x9, [sp, #72]
	subs	x8, x8, x9
	b.ls	LBB2_7
	b	LBB2_6
LBB2_6:                                 ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #56]
	ldr	x9, [sp, #72]
	subs	x8, x8, x9
	str	x8, [sp, #32]                   ; 8-byte Folded Spill
	b	LBB2_8
LBB2_7:                                 ;   in Loop: Header=BB2_4 Depth=2
	mov	x8, #0                          ; =0x0
	str	x8, [sp, #32]                   ; 8-byte Folded Spill
	b	LBB2_8
LBB2_8:                                 ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #32]                   ; 8-byte Folded Reload
	str	x8, [sp, #48]
	ldr	x8, [sp, #56]
	ldr	x9, [sp, #64]
	subs	x8, x8, x9
	b.hs	LBB2_10
	b	LBB2_9
LBB2_9:                                 ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #64]
	ldr	x9, [sp, #56]
	subs	x8, x8, x9
	str	x8, [sp, #24]                   ; 8-byte Folded Spill
	b	LBB2_11
LBB2_10:                                ;   in Loop: Header=BB2_4 Depth=2
	mov	x8, #0                          ; =0x0
	str	x8, [sp, #24]                   ; 8-byte Folded Spill
	b	LBB2_11
LBB2_11:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #24]                   ; 8-byte Folded Reload
	str	x8, [sp, #40]
	ldr	x8, [sp, #48]
	ldr	x9, [sp, #40]
	subs	x8, x8, x9
	b.hi	LBB2_18
	b	LBB2_12
LBB2_12:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #40]
	subs	x8, x8, #0
	b.ls	LBB2_14
	b	LBB2_13
LBB2_13:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #56]
	add	x8, x8, #1
	ldrsw	x9, [sp, #84]
	lsl	x10, x9, #4
	add	x9, sp, #104
	str	x8, [x9, x10]
	ldr	x8, [sp, #64]
	ldrsw	x10, [sp, #84]
	add	x9, x9, x10, lsl #4
	str	x8, [x9, #8]
	ldr	w8, [sp, #84]
	add	w8, w8, #1
	str	w8, [sp, #84]
	b	LBB2_14
LBB2_14:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #48]
	subs	x8, x8, #0
	b.ls	LBB2_16
	b	LBB2_15
LBB2_15:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #56]
	subs	x8, x8, #1
	str	x8, [sp, #16]                   ; 8-byte Folded Spill
	b	LBB2_17
LBB2_16:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #72]
	str	x8, [sp, #16]                   ; 8-byte Folded Spill
	b	LBB2_17
LBB2_17:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #16]                   ; 8-byte Folded Reload
	str	x8, [sp, #64]
	b	LBB2_24
LBB2_18:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #48]
	subs	x8, x8, #0
	b.ls	LBB2_20
	b	LBB2_19
LBB2_19:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #72]
	ldrsw	x9, [sp, #84]
	lsl	x10, x9, #4
	add	x9, sp, #104
	str	x8, [x9, x10]
	ldr	x8, [sp, #56]
	subs	x8, x8, #1
	ldrsw	x10, [sp, #84]
	add	x9, x9, x10, lsl #4
	str	x8, [x9, #8]
	ldr	w8, [sp, #84]
	add	w8, w8, #1
	str	w8, [sp, #84]
	b	LBB2_20
LBB2_20:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #40]
	subs	x8, x8, #0
	b.ls	LBB2_22
	b	LBB2_21
LBB2_21:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #56]
	add	x8, x8, #1
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	b	LBB2_23
LBB2_22:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #64]
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	b	LBB2_23
LBB2_23:                                ;   in Loop: Header=BB2_4 Depth=2
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	str	x8, [sp, #72]
	b	LBB2_24
LBB2_24:                                ;   in Loop: Header=BB2_4 Depth=2
	b	LBB2_4
LBB2_25:                                ;   in Loop: Header=BB2_3 Depth=1
	ldr	w8, [sp, #84]
	cbnz	w8, LBB2_27
	b	LBB2_26
LBB2_26:
	b	LBB2_28
LBB2_27:                                ;   in Loop: Header=BB2_3 Depth=1
	ldr	w8, [sp, #84]
	subs	w8, w8, #1
	str	w8, [sp, #84]
	ldrsw	x8, [sp, #84]
	lsl	x9, x8, #4
	add	x8, sp, #104
	ldr	x9, [x8, x9]
	str	x9, [sp, #72]
	ldrsw	x9, [sp, #84]
	add	x8, x8, x9, lsl #4
	ldr	x8, [x8, #8]
	str	x8, [sp, #64]
	b	LBB2_3
LBB2_28:
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	b.eq	LBB2_30
	b	LBB2_29
LBB2_29:
	bl	___stack_chk_fail
LBB2_30:
	add	sp, sp, #1136
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_quicksort_branchless           ; -- Begin function quicksort_branchless
	.p2align	2
_quicksort_branchless:                  ; @quicksort_branchless
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	str	x1, [sp]
	ldr	x0, [sp, #8]
	ldr	x1, [sp]
	bl	_qs_branchless_impl
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function qs_branchless_impl
_qs_branchless_impl:                    ; @qs_branchless_impl
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	sub	sp, sp, #1136
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #96]
	str	x1, [sp, #88]
	ldr	x8, [sp, #88]
	subs	x8, x8, #2
	b.hs	LBB4_2
	b	LBB4_1
LBB4_1:
	b	LBB4_28
LBB4_2:
	str	wzr, [sp, #84]
	str	xzr, [sp, #72]
	ldr	x8, [sp, #88]
	subs	x8, x8, #1
	str	x8, [sp, #64]
	b	LBB4_3
LBB4_3:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB4_4 Depth 2
	b	LBB4_4
LBB4_4:                                 ;   Parent Loop BB4_3 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	x8, [sp, #72]
	ldr	x9, [sp, #64]
	subs	x8, x8, x9
	b.hs	LBB4_25
	b	LBB4_5
LBB4_5:                                 ;   in Loop: Header=BB4_4 Depth=2
	ldr	x0, [sp, #96]
	ldr	x1, [sp, #72]
	ldr	x2, [sp, #64]
	bl	_partition_branchless
	str	x0, [sp, #56]
	ldr	x8, [sp, #56]
	ldr	x9, [sp, #72]
	subs	x8, x8, x9
	b.ls	LBB4_7
	b	LBB4_6
LBB4_6:                                 ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #56]
	ldr	x9, [sp, #72]
	subs	x8, x8, x9
	str	x8, [sp, #32]                   ; 8-byte Folded Spill
	b	LBB4_8
LBB4_7:                                 ;   in Loop: Header=BB4_4 Depth=2
	mov	x8, #0                          ; =0x0
	str	x8, [sp, #32]                   ; 8-byte Folded Spill
	b	LBB4_8
LBB4_8:                                 ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #32]                   ; 8-byte Folded Reload
	str	x8, [sp, #48]
	ldr	x8, [sp, #56]
	ldr	x9, [sp, #64]
	subs	x8, x8, x9
	b.hs	LBB4_10
	b	LBB4_9
LBB4_9:                                 ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #64]
	ldr	x9, [sp, #56]
	subs	x8, x8, x9
	str	x8, [sp, #24]                   ; 8-byte Folded Spill
	b	LBB4_11
LBB4_10:                                ;   in Loop: Header=BB4_4 Depth=2
	mov	x8, #0                          ; =0x0
	str	x8, [sp, #24]                   ; 8-byte Folded Spill
	b	LBB4_11
LBB4_11:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #24]                   ; 8-byte Folded Reload
	str	x8, [sp, #40]
	ldr	x8, [sp, #48]
	ldr	x9, [sp, #40]
	subs	x8, x8, x9
	b.hi	LBB4_18
	b	LBB4_12
LBB4_12:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #40]
	subs	x8, x8, #0
	b.ls	LBB4_14
	b	LBB4_13
LBB4_13:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #56]
	add	x8, x8, #1
	ldrsw	x9, [sp, #84]
	lsl	x10, x9, #4
	add	x9, sp, #104
	str	x8, [x9, x10]
	ldr	x8, [sp, #64]
	ldrsw	x10, [sp, #84]
	add	x9, x9, x10, lsl #4
	str	x8, [x9, #8]
	ldr	w8, [sp, #84]
	add	w8, w8, #1
	str	w8, [sp, #84]
	b	LBB4_14
LBB4_14:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #48]
	subs	x8, x8, #0
	b.ls	LBB4_16
	b	LBB4_15
LBB4_15:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #56]
	subs	x8, x8, #1
	str	x8, [sp, #16]                   ; 8-byte Folded Spill
	b	LBB4_17
LBB4_16:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #72]
	str	x8, [sp, #16]                   ; 8-byte Folded Spill
	b	LBB4_17
LBB4_17:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #16]                   ; 8-byte Folded Reload
	str	x8, [sp, #64]
	b	LBB4_24
LBB4_18:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #48]
	subs	x8, x8, #0
	b.ls	LBB4_20
	b	LBB4_19
LBB4_19:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #72]
	ldrsw	x9, [sp, #84]
	lsl	x10, x9, #4
	add	x9, sp, #104
	str	x8, [x9, x10]
	ldr	x8, [sp, #56]
	subs	x8, x8, #1
	ldrsw	x10, [sp, #84]
	add	x9, x9, x10, lsl #4
	str	x8, [x9, #8]
	ldr	w8, [sp, #84]
	add	w8, w8, #1
	str	w8, [sp, #84]
	b	LBB4_20
LBB4_20:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #40]
	subs	x8, x8, #0
	b.ls	LBB4_22
	b	LBB4_21
LBB4_21:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #56]
	add	x8, x8, #1
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	b	LBB4_23
LBB4_22:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #64]
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	b	LBB4_23
LBB4_23:                                ;   in Loop: Header=BB4_4 Depth=2
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	str	x8, [sp, #72]
	b	LBB4_24
LBB4_24:                                ;   in Loop: Header=BB4_4 Depth=2
	b	LBB4_4
LBB4_25:                                ;   in Loop: Header=BB4_3 Depth=1
	ldr	w8, [sp, #84]
	cbnz	w8, LBB4_27
	b	LBB4_26
LBB4_26:
	b	LBB4_28
LBB4_27:                                ;   in Loop: Header=BB4_3 Depth=1
	ldr	w8, [sp, #84]
	subs	w8, w8, #1
	str	w8, [sp, #84]
	ldrsw	x8, [sp, #84]
	lsl	x9, x8, #4
	add	x8, sp, #104
	ldr	x9, [x8, x9]
	str	x9, [sp, #72]
	ldrsw	x9, [sp, #84]
	add	x8, x8, x9, lsl #4
	ldr	x8, [x8, #8]
	str	x8, [sp, #64]
	b	LBB4_3
LBB4_28:
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	b.eq	LBB4_30
	b	LBB4_29
LBB4_29:
	bl	___stack_chk_fail
LBB4_30:
	add	sp, sp, #1136
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_stdlib_qsort                   ; -- Begin function stdlib_qsort
	.p2align	2
_stdlib_qsort:                          ; @stdlib_qsort
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	str	x1, [sp]
	ldr	x0, [sp, #8]
	ldr	x1, [sp]
	mov	x2, #4                          ; =0x4
	adrp	x3, _cmp_int32@PAGE
	add	x3, x3, _cmp_int32@PAGEOFF
	bl	_qsort
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function cmp_int32
_cmp_int32:                             ; @cmp_int32
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	x0, [sp, #24]
	str	x1, [sp, #16]
	ldr	x8, [sp, #24]
	ldr	w8, [x8]
	str	w8, [sp, #12]
	ldr	x8, [sp, #16]
	ldr	w8, [x8]
	str	w8, [sp, #8]
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #8]
	subs	w8, w8, w9
	cset	w8, gt
	ldr	w9, [sp, #12]
	ldr	w10, [sp, #8]
	subs	w9, w9, w10
	cset	w9, lt
	subs	w0, w8, w9
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function partition_branchy
_partition_branchy:                     ; @partition_branchy
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	stur	x2, [x29, #-24]
	ldur	x8, [x29, #-16]
	ldur	x9, [x29, #-24]
	ldur	x10, [x29, #-16]
	subs	x9, x9, x10
	mov	x10, #2                         ; =0x2
	udiv	x9, x9, x10
	add	x8, x8, x9
	str	x8, [sp, #32]
	ldur	x0, [x29, #-8]
	ldur	x1, [x29, #-16]
	ldr	x2, [sp, #32]
	ldur	x3, [x29, #-24]
	bl	_median_of_three
	ldur	x10, [x29, #-8]
	ldr	x11, [sp, #32]
	ldur	x8, [x29, #-8]
	ldur	x9, [x29, #-24]
	add	x0, x10, x11, lsl #2
	add	x1, x8, x9, lsl #2
	bl	_swap32
	ldur	x8, [x29, #-8]
	ldur	x9, [x29, #-24]
	ldr	w8, [x8, x9, lsl #2]
	str	w8, [sp, #28]
	ldur	x8, [x29, #-16]
	str	x8, [sp, #16]
	ldur	x8, [x29, #-16]
	str	x8, [sp, #8]
	b	LBB7_1
LBB7_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #8]
	ldur	x9, [x29, #-24]
	subs	x8, x8, x9
	b.hs	LBB7_6
	b	LBB7_2
LBB7_2:                                 ;   in Loop: Header=BB7_1 Depth=1
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #8]
	ldr	w8, [x8, x9, lsl #2]
	ldr	w9, [sp, #28]
	subs	w8, w8, w9
	b.ge	LBB7_4
	b	LBB7_3
LBB7_3:                                 ;   in Loop: Header=BB7_1 Depth=1
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #16]
	add	x0, x8, x9, lsl #2
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #8]
	add	x1, x8, x9, lsl #2
	bl	_swap32
	ldr	x8, [sp, #16]
	add	x8, x8, #1
	str	x8, [sp, #16]
	b	LBB7_4
LBB7_4:                                 ;   in Loop: Header=BB7_1 Depth=1
	b	LBB7_5
LBB7_5:                                 ;   in Loop: Header=BB7_1 Depth=1
	ldr	x8, [sp, #8]
	add	x8, x8, #1
	str	x8, [sp, #8]
	b	LBB7_1
LBB7_6:
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #16]
	add	x0, x8, x9, lsl #2
	ldur	x8, [x29, #-8]
	ldur	x9, [x29, #-24]
	add	x1, x8, x9, lsl #2
	bl	_swap32
	ldr	x0, [sp, #16]
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function median_of_three
_median_of_three:                       ; @median_of_three
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	str	x2, [sp, #8]
	str	x3, [sp]
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #16]
	ldr	w8, [x8, x9, lsl #2]
	ldur	x9, [x29, #-8]
	ldr	x10, [sp, #8]
	ldr	w9, [x9, x10, lsl #2]
	subs	w8, w8, w9
	b.le	LBB8_2
	b	LBB8_1
LBB8_1:
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #16]
	add	x0, x8, x9, lsl #2
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #8]
	add	x1, x8, x9, lsl #2
	bl	_swap32
	b	LBB8_2
LBB8_2:
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #16]
	ldr	w8, [x8, x9, lsl #2]
	ldur	x9, [x29, #-8]
	ldr	x10, [sp]
	ldr	w9, [x9, x10, lsl #2]
	subs	w8, w8, w9
	b.le	LBB8_4
	b	LBB8_3
LBB8_3:
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #16]
	add	x0, x8, x9, lsl #2
	ldur	x8, [x29, #-8]
	ldr	x9, [sp]
	add	x1, x8, x9, lsl #2
	bl	_swap32
	b	LBB8_4
LBB8_4:
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #8]
	ldr	w8, [x8, x9, lsl #2]
	ldur	x9, [x29, #-8]
	ldr	x10, [sp]
	ldr	w9, [x9, x10, lsl #2]
	subs	w8, w8, w9
	b.le	LBB8_6
	b	LBB8_5
LBB8_5:
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #8]
	add	x0, x8, x9, lsl #2
	ldur	x8, [x29, #-8]
	ldr	x9, [sp]
	add	x1, x8, x9, lsl #2
	bl	_swap32
	b	LBB8_6
LBB8_6:
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #8]
	ldr	w0, [x8, x9, lsl #2]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function swap32
_swap32:                                ; @swap32
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	str	x0, [sp, #24]
	str	x1, [sp, #16]
	ldr	x8, [sp, #24]
	ldr	w8, [x8]
	str	w8, [sp, #12]
	ldr	x8, [sp, #16]
	ldr	w8, [x8]
	ldr	x9, [sp, #24]
	str	w8, [x9]
	ldr	w8, [sp, #12]
	ldr	x9, [sp, #16]
	str	w8, [x9]
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function partition_branchless
_partition_branchless:                  ; @partition_branchless
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	stp	x29, x30, [sp, #64]             ; 16-byte Folded Spill
	add	x29, sp, #64
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	stur	x2, [x29, #-24]
	ldur	x8, [x29, #-16]
	ldur	x9, [x29, #-24]
	ldur	x10, [x29, #-16]
	subs	x9, x9, x10
	mov	x10, #2                         ; =0x2
	udiv	x9, x9, x10
	add	x8, x8, x9
	str	x8, [sp, #32]
	ldur	x0, [x29, #-8]
	ldur	x1, [x29, #-16]
	ldr	x2, [sp, #32]
	ldur	x3, [x29, #-24]
	bl	_median_of_three
	ldur	x10, [x29, #-8]
	ldr	x11, [sp, #32]
	ldur	x8, [x29, #-8]
	ldur	x9, [x29, #-24]
	add	x0, x10, x11, lsl #2
	add	x1, x8, x9, lsl #2
	bl	_swap32
	ldur	x8, [x29, #-8]
	ldur	x9, [x29, #-24]
	ldr	w8, [x8, x9, lsl #2]
	str	w8, [sp, #28]
	ldur	x8, [x29, #-16]
	str	x8, [sp, #16]
	ldur	x8, [x29, #-16]
	str	x8, [sp, #8]
	b	LBB10_1
LBB10_1:                                ; =>This Inner Loop Header: Depth=1
	ldr	x8, [sp, #8]
	ldur	x9, [x29, #-24]
	subs	x8, x8, x9
	b.hs	LBB10_4
	b	LBB10_2
LBB10_2:                                ;   in Loop: Header=BB10_1 Depth=1
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #16]
	add	x0, x8, x9, lsl #2
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #8]
	add	x1, x8, x9, lsl #2
	bl	_swap32
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #16]
	ldr	w8, [x8, x9, lsl #2]
	ldr	w9, [sp, #28]
	subs	w8, w8, w9
	cset	w9, lt
                                        ; implicit-def: $x8
	mov	x8, x9
	and	x9, x8, #0x1
	ldr	x8, [sp, #16]
	add	x8, x8, x9
	str	x8, [sp, #16]
	b	LBB10_3
LBB10_3:                                ;   in Loop: Header=BB10_1 Depth=1
	ldr	x8, [sp, #8]
	add	x8, x8, #1
	str	x8, [sp, #8]
	b	LBB10_1
LBB10_4:
	ldur	x8, [x29, #-8]
	ldr	x9, [sp, #16]
	add	x0, x8, x9, lsl #2
	ldur	x8, [x29, #-8]
	ldur	x9, [x29, #-24]
	add	x1, x8, x9, lsl #2
	bl	_swap32
	ldr	x0, [sp, #16]
	ldp	x29, x30, [sp, #64]             ; 16-byte Folded Reload
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
