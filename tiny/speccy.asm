	include	"startrst.asm"

start:	ld	bc, seed_tab
	exx
	ld	de, EFFECT
; Effect initialization
	rst	vm_rst
effect_base:	equ	0x80
	include	"io.asm"
	defb	cpu
; Stack after effects
	inc	d
	ld	e, 0

	include	"repl.asm"

	include "seed.asm"

	defs	0x4000 - $, 0xFF

	org	0x5B00
	include	"sysvars.asm"
