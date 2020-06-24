backBC:	ld	a, (hl)
	add	a, l
	ld	c, a
	ld	a, 0xFF
	adc	a, h
	ld	b, a
	inc	hl
	and	a
	ret

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
NCret:	ccf
	ret

popC:	ret	nc
	pop	bc
	ret

	include	"vmexec.asm"
; ---

vm_tab:	equ	$

; ( -- )
ok:	equ	$ - vm_tab
	defb	do_nop - $

; ( -( fail )- )
fail:	equ	$ - vm_tab
	defb	do_fail - $

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
tick:	equ	$ - vm_tab
	defb	do_tick - $

; ( -- E )
litE:	equ	$ - vm_tab
	defb	do_litE - $

; ( N8 -- )
drop:	equ	$ - vm_tab
	defb	do_drop - $

; ( -- N8 )
zero:	equ	$ - vm_tab
	defb	do_zero - $

; ( N8 N8 -- N8 N8 )
swap:	equ	$ - vm_tab
	defb	do_swap - $

; ( -- E )
emptyE:	equ	$ - vm_tab
	defb	do_emptyE - $

; ( S8 -( fail ) -- S8 C8 )
scan:	equ	$ - vm_tab
	defb	do_scan - $

; ( N8 -( fail )- N8 )
times:	equ	$ - vm_tab
	defb	do_times - $

; ( -( pend )- )
pend:	equ	$ - vm_tab
	defb	do_pend - $

; ( S8 -( emit )- )
write:	equ	$ - vm_tab
	defb	do_write - $

; ( a ( a -( e )- b ) ( a -( f )- b ) -( e f )- b )
or:	equ	$ - vm_tab
	defb	do_or - $

; ( a ( a -( e )- b ) -( e )- b )
apply:	equ	$ - vm_tab
	defb	do_apply - $

; ( V8 C8 -( fail )- V8 )
append:	equ	$ - vm_tab
	defb	do_append - $

; ( N8 -( fail )- N8 )
one_plus:equ	$ - vm_tab
	defb	do_one_plus - $

; ( V8 -- V8 S8 )
string:	equ	$ - vm_tab
	defb	do_string - $

; ( C8 -( fail )- C8 )
stroke:	equ	$ - vm_tab
	defb	do_stroke - $

; ( N8 C8 -- S8 )
word:	equ	$ - vm_tab
	defb	do_word - $

; ---

; ( -( tail )- )
do_tail:ld	a, (hl)
	pop	bc		; discard do_ok
	pop	bc		; discard vm_result
	pop	hl
	ld	bc, do_ok
	push	bc
	call	vm_tail
	push	hl
	exx
	ret

; ( -( tail )- )
do_cpu:	pop	bc		; discard do_ok
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
do_tick:call	vm_tick
	push	hl
	exx
	pop	bc
	jr	pushBC

; ( -- A )
pop_do:	pop	bc
	jr	pushBC

; ( -- E )
do_litE:call	do_litS8

; ( N8 -- )
do_drop:dec	de
	ret

; ( -- N8 )
do_zero:xor	a
	ld	(de), a
	inc	de
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
	ld	bc, do_nop
pushBC:	ex	de, hl
	ld	(hl), c
	inc	hl
	ld	(hl), b
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
	jr	vm_pendN8

; ( N8 -( fail pend )- N8 )
do_times:
	dec	de
	ld	a, (de)
	sub	a, 1		; CAN fail
	ret	c
vm_pendN8:
	ld	(de), a
	inc	de
	exx
	pop	de		; return address
	pop	hl		; backtrack address
	push	hl
	exx
	dec	hl
	push	hl
	inc	hl
	exx
	dec	hl
	push	hl
	push	de
	exx
	ret

; ( -( pend )- )
do_pend:call	backBC		; BC = handler
	exx
	pop	de		; do_ok
	pop	hl		; vm_result
	exx
	pop	hl		; backtrack
	push	bc		; handler
	ld	bc, NCret
	push	bc
	push	hl		; placeholder
	exx
	push	hl		; vm_result
	push	de		; do_ok
	exx
	ret

; ( S8 -( emit )- )
do_write:
	rst	vm_rst
	defb	litE
	defb	  write_end - write_start
write_start:
		rst	vm_rst
		defb	scan
		defb	emit
		defb	fail
write_end:
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

; ( V8 C8 -( fail )- V8 )
do_append:
	rst	vm_rst
	defb	swap
	defb	cpu

; ( N8 -( fail )- N8 )
do_one_plus:
	dec	de
	ld	a, (de)
	inc	a
	ld	(de), a
	inc	de
	ret	nz

; ( -( fail )- )
do_fail:scf
	ret

; ( V8 -- V8 S8 )
do_string:
	push	de
	exx
	pop	hl
	dec	hl
	ld	e, (hl)
	ld	a, e
	ld	d, 0
	sbc	hl, de
	ex	de, hl
	add	hl, de
	inc	hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
	inc	hl
	ld	(hl), a
	inc	hl
	push	hl
	exx
	pop	de
	ret

; ( C8 -( fail )- C8 )
do_stroke:
	dec	de
	ld	a, (de)
	inc	de
	cp	"!"
	ret	nc
	dec	de
	ret

; ( N8 C8 -- S8 )
do_word:
	rst	vm_rst
	defb	zero
	defb	litE
	defb	  word_a - word_r
word_r:		rst	vm_rst
		defb	litE
		defb	  word_e - word_s
word_s:			rst	vm_rst
			defb	key
			defb	stroke
			defb	pend
			defb	  word_s - $
word_e:		defb	apply
		defb	append
		defb	fail
word_a:	defb	tick
	defb	  string
	defb	tail
	defb	  or
