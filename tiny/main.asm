	include	"startrst.asm"

	include "core.asm"

; Set up vocabulary
start:	ld	bc, core_tab
	exx
	ld	de, EFFECT
; Effect initialization
	rst	vm_rst
effect_base:	equ	0x00
	include	"io.asm"
	defb	cpu
; Stack after effects
	ld	de, WORKSP

	include	"repl.asm"

; short z80sim stuff
;	org	( ( $ + 0xFF ) / 0x100 ) * 0x100
; --

; for Speccy HW
	defs	0x4000 - $, 0xFF
	org	0x5B00
; --

	include	"sysvars.asm"
