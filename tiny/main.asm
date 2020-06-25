	include	"startrst.asm"

; Set up vocabulary
start:	ld	bc, seed_tab
	exx
	ld	de, EFFECT
	ld	ix, EFFECT + 0x100
	ld	(ix + 0), seed_last
	ld	hl, 0
	ld	(EFFECT + 0x101), hl
; Effect initialization
	rst	vm_rst
effect_base:	equ	0x80
	include	"io.asm"
	defb	cpu
; Stack after effects and vocabulary root
	ld	de, EFFECT + 0x103

	include	"repl.asm"

	include "seed.asm"

; short z80sim stuff
;	org	( ( $ + 0xFF ) / 0x100 ) * 0x100
; --

; for Speccy HW
	defs	0x4000 - $, 0xFF
	org	0x5B00
; --

	include	"sysvars.asm"

