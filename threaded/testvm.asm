vm:	macro
	call	vm_rst
	endm

toBC:	macro
	call	pop_rst
	endm

fromBC:	macro
	call	push_rst
	endm

dat:	macro
	call	dat_rst
	endm

STK_BOT:equ	0x5B00

	org	0x8000
	exx
	push	hl
	exx
	ld	a, 16
	ld	(BASE), a
	ld	hl, 0x5800
	ld	(DP), hl
	ld	hl, link_final
	ld	(CONTEXT), hl
	ld	hl, testline
	ld	(TIB), hl
	ld	de, STK_BOT
	ld	ix, vm_l

test:	vm

	defw	litN16, interpret
	defw	tickidor

	defw	cpu

	pop	hl
	exx
	ret

testline:
	defb	"\" Hello world!\" type ", 0


link_final_io:
emit_link:
	defw	0
	defb	"emit", 0
	defw	comma

emit:	dec	de
	dec	de
	ld	a, (de)
	push	ix
	rst	0x10
	pop	ix
	jp	(ix)

	include	"vm_rst.asm"
	include	"literals.asm"
	include	"execution.asm"
	include	"dictionary.asm"
	include "stack.asm"
	include	"arithmetics.asm"
	include "generators.asm"
	include "chars.asm"
	include	"input.asm"
	include "output.asm"
	include "vocabulary.asm"
	include "interpreter.asm"
	include "compiler.asm"
	include "debug.asm"

	include	"sysvars.asm"
