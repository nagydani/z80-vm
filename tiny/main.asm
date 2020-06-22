rst0:	di
	ld	sp, 0
	xor	a
	jp	start
	defs	rst0 + 8 - $
	include	"vmrst.asm"

	include	"vmexec.asm"

failure:and	a
	ld	hl, do_halt
	push	hl
	rst	vm_rst
	defb	litS8
	defb	  end_fmsg - fmsg
fmsg:	defb	  "Failure.", 0xA0
end_fmsg:
	defb	scan
	defb	C8emit
	defb	fail
do_halt:halt

start:	ld	de, WORKSP		; datastack
	ld	hl, failure
	push	hl
	exx
	ld	de, vm_tab
	exx
	rst	vm_rst
	defb	litS8
	defb	  end_hello - hello
hello:	defb	  "Hello World!", 0x0A
end_hello:
	defb	scan
	defb	C8emit
	defb	fail

; ---

vm_tab:	equ	$ - 1

; ( -( fail )- )
fail:	equ	0x80

; ( -- N8 )
litN8:	equ	$ - vm_tab
	defb	do_litN8 - $

; ( -- S8 )
litS8:	equ	$ - vm_tab
	defb	do_litS8 - $

; ( N8 -- )
N8drop:	equ	$ - vm_tab
	defb	do_N8drop

; ( S8 -( fail ) -- S8 C8 )
scan:	equ	$ - vm_tab
	defb	do_scan - $

; ( N8 -( fail )- N8 )
countdown:	equ	$ - vm_tab
	defb	do_countdown - $

; ( a ( a -( e fail )- b ) ( a -( e fail )- b ) -( e fail )- b )
or:	equ	$ - vm_tab
	defb	do_or - $

; ( a ( a -( e )- b ) -( e )- b )
apply:	equ	$ - vm_tab
	defb	do_apply - $

; ( C8 -( emit )- )
C8emit:	equ	$ - vm_tab
	defb	do_C8emit - $

; ( N8 -( emit )- )
N8emit:	equ	$ - vm_tab
	defb	do_N8emit - $

; ---

; ( -- N8 )
do_litN8:
	ldi
	ret

; :TYPE S8 ( A ` first N8 ` length )
; ( -- S8 )
do_litS8:
	ld	a, (hl)
	inc	hl
	ex	de, hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
	inc	hl
	ld	(hl), a
	inc	hl
	ex	de, hl
	ld	c, a
	ld	b, 0
	add	hl, bc
	ret

; ( -- E )
do_litE:call	do_litS8

; ( N8 -- )
do_N8drop:
	dec	de
	ret

; ( S8 -( fail suspend )- S8 C8 )
do_scan:
	dec	de
	ld	a, (de)
	sub	a, 1
	ret	c		; CAN fail
	ld	(de), a
	ex	de, hl
	dec	hl
	ld	b, (hl)
	dec	hl
	ld	c, (hl)
	ld	a, (bc)
	inc	bc
	ld	(hl), c
	inc	hl
	ld	(hl), b
	inc	hl
	inc	hl
	ex	de, hl
	jr	genN8

; ( N8 -( fail suspend )- N8 )
do_countdown:
	dec	de
	ld	a, (de)
	sub	a, 1		; CAN fail
	ret	c
genN8:	ld	(de), a
	inc	de
generator:
	exx
	pop	bc		; return address
	pop	hl		; backtrack address
	push	hl
	exx
	dec	hl
	push	hl
	inc	hl
	exx
	dec	hl
	push	hl
	push	bc
	exx
	ret

; ( a ( a -( e fail )- b ) ( a -( e fail )- b ) -( e fail )- b )
do_or:	call	do_apply
	jr	nc, do_Edrop
	and	a

; ( a ( a -( e )- b ) -( e )- b )
do_apply:
	ex	de, hl
	dec	hl
	ld	b, (hl)
	dec	hl
	ld	c, (hl)
	ex	de, hl
	push	bc
	ret

; ( a ( a -( e fail )- b ) ( b -( e fail )- c ) -( e fail )- c )
do_and:	call	do_apply
	jr	nc, do_apply
	and	a

; ( E -- )
do_Edrop:
	dec	de
	dec	de
	ret

; ( C8 -( emit )- )
do_C8emit:
	dec	de
	ld	a, (de)
	out	(0), a
	ret

; ( N8 -( emit )- )
do_N8emit:
	dec	de
	ld	a, (de)
	add	"0"
	out	(0), a
	ret

; ---

	org	0x4000
	include	"sysvars.asm"
