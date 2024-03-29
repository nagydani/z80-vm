; for z80sim

vm:	macro
	rst	vm_rst
	endm

dat:	macro
	rst	dat_rst
	endm

toBC:	macro
	rst	pop_rst
	endm

fromBC:	macro
	rst	push_rst
	endm

STK_BOT:equ	0xC000

	org	0
	jp	start

	defs	8 - $
	include	"vm_rst.asm"


empty_link:
	defw	0
	defb	0
	defw	emptyc

empty:	vm
	defw	litS8
	defb	  ioke - iok
iok:		defb	" ok", 0
ioke:	defw	type
	defw	cr
	defw	tail, input

emptyc:	vm
	defw	drop
	defw	tail, input

input_link:
	defw	empty_link
	defb	"input", 0
	defw	comma

input:	push	hl
	ld	hl, 0xFF00
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
	pop	hl
	jp	(ix)

bye_link:
	defw	input_link
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
	out	(0), a
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

	include "comments.asm"
	include	"literals.asm"
	include	"execution.asm"
	include	"dictionary.asm"
	include "stack.asm"
	include	"arithmetics.asm"
	include "generators.asm"
	include "chars.asm"
	include	"input.asm"
	include "output.asm"
	include "interpreter.asm"
	include "vocabulary.asm"
	include	"compiler.asm"
	include	"debug.asm"

start:	ld	a, 10
	ld	(BASE), a
	ld	hl, DICTIONARY
	ld	(DP), hl
	ld	hl, seedv
	ld	(CONTEXT), hl
	ld	(CURRENT), hl
	ld	de, STK_BOT
	ld	ix, vm_l

seedl:	vm

	defw	input
	defw	litN16, interpret
	defw	litS8
	defb	  seedlfe - seedlf
seedlf:		vm
		defw	litS8
		defb	  fmsge - fmsg
fmsg:			defb " fail", 0
fmsge:		defw	type
		defw	tail, cr
seedlfe:defw	or
	defw	tailself
	defb	  seedl - $

	include	"sysvars.asm"
