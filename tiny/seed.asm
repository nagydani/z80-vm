-backBC:	ld	a, (hl)
	add	a, l
	ld	c, a
	ld	a, 0xFF
	adc	a, h
	ld	b, a
	inc	hl
	and	a
	ret

	include	"vmexec.asm"
; ---

seed_tab:
	defb	0x80

; ( -- )
ok:	equ	$ + 0x7F - seed_tab
	defb	do_nop - $

; ( -( fail )- )
fail:	equ	$ + 0x7F - seed_tab
	defb	do_fail - $

; ( -( tail )- )
tail:	equ	$ + 0x7F - seed_tab
	defb	do_tail - $

; ( -( tail )- )
tailself: equ	$ + 0x7F - seed_tab
	defb	do_tailself - $

; ( -( tail )- )
cpu:	equ	$ + 0x7F - seed_tab
	defb	do_cpu - $

; ( -- N8 )
litN8:	equ	$ + 0x7F - seed_tab
	defb	do_litN8 - $

; ( -- S8 )
litS8:	equ	$ + 0x7F - seed_tab
	defb	do_litS8 - $

; ( -- E )
tickself: equ	$ + 0x7F - seed_tab
	defb	do_tickself

; ( -- E )
tick:	equ	$ + 0x7F - seed_tab
	defb	do_tick - $

; ( ( a -( e f )- b ) e -( f )- b )
tryTo:	equ	$ + 0x7F - seed_tab
	defb	do_tryTo

; ( -- E )
litE:	equ	$ + 0x7F - seed_tab
	defb	do_litE - $

; ( N8 -- )
drop:	equ	$ + 0x7F - seed_tab
	defb	do_drop - $

; ( V8 -- )
rain:	equ	$ + 0x7F - seed_tab
	defb	do_rain - $

; ( -- N8 )
zero:	equ	$ + 0x7F - seed_tab
	defb	do_zero - $

; ( N8 N8 -- N8 N8 )
swap:	equ	$ + 0x7F - seed_tab
	defb	do_swap - $

; ( -- E )
emptyE:	equ	$ + 0x7F - seed_tab
	defb	do_emptyE - $

; ( N8 N8 -( fail )- N8 )
eq:	equ	$ + 0x7F - seed_tab
	defb	do_eq - $

; ( N8 N8 -( fail )- N8 )
neq:	equ	$ + 0x7F - seed_tab
	defb	do_neq - $

; ( -( pend )- )
pend:	equ	$ + 0x7F - seed_tab
	defb	do_pend - $

; ( S8 -( fail ) -- S8 C8 )
scan:	equ	$ + 0x7F - seed_tab
	defb	do_scan - $

; ( S8 -( emit )- )
write:	equ	$ + 0x7F - seed_tab
	defb	do_write - $

; ( a ( a -( e )- b ) ( a -( f )- b ) -( e f )- b )
or:	equ	$ + 0x7F - seed_tab
	defb	do_or - $

; ( a ( a -( e )- b ) -( e )- b )
call:	equ	$ + 0x7F - seed_tab
	defb	do_call - $

; ( V8 C8 -( fail )- V8 )
append:	equ	$ + 0x7F - seed_tab
	defb	do_append - $

; ( N8 -( fail )- N8 )
one_plus:equ	$ + 0x7F - seed_tab
	defb	do_one_plus - $

; ( V8 -- V8 S8 )
string:	equ	$ + 0x7F - seed_tab
	defb	do_string - $

; ( -( dict )- )
use:	equ	$ + 0x7F - seed_tab
	defb	do_use - $

; ( -( key emit )- )
comp:	equ	$ + 0x7F - seed_tab
	defb	do_comp - $

seed_last: equ	$ + 0x7F - seed_tab

; ---

; ( -( tail )- )
do_tail:ld	a, (hl)
	pop	bc		; discard do_ok
	pop	hl
	ld	bc, do_ok
	push	bc
	call	vm_tail
	push	hl
	exx
	ret

; ( -( tail )- )
do_tailself:
	pop	bc		; discard do_ok
	call	backBC
	pop	hl		; restore threading
	push	bc
	ret

; ( -( tail )- )
do_cpu:	pop	bc		; discard do_ok
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
do_tickself:
	call	backBC
	jr	pushBC

; ( -- E )
do_tick:call	vm_tick
	push	hl
	exx
	pop	bc
	jr	pushBC

; ( ( a -( e f )- b ) e -( f )- b )
do_tryTo:
	ld	a, (hl)
	add	a, a
;	jr	nc, special_effects
	exx
	call	vm_effect
	push	hl
	push	bc
	rst	pop_rst
	ex	de, hl
	ld	(hl), b
	dec	l
	ld	(hl), c
	pop	bc
	exx
	call	do_call
	ld	a, (hl)
	add	a, a
	exx
	ld	l, a
	ld	h, EFFECT / 0x100
	pop	bc
	and	a
	ret

; ( -- E )
do_litE:call	do_litS8

; ( N8 -- )
do_drop:dec	de
	ret

; ( V8 -- )
do_rain:dec	de
	ld	a, (de)
rain_l:	or	a
	ret	z
	dec	de
	dec	a
	jr	rain_l

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

; ( N8 N8 -( fail )- N8 )
do_eq:	rst	cmp_rst
	ret	z
f_eq:	dec	de
	scf
	ret

; ( N8 N8 -( fail )- N8 )
do_neq:	rst	cmp_rst
	jr	z, f_eq
	and	a
	ret

; ( -( pend )- )
do_pend:call	backBC		; BC = handler
	pop	af		; do_ok
	pop	hl		; backtrack
	push	bc		; handler

	call	suspend
	and	a		; clear failed state
	ret

suspend:push	hl		; placeholder
	push	af		; do_ok
	and	a
	ret

; ( S8 -( fail pend )- S8 C8 )
do_scan:dec	de
	ld	a, (de)
	sub	a, 1
	ld	(de), a
	ex	de, hl
	dec	hl
	ld	b, (hl)
	dec	hl
	jr	c, scan_f
	ld	c, (hl)
	ld	a, (bc)
	inc	bc
	ld	(hl), c
	inc	hl
	ld	(hl), b
	inc	hl
	inc	hl
	ex	de, hl
	ld	(de), a
	inc	de
	rst	vm_rst
	defb	pend
	defb	  do_scan - $
scan_f:	ex	de, hl
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
do_or:	rst	pop_rst
	push	bc
	call	do_call
	ccf
	ret	nc
	pop	bc		; discard other function
	ccf
	ret

; ( a ( a -( e )- b ) -( e )- b )
do_call:rst	pop_rst
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

; ( A -( dict )- )
do_use:	call	do_litE
	rst	pop_rst
	inc	bc
	inc	bc		; skip back reference
	push	bc
	exx
	pop	hl		; HL = new voc
	pop	de		; return address
	push	bc		; old vocab
	ld	c, l
	ld	b, h
	ld	hl, do_disuse
	push	hl
	push	de
	exx
	ret
do_disuse:
	exx
	pop	bc
	exx
	ret

	include	"compiler.asm"
