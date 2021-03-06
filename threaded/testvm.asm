; for fuse with writable ROM area setting

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
	defw	input

empty:	vm
	defw	litS8
	defb	  ioke - iok
iok:		defb	" ok", 0x0D, 0
ioke:	defw	type
	defw	tail, input

input_link:
	defw	empty_link
	defb	"input", 0
	defw	comma

input:	halt

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

	include	"comments.asm"
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
	include	"compiler.asm"
	include	"debug.asm"

start:	ld	hl, $4000
	ld	de, $4001
	ld	(hl), l
	ld	bc, $BFFF
	ldir
	ld	sp, 0
	ld	a, 10
	ld	(BASE), a
	ld	hl, $5800
	ld	(DP), hl
	ld	hl, seedv
	ld	(CONTEXT), hl
	ld	(CURRENT), hl
	ld	hl, testline
	ld	(TIB), hl
	ld	de, STK_BOT
	ld	ix, vm_l

test:	vm

;	defw	litN16, interpret
;	defw	tickidor

	defw	ctd10
	defw	dot
	defw	fail

	defw	cpu
	halt

ctd5:	vm
	defw	litN16, 5
	defw	countdown
	defw	tail2

ctd10:	vm
	defw	litN16, ctd5
	defw	dup
	defw	or
	defw	tail2

testline:
	defb	": five& 5 countdown& ;"
	defb	": ten& ' five& dup | ; "
	defb	": ten ten& . ~fail "
	defb	"ten ", 0
	defs	0x4000 - $


	include	"sysvars.asm"
