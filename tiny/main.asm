rst0:	di
	ld	sp, 0
	xor	a
	jp	start
	defs	rst0 + 8 - $
	include	"vmrst.asm"


start:	ld	de, WORKSP		; datastack
	exx
	ld	de, vm_tab
	exx
	rst	vm_rst
	defb	litE
	defb	  end_test - test
test:		rst	vm_rst
		defb	litS8
		defb	  end_hello - hello
hello:		defb	  "Hello World!", 0x0A
end_hello:
		defb	tail
		defb	  S8emit
end_test:
	defb	litE
	defb	  end_failure - failure
failure:	rst	vm_rst
		defb	litS8
		defb	  end_fmsg - fmsg
fmsg:		defb	  "Failure.", 0x0A
end_fmsg:
		defb	tail
		defb	  S8emit
end_failure:
	defb	or
	defb	cpu
	halt

popBC:	ex	de, hl
	dec	hl
	ld	b, (hl)
	dec	hl
	ld	c, (hl)
	ex	de, hl
	ret

popNC:	ccf
	ret	nc
	pop	bc
	and	a
	ret

popC:	ret	nc
	pop	bc
	ret

	include	"vmexec.asm"
; ---

vm_tab:	equ	$ - 1

; ( -( fail )- )
fail:	equ	0x80

; ( -( tail )- )
tail:	equ	$ - vm_tab
	defb	do_tail - $

; ( -( tail )- )
cpu:	equ	$ - vm_tab
	defb	do_cpu - $

; ( -- N8 )
litN8:	equ	$ - vm_tab
	defb	do_litN8 - $

; ( -- S8 )
litS8:	equ	$ - vm_tab
	defb	do_litS8 - $

; ( -- E )
litE:	equ	$ - vm_tab
	defb	do_litE - $

; ( N8 N8 -- N8 N8 )
swap:	equ	$ - vm_tab
	defb	do_swap - $

; ( N8 -- )
drop:	equ	$ - vm_tab
	defb	do_drop - $

; ( -- E )
emptyE:	equ	$ - vm_tab
	defb	do_emptyE - $

; ( S8 -( fail ) -- S8 C8 )
scan:	equ	$ - vm_tab
	defb	do_scan - $

; ( N8 -( fail )- N8 )
times:	equ	$ - vm_tab
	defb	do_times - $

; ( S8 -( emit )- )
S8emit:	equ	$ - vm_tab
	defb	do_S8emit - $

; ( a ( a -( e )- b ) ( a -( f )- b ) -( e f )- b )
or:	equ	$ - vm_tab
	defb	do_or - $

; ( a ( a -( e )- b ) -( e )- b )
apply:	equ	$ - vm_tab
	defb	do_apply - $

; ( a ( a -( e )- b ) ( b -( f )- c ) -( e f )- c )
and:	equ	$ - vm_tab
	defb	do_and - $

; ( N8 -( fail )- N8 )
one_plus:equ	$ - vm_tab
	defb	do_one_plus - $

; ( C8 -( fail )- C8 )
stroke:	equ	$ - vm_tab
	defb	do_stroke - $

; ---

; ( C8 -( emit )- )
C8emit:	equ	$ - vm_tab
	defb	do_C8emit - $

; ( -( key )- C8 )
key:	equ	$ - vm_tab
	defb	do_key - $

; ---

; ( -( tail )- )
do_tail:ld	a, (hl)
	pop	bc		; discard vm_exec
	pop	bc		; discard vm_result
	pop	hl
	jr	vm_tail

; ( -( tail )- )
do_cpu:	pop	bc		; discard vm_exec
	pop	bc		; discard vm_result
	ex	(sp), hl
	ret

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
do_drop:dec	de
	ret

; ( N8 N8 -- N8 N8 )
do_swap:ex	de, hl
	dec	hl
	ld	b, (hl)
	dec	hl
	ld	c, (hl)
	ld	(hl), b
	inc	hl
	ld	(hl), c
	inc	hl
	ex	de, hl
	ret

; ( -- E )
do_emptyE:
	ex	de, hl
	ld	(hl), do_nop - 0x100 * (do_nop / 0x100)
	inc	hl
	ld	(hl), do_nop / 0x100
	inc	hl
	ex	de, hl
do_nop:	ret

; ( S8 -( fail pend )- S8 C8 )
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
	jr	do_pendN8

; ( N8 -( fail pend )- N8 )
do_times:
	dec	de
	ld	a, (de)
	sub	a, 1		; CAN fail
	ret	c
do_pendN8:
	ld	(de), a
	inc	de
do_pend:exx
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

; ( S8 -( emit )- )
do_S8emit:
	rst	vm_rst
	defb	litE
	defb	  S8emit_end - S8emit_start
S8emit_start:
		rst	vm_rst
		defb	scan
		defb	C8emit
		defb	fail
S8emit_end:
	defb	emptyE
	defb	cpu

; ( a ( a -( e )- b ) ( a -( f )- b ) -( e f )- b )
do_or:	call	popBC
	push	bc
	ld	bc, popNC
	push	bc

; ( a ( a -( e )- b ) -( e )- b )
do_apply:
	call	popBC
	push	bc
	ret

; ( a ( a -( e )- b ) ( b -( f )- c ) -( e f )- c )
do_and:	call	popBC
	push	bc
	ld	bc, popC
	push	bc
	jr	do_apply

; ( N8 -( fail )- N8 )
do_one_plus:
	dec	de
	ld	a, (de)
	inc	a
	ld	(de), a
	inc	de
	ret	nz
	scf
	ret

; ( C8 -( fail )- C8 )
do_stroke:
	dec	de
	ld	a, (de)
	inc	de
	cp	"!"
	ret
;	rst	vm_rst
;	defb	litN8
;	defb	  "!"
;	defb	swap
;	defb	tail
;	defb	  le

; ( N8 C8 -- V8 )
do_word:rst	vm_rst
	defb	stroke
	defb	swap
	defb	tail
	defb	  one_plus

;---

; ( C8 -( emit )- )
do_C8emit:
	dec	de
	ld	a, (de)
	out	(0), a
	ret

; ( -( key pend )- C8 )
do_key:
	in	a, (0)
	jr	do_pendN8

; ---

	org	0x4000
	include	"sysvars.asm"
