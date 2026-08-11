	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 26, 0	sdk_version 26, 2
	.globl	_insertion_sort                 ; -- Begin function insertion_sort
	.p2align	2
_insertion_sort:                        ; @insertion_sort
	.cfi_startproc
; %bb.0:
	cmp	x1, #2
	b.lo	LBB0_8
; %bb.1:
	mov	x8, #0                          ; =0x0
	mov	w9, #1                          ; =0x1
	b	LBB0_4
LBB0_2:                                 ;   in Loop: Header=BB0_4 Depth=1
	add	x11, x11, #1
LBB0_3:                                 ;   in Loop: Header=BB0_4 Depth=1
	str	w10, [x0, x11, lsl #2]
	add	x9, x9, #1
	add	x8, x8, #1
	cmp	x9, x1
	b.eq	LBB0_8
LBB0_4:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB0_5 Depth 2
	ldr	w10, [x0, x9, lsl #2]
	mov	x11, x8
LBB0_5:                                 ;   Parent Loop BB0_4 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	add	x12, x0, x11, lsl #2
	ldr	w13, [x12]
	cmp	w13, w10
	b.le	LBB0_2
; %bb.6:                                ;   in Loop: Header=BB0_5 Depth=2
	str	w13, [x12, #4]
	sub	x11, x11, #1
	cmn	x11, #1
	b.ne	LBB0_5
; %bb.7:                                ;   in Loop: Header=BB0_4 Depth=1
	mov	x11, #0                         ; =0x0
	b	LBB0_3
LBB0_8:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_quicksort_branchy              ; -- Begin function quicksort_branchy
	.p2align	2
_quicksort_branchy:                     ; @quicksort_branchy
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	sub	sp, sp, #1040
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
Lloh0:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh1:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh2:
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	cmp	x1, #2
	b.hs	LBB1_3
LBB1_1:
	ldur	x8, [x29, #-24]
Lloh3:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh4:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh5:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB1_22
; %bb.2:
	add	sp, sp, #1040
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #32             ; 16-byte Folded Reload
	ret
LBB1_3:
	mov	x10, #0                         ; =0x0
	mov	w9, #0                          ; =0x0
	sub	x11, x1, #1
	add	x8, sp, #8
	b	LBB1_5
LBB1_4:                                 ;   in Loop: Header=BB1_5 Depth=1
	add	x13, x8, w9, sxtw #4
	sub	x14, x12, #1
	stp	x10, x14, [x13]
	add	w9, w9, #1
	cmp	x11, x12
	csinc	x10, x11, x12, ls
LBB1_5:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB1_14 Depth 2
	cmp	x10, x11
	b.hs	LBB1_20
; %bb.6:                                ;   in Loop: Header=BB1_5 Depth=1
	ldr	w13, [x0, x10, lsl #2]
	sub	x12, x11, x10
	lsr	x12, x12, #1
	add	x12, x0, x12, lsl #2
	ldr	w14, [x12, x10, lsl #2]
	cmp	w13, w14
	b.le	LBB1_8
; %bb.7:                                ;   in Loop: Header=BB1_5 Depth=1
	str	w14, [x0, x10, lsl #2]
	str	w13, [x12, x10, lsl #2]
LBB1_8:                                 ;   in Loop: Header=BB1_5 Depth=1
	ldr	w13, [x0, x10, lsl #2]
	ldr	w14, [x0, x11, lsl #2]
	cmp	w13, w14
	b.le	LBB1_10
; %bb.9:                                ;   in Loop: Header=BB1_5 Depth=1
	str	w14, [x0, x10, lsl #2]
	str	w13, [x0, x11, lsl #2]
LBB1_10:                                ;   in Loop: Header=BB1_5 Depth=1
	ldr	w13, [x12, x10, lsl #2]
	ldr	w14, [x0, x11, lsl #2]
	cmp	w13, w14
	b.le	LBB1_12
; %bb.11:                               ;   in Loop: Header=BB1_5 Depth=1
	str	w14, [x12, x10, lsl #2]
	str	w13, [x0, x11, lsl #2]
LBB1_12:                                ;   in Loop: Header=BB1_5 Depth=1
	ldr	w13, [x12, x10, lsl #2]
	ldr	w14, [x0, x11, lsl #2]
	str	w14, [x12, x10, lsl #2]
	str	w13, [x0, x11, lsl #2]
	mov	x14, x10
	mov	x12, x10
	b	LBB1_14
LBB1_13:                                ;   in Loop: Header=BB1_14 Depth=2
	add	x14, x14, #1
	cmp	x11, x14
	b.eq	LBB1_16
LBB1_14:                                ;   Parent Loop BB1_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	w15, [x0, x14, lsl #2]
	cmp	w15, w13
	b.ge	LBB1_13
; %bb.15:                               ;   in Loop: Header=BB1_14 Depth=2
	ldr	w16, [x0, x12, lsl #2]
	str	w15, [x0, x12, lsl #2]
	str	w16, [x0, x14, lsl #2]
	add	x12, x12, #1
	b	LBB1_13
LBB1_16:                                ;   in Loop: Header=BB1_5 Depth=1
	ldr	w13, [x0, x12, lsl #2]
	ldr	w14, [x0, x11, lsl #2]
	str	w14, [x0, x12, lsl #2]
	str	w13, [x0, x11, lsl #2]
	subs	x13, x12, x10
	csel	x13, xzr, x13, lo
	subs	x14, x11, x12
	csel	x14, xzr, x14, lo
	cmp	x13, x14
	b.hi	LBB1_4
; %bb.17:                               ;   in Loop: Header=BB1_5 Depth=1
	cmp	x11, x12
	b.ls	LBB1_19
; %bb.18:                               ;   in Loop: Header=BB1_5 Depth=1
	add	x13, x12, #1
	add	x14, x8, w9, sxtw #4
	stp	x13, x11, [x14]
	add	w9, w9, #1
LBB1_19:                                ;   in Loop: Header=BB1_5 Depth=1
	sub	x11, x12, #1
	cmp	x12, x10
	csel	x11, x11, x10, hi
	b	LBB1_5
LBB1_20:                                ;   in Loop: Header=BB1_5 Depth=1
	cbz	w9, LBB1_1
; %bb.21:                               ;   in Loop: Header=BB1_5 Depth=1
	sxtw	x9, w9
	sub	x9, x9, #1
	add	x11, x8, x9, lsl #4
	ldp	x10, x11, [x11]
                                        ; kill: def $w9 killed $w9 killed $x9 def $x9
	b	LBB1_5
LBB1_22:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh0, Lloh1, Lloh2
	.loh AdrpLdrGotLdr	Lloh3, Lloh4, Lloh5
	.cfi_endproc
                                        ; -- End function
	.globl	_quicksort_branchless           ; -- Begin function quicksort_branchless
	.p2align	2
_quicksort_branchless:                  ; @quicksort_branchless
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	sub	sp, sp, #1040
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
Lloh6:
	adrp	x8, ___stack_chk_guard@GOTPAGE
Lloh7:
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
Lloh8:
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	cmp	x1, #2
	b.hs	LBB2_3
LBB2_1:
	ldur	x8, [x29, #-24]
Lloh9:
	adrp	x9, ___stack_chk_guard@GOTPAGE
Lloh10:
	ldr	x9, [x9, ___stack_chk_guard@GOTPAGEOFF]
Lloh11:
	ldr	x9, [x9]
	cmp	x9, x8
	b.ne	LBB2_20
; %bb.2:
	add	sp, sp, #1040
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #32             ; 16-byte Folded Reload
	ret
LBB2_3:
	mov	x10, #0                         ; =0x0
	mov	w9, #0                          ; =0x0
	sub	x11, x1, #1
	add	x8, sp, #8
	b	LBB2_5
LBB2_4:                                 ;   in Loop: Header=BB2_5 Depth=1
	add	x13, x8, w9, sxtw #4
	sub	x14, x12, #1
	stp	x10, x14, [x13]
	add	w9, w9, #1
	cmp	x11, x12
	csinc	x10, x11, x12, ls
LBB2_5:                                 ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_13 Depth 2
	cmp	x10, x11
	b.hs	LBB2_18
; %bb.6:                                ;   in Loop: Header=BB2_5 Depth=1
	ldr	w13, [x0, x10, lsl #2]
	sub	x12, x11, x10
	lsr	x12, x12, #1
	add	x12, x0, x12, lsl #2
	ldr	w14, [x12, x10, lsl #2]
	cmp	w13, w14
	b.le	LBB2_8
; %bb.7:                                ;   in Loop: Header=BB2_5 Depth=1
	str	w14, [x0, x10, lsl #2]
	str	w13, [x12, x10, lsl #2]
LBB2_8:                                 ;   in Loop: Header=BB2_5 Depth=1
	ldr	w13, [x0, x10, lsl #2]
	ldr	w14, [x0, x11, lsl #2]
	cmp	w13, w14
	b.le	LBB2_10
; %bb.9:                                ;   in Loop: Header=BB2_5 Depth=1
	str	w14, [x0, x10, lsl #2]
	str	w13, [x0, x11, lsl #2]
LBB2_10:                                ;   in Loop: Header=BB2_5 Depth=1
	ldr	w13, [x12, x10, lsl #2]
	ldr	w14, [x0, x11, lsl #2]
	cmp	w13, w14
	b.le	LBB2_12
; %bb.11:                               ;   in Loop: Header=BB2_5 Depth=1
	str	w14, [x12, x10, lsl #2]
	str	w13, [x0, x11, lsl #2]
LBB2_12:                                ;   in Loop: Header=BB2_5 Depth=1
	ldr	w13, [x12, x10, lsl #2]
	ldr	w14, [x0, x11, lsl #2]
	str	w14, [x12, x10, lsl #2]
	str	w13, [x0, x11, lsl #2]
	mov	x14, x10
	mov	x12, x10
LBB2_13:                                ;   Parent Loop BB2_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	w15, [x0, x12, lsl #2]
	ldr	w16, [x0, x14, lsl #2]
	str	w16, [x0, x12, lsl #2]
	str	w15, [x0, x14, lsl #2]
	ldr	w15, [x0, x12, lsl #2]
	cmp	w15, w13
	cinc	x12, x12, lt
	add	x14, x14, #1
	cmp	x11, x14
	b.ne	LBB2_13
; %bb.14:                               ;   in Loop: Header=BB2_5 Depth=1
	ldr	w13, [x0, x12, lsl #2]
	ldr	w14, [x0, x11, lsl #2]
	str	w14, [x0, x12, lsl #2]
	str	w13, [x0, x11, lsl #2]
	subs	x13, x12, x10
	csel	x13, xzr, x13, lo
	subs	x14, x11, x12
	csel	x14, xzr, x14, lo
	cmp	x13, x14
	b.hi	LBB2_4
; %bb.15:                               ;   in Loop: Header=BB2_5 Depth=1
	cmp	x11, x12
	b.ls	LBB2_17
; %bb.16:                               ;   in Loop: Header=BB2_5 Depth=1
	add	x13, x12, #1
	add	x14, x8, w9, sxtw #4
	stp	x13, x11, [x14]
	add	w9, w9, #1
LBB2_17:                                ;   in Loop: Header=BB2_5 Depth=1
	sub	x11, x12, #1
	cmp	x12, x10
	csel	x11, x11, x10, hi
	b	LBB2_5
LBB2_18:                                ;   in Loop: Header=BB2_5 Depth=1
	cbz	w9, LBB2_1
; %bb.19:                               ;   in Loop: Header=BB2_5 Depth=1
	sxtw	x9, w9
	sub	x9, x9, #1
	add	x11, x8, x9, lsl #4
	ldp	x10, x11, [x11]
                                        ; kill: def $w9 killed $w9 killed $x9 def $x9
	b	LBB2_5
LBB2_20:
	bl	___stack_chk_fail
	.loh AdrpLdrGotLdr	Lloh6, Lloh7, Lloh8
	.loh AdrpLdrGotLdr	Lloh9, Lloh10, Lloh11
	.cfi_endproc
                                        ; -- End function
	.globl	_stdlib_qsort                   ; -- Begin function stdlib_qsort
	.p2align	2
_stdlib_qsort:                          ; @stdlib_qsort
	.cfi_startproc
; %bb.0:
Lloh12:
	adrp	x3, _cmp_int32@PAGE
Lloh13:
	add	x3, x3, _cmp_int32@PAGEOFF
	mov	w2, #4                          ; =0x4
	b	_qsort
	.loh AdrpAdd	Lloh12, Lloh13
	.cfi_endproc
                                        ; -- End function
	.p2align	2                               ; -- Begin function cmp_int32
_cmp_int32:                             ; @cmp_int32
	.cfi_startproc
; %bb.0:
	ldr	w8, [x0]
	ldr	w9, [x1]
	cmp	w8, w9
	cset	w8, gt
	cset	w9, lt
	sub	w0, w8, w9
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
