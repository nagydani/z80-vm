	include	"startrst.asm"

	include "core.asm"

; Set up vocabulary
start:	ld	hl, core_tab
	ld	(EFFECT), hl
	ld	hl, io_tab
	ld	(hl), core_last
	ld	c, l
	ld	b, h
	inc	hl
	push	hl
	exx
	pop	de

; Effect initialization
	rst	vm_rst
	include	"io.asm"
	defb	cpu
; Stack after effects
	include	"repl.asm"

; short z80sim stuff
;	org	( ( $ + 0xFF ) / 0x100 ) * 0x100
; --

; for Speccy HW
	defs	0x4000 - $, 0xFF
	org	0x5B00
; --

	include	"sysvars.asm"
