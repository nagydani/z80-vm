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
	ld	hl, 0x4000
	ld	(DP), hl
	ld	de, 0x5000
	ld	ix, vm_l

test:	vm

	defw	litS8
	defb	  cd_e - cd
cd:		vm
		defw	litN16, 5
		defw	countdown
		defw	drop
		defw	fail
cd_e:	defw	litN16,  carrynx
	defw	or

	defw	cpu

	pop	hl
	exx
	ret

	include	"vm_rst.asm"
	include	"execution.asm"
	include	"literals.asm"
	include "stack.asm"
	include	"arithmetics.asm"
	include "generators.asm"

	include	"sysvars.asm"
