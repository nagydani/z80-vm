; for z80sim

vm:	macro
	rst	vm_rst
	endm

toBC:	macro
	rst	pop_rst
	endm

fromBC:	macro
	rst	push_rst
	endm

	org	0
	jp	start

	defs	8 - $
	include	"vm_rst.asm"

bye_link:
	defw	0
	defb	"bye", 0
	defw	comma

bye:	halt

emit_link:
	defw	bye_link
	defb	"emit", 0
	defw	comma

emit:	dec	de
	dec	de
	ld	a, (de)
	cp	0x0D
	jr	nz, emit1
	ld	a, 0x0A
emit1:	out	(0), a
	jp	(ix)


link_final_io:
key_link:
	defw	emit_link
	defb	"key", 0
	defw	comma

key:	in	a, (0)
	ld	(de), a
	inc	de
	xor	a
	ld	(de), a
	inc	de
	jp	(ix)

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

start:	ld	a, 10
	ld	(BASE), a
	ld	hl, 0x4000
	ld	(DP), hl
	ld	hl, link_final
	ld	(CONTEXT), hl
	ld	de, 0xc000
	ld	ix, vm_l

test:	ld	hl, 0xFF00
	ld	(TIB), hl
keyl:	in	a, (0)
	cp	0xA
	jr	z, keyle
	ld	(hl), a
	inc	hl
	ld	a, h
	and	l
	inc	a
	jr	nz, keyl
keyle:	ld	(hl), 0

	vm

	defw	litN16, interpret
	defw	litN16, ok
	defw	or

	defw	cpu
	jr	test

testline:
	defb	"3 5 + . words ", 0



	include	"sysvars.asm"
