vm:	macro
	call	vm_rst
	endm

toBC:	macro
	call	pop_rst
	endm

fromBC:	macro
	call	push_rst
	endm

	org	0x8000
	exx
	push	hl
	exx
	ld	de, 0x4000
	ld	ix, vm_l

test:	vm
	defw	litE8
	defb	  e_pred - pred
pred:		ld	a, 1
		jp	(ix)
e_pred:		equ	$
	defw	litE8
	defb	  e_subj - subj
subj:		ld	a, 2
		jp	(ix)
e_subj:		equ	$
	defw	or
	defw	cpu

	pop	hl
	exx
	ret

	include	"vm_rst.asm"
	include	"execution.asm"
	include	"literals.asm"

	include	"sysvars.asm"
