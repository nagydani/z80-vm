rst0:	di
	ld	sp, 0
	xor	a
	jp	start
	defs	rst0 + 8 - $
	include	"vmrst.asm"


start:	ld	bc, vm_tab
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

	org	( ( $ + 0xFF ) / 0x100 ) * 0x100
	include	"sysvars.asm"
