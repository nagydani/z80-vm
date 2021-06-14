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
	ld	a, 10
	ld	(BASE), a
	ld	hl, 0x4000
	ld	(DP), hl
	ld	de, 0x5000
	ld	ix, vm_l

test:	vm

	defw	litS8
	defb	  fteste - ftest
ftest:		vm
		defw	litN16, 300
		defw	countdown
		defw	alphanum
		defw	odd
		defw	emit
		defw	fail
fteste:	defw	litN16, ok
	defw	or

	defw	cpu

	pop	hl
	exx
	ret

emit:	dec	de
	dec	de
	ld	a, (de)
	push	ix
	rst	0x10
	pop	ix
ok:	jp	(ix)

	include	"vm_rst.asm"
	include	"execution.asm"
	include	"literals.asm"
	include "stack.asm"
	include	"arithmetics.asm"
	include "generators.asm"
	include "chars.asm"

	include	"sysvars.asm"
