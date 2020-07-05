	include	"vmexec.asm"
; ---

core_tab:
	defb	0			; first code

; ( -( fail )- )
fail:	equ	($ - core_tab - 1) / 2
	defw	do_fail

; ( -- )
ok:	equ	($ - core_tab - 1) / 2
	defw	do_nop

; ( -( tail )- )
tail:	equ	($ - core_tab - 1) / 2
	defw	do_tail

; ( -( tail )- )
tailself: equ	($ - core_tab - 1) / 2
	defw	do_tailself

; ( -( tail )- )
cpu:	equ	($ - core_tab - 1) / 2
	defw	do_cpu

; ( -- N8 )
litN8:	equ	($ - core_tab - 1) / 2
	defw	do_litN8

; ( -- S8 )
litS8:	equ	($ - core_tab - 1) / 2
	defw	do_litS8

; ( -- E )
tickself: equ	($ - core_tab - 1) / 2
	defw	do_tickself

; ( -- E )
tick:	equ	($ - core_tab - 1) / 2
	defw	do_tick

; ( ( a -( e f )- b ) e -( f monad )- b )
tryTo:	equ	($ - core_tab - 1) / 2
	defw	do_tryTo

; ( -- E )
litE:	equ	($ - core_tab - 1) / 2
	defw	do_litE

; ( N8 -- )
drop:	equ	($ - core_tab - 1) / 2
	defw	do_drop

; ( V8 -- )
rain:	equ	($ - core_tab - 1) / 2
	defw	do_rain

; ( -- N8 )
zero:	equ	($ - core_tab - 1) / 2
	defw	do_zero

; ( N8 N8 -- N8 N8 )
swap:	equ	($ - core_tab - 1) / 2
	defw	do_swap

; ( -- E )
emptyE:	equ	($ - core_tab - 1) / 2
	defw	do_emptyE

; ( V8 C8 -( fail )- V8 )
append:	equ	($ - core_tab - 1) / 2
	defw	do_append

; ( N8 -( fail )- N8 )
one_plus:equ	($ - core_tab - 1) / 2
	defw	do_one_plus

; ( N8 -( fail )- maybe N8 )
one_minus:equ	($ - core_tab - 1) / 2
	defw	do_one_minus

; ( N8 N8 -( fail )- maybe N8 )
eq:	equ	($ - core_tab - 1) / 2
	defw	do_eq

; ( N8 N8 -( fail )- maybe N8 )
neq:	equ	($ - core_tab - 1) / 2
	defw	do_neq

; ( ( a -( e )- b ) -( tail pend )- )
tailpend:equ	($ - core_tab - 1) / 2
	defw	do_tailpend

; ( N8 -( fail pend )- maybe N8 )
times:	equ	($ - core_tab - 1) / 2
	defw	do_times

; ( S8 -( fail ) -- maybe S8 N8 )
bite:	equ	($ - core_tab - 1) / 2
	defw	do_bite

; ( S8 -( fail ) -- maybe S8 N8 )
chop:	equ	($ - core_tab - 1) / 2
	defw	do_chop

; ( S8 -( fail pend ) -- maybe S8 N8 )
scan:	equ	($ - core_tab - 1) / 2
	defw	do_scan

; ( a ( a -( e )- b ) -( e )- b )
call:	equ	($ - core_tab - 1) / 2
	defw	do_call

; ( S8 -( emit )- )
write:	equ	($ - core_tab - 1) / 2
	defw	do_write

; ( a b ( b -( e )- c maybe d ) ( a c -( f )- c d ) -( e f )- c d )
or:	equ	($ - core_tab - 1) / 2
	defw	do_or

; ( V8 -- V8 S8 )
string:	equ	($ - core_tab - 1) / 2
	defw	do_string

; ( -( dict )- )
use:	equ	($ - core_tab - 1) / 2
	defw	do_use

; ( -( monad )- )
locals:	equ	($ - core_tab - 1) / 2
	defw	do_locals

; ( -( pour )- )
pour:	equ	($ - core_tab - 1) / 2
	defw	do_pour

; ( -( var )- N8 )
varN8:	equ	($ - core_tab - 1) / 2
	defw	do_varN8

; ( -( var )- E )
varE:	equ	($ - core_tab - 1) / 2
	defw	do_varE

; ( -( var )- S8 )
varS8:	equ	($ - core_tab - 1) / 2
	defw	do_varS8

; ( N8 -( let )- )
letN8:	equ	($ - core_tab - 1) / 2
	defw	do_letN8

; ( E -( let )- )
letE:	equ	($ - core_tab - 1) / 2
	defw	do_letE

; ( S8 -( let )- )
letS8:	equ	($ - core_tab - 1) / 2
	defw	do_letS8

; ( a ( a -( e )- b ) -( e monad )- b )
tryWith:equ	($ - core_tab - 1) / 2
	defw	do_tryWith

; ( N8 -( fail )- N8 )
stroke:	equ	($ - core_tab - 1) / 2
	defw	do_stroke

; ( S8 -( tail pend )- maybe S8 )
words:	equ	($ - core_tab - 1) / 2
	defw	do_words

; ( 
comp:	equ	($ - core_tab - 1) / 2
	defw do_comp

; ( 
see:	equ	($ - core_tab - 1) / 2
	defw do_see

core_last:equ	($ - core_tab - 1) / 2

; ---

; ( -( fail )- )
do_fail:scf

; ( -- )
do_nop:	ret

; ( -( tail )- )
do_tail:pop	bc		; discard return address
	ld	a, (hl)
	pop	hl
	call	vm_tail
	push	de
	exx
	ret

; ( -( tail )- )
do_tailself:
	pop	bc		; discard return address
	call	backBC
	pop	hl		; restore threading
jpbc:	push	bc
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
	push	de
	exx
	pop	bc
	jr	pushBC

; ( ( a -( e f )- b ) e -( f monad )- b )
do_tryTo:
	call	vm_tick		; DE = old handler, HL = effect address + 1
	push	de		; old handler on stack
	push	bc		; vocabulary on stack
	exx
	rst	pop_rst		; BC = new handler
	push	bc		; move BC to
	exx
	pop	bc		; BC'
	ld	(hl), b
	dec	hl
	ld	(hl), c		; new handler set HL = effect address
	pop	bc		; restore vocabulary
	push	hl		; save effect address
	exx
	call	do_call		; try function inside the monad
	exx
	pop	hl		; effect address
	pop	de		; old handler
	ld	(hl), e
	inc	hl
	ld	(hl), d		; restore old handler
	exx
	ret

; ( -- E )
do_litE:rst	token_rst
	defb	  litS8

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
	jr	pushA

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
	ret

N8fail:	xor	a
N8fail0:cp	(hl)
	jr	z, do_fail
	ld	c, (hl)
	ld	b, a
	add	hl, bc
	and	a
	jr	pushA

; ( V8 C8 -( failOver )- V8 |maybe V8+ )
do_append:
	rst	vm_rst
	defb	swap
	defb	cpu

; ( N8 -( failOver )- N8 |maybe N8+ )
do_one_plus:
	dec	de
	ld	a, (de)
	inc	a
	jr	nz, N8ok
	jr	N8fail0

; ( N8 -( failOver )- N8 |maybe N8- )
do_one_minus:
	dec	de
	ld	a, (de)
	sub	a, 1
	jr	c, N8fail
N8ok:	inc	hl
pushA:	ld	(de), a
	inc	de
	ret

; ( N8 N8 -( fail )- maybe N8 )
do_eq:	rst	cmp_rst
	ret	z
f_eq:	dec	de
	scf
	ret

; ( N8 N8 -( fail )- maybe N8 )
do_neq:	rst	cmp_rst
	jr	z, f_eq
	and	a
	ret

; ( ( a -( e )- b ) -( tail pend )- )
do_tailpend:
	rst	pop_rst
	pop	af		; return address
	pop	hl		; threading address
	push	bc		; generator
	call	suspend
	ccf			; clear failed state
	ret	nc		; repeat generator on failure

; resuspend after success
	pop	bc		; BC = generator
	pop	af		; AF = return address
	exx
	pop	hl
	push	hl
	push	af
	push	hl
	exx
	ex	(sp), hl	; HL = threading address vs backtrack
	push	bc		; stack generator
	call	resuspend
	pop	bc		; BC = generator
	pop	hl		; HL = threading
	push	bc
	ret

suspend:push	hl		; threading
resuspend:
	push	af		; return address
	and	a
	ret

; ( N8 -( fail pend )- maybe N8 )
do_times:
	rst	vm_rst
	defb	one_minus
	defb	  0
	defb	tickself
	defb	  do_times - $
	defb	tailpend

; ( S8 -( fail )- maybe S8 N8 )
do_bite:rst	vm_rst
	defb	one_minus
	defb	  f_bite - $
	defb	cpu
	dec	de
	dec	de
	ex	de, hl
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
	jr	pushA

; ( S8 -( fail )- maybe S8 N8 )
do_chop:rst	vm_rst
	defb	one_minus
	defb	  f_bite - $
	defb	cpu
	dec	de
	dec	de
	ex	de, hl
	ld	b, (hl)
	dec	hl
	add	a, (hl)
	ld	c, a
	jr	nc, chop_nc
	inc	b
chop_nc:inc	hl
	ex	de, hl
	inc	de
	inc	de
	ld	a, (bc)
	jr	pushA

f_bite:	defb	drop
	defb	drop
	defb	drop
	defb	fail

; ( S8 -( fail pend )- maybe S8 N8 )
do_scan:rst	vm_rst
	defb	bite
	defb	tickself
	defb	  do_scan - $
	defb	tailpend

; ( a ( a -( e )- b ) -( e )- b )
do_call:rst	pop_rst
	push	bc
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

; ( a b ( b -( e )- c ) ( a -( f )- c ) -( e f )- c )
do_or:	rst	pop_rst
	push	bc
	call	do_call
	ccf
	ret	nc
	pop	bc		; discard other function
	ccf
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

; ( -( dict )- )
do_use:	ld	c, (hl)
	inc	hl		; skip length
	ld	b, 0
	inc	hl
	inc	hl		; skip back reference
	push	hl		; stack new vocab
	add	hl, bc
	exx
	pop	hl		; HL = new vocab
	pop	de		; DE = return address
	push	bc		; stack old vocab
	ld	c, l
	ld	b, h		; set new vocab
	call	jpdep
disuse:	exx
	pop	bc		; restore old vocab
	exx
	ret

; ( -( monad )- )
do_locals:
	pop	af	; return address
	ex	af, af'
	ld	a, (hl)
	inc	hl
	pop	bc	; backtrack address
	push	bc
	push	ix
	push	de	; stack pointer
	push	de
	pop	ix
	push	af
	call	a_locals

	jr	c, f_locals
	pop	bc
	pop	bc
	jr	ok_locals
f_locals:
	pop	af
	ld	l, a
	ld	h, 0xFF
	pop	de
	add	hl, de
	ex	de, hl
ok_locals:
	pop	ix
	pop	hl
	ret

a_locals:
	push	bc	; backtrack
	ex	af, af'
	push	af
	and	a
	ret

; ( -( pour )- )
do_pour:	push	ix
		pop	de
		ret

; ( -( var )- N8 )
do_varN8:	call	get_local
		jr	var_next1

; ( -( var )- E )
do_varE:	rst	token_rst
		defb	  varN8
		jr	var_next2


; ( -( var )- S8 )
do_varS8:	rst	token_rst
		defb	  varE
var_next2:	exx
		inc	hl
var_next1:	ld	a, (hl)
		exx
		ld	(de), a
		inc	de
		ret

; ( N8 -( let )- )
do_letN8:	call	get_local
let_next1:	exx
		dec	de
		ld	a, (de)
		exx
		ld	(hl), a
		exx
		ret

; ( E -( let )- )
do_letE:	call	get_local
let_next2:	inc	hl
		call	let_next1
		exx
		dec	hl
		jr	let_next1

; ( S8 -( let )- )
do_letS8:	call	get_local
		inc	hl
		call	let_next2
		exx
		dec	hl
		jr	let_next1

; ( a ( a -( e )- b ) -( e monad )- b )
do_tryWith:	push	ix
		call	vm_tick
		push	de
		exx
		pop	ix
		call	do_call
		pop	ix
		ret

; ( N8 -( fail )- C8 )
do_stroke:	dec	de
		ld	a, (de)
		cp	"!"
		ret	c
		add	a, a
		ret	c
		inc	de
		ret

; ( S8 N8 -( pend )- maybe S8 N8 )
do_words:	rst	vm_rst
		defb	bite
		defb	locals
		defb	  -4
		defb	litE
		defb	  words_g_e - words_g
words_g:		rst	vm_rst
			defb	one_minus
			defb	  0
			defb	varS8
			defb	  -4
			defb	zero
			defb	letN8
			defb	  +2
			defb	varS8
			defb	  -4
			defb	bite
			defb	litE
			defb	  words_n_e - words_n
words_n:			rst	vm_rst
				defb	stroke
				defb	drop
				defb	varN8
				defb	  +2
				defb	one_plus
				defb	  0
				defb	letN8
				defb	  +2
				defb	bite
				defb	tailself
				defb	  words_n - $
words_n_e:		defb	litE
			defb	  words_a_e - words_a
words_a:			rst	vm_rst
				defb	letS8
				defb	  -4
				defb	one_plus
				defb	  0
				defb	tail
				defb	  chop
words_a_e:		defb	or
			defb	tickself
			defb	  words_g - $
			defb	tailpend
words_g_e:	defb	tail
		defb	  call

	include	"compiler.asm"
	include	"decompiler.asm"

; ---

get_local:
	ld	a, (hl)
	inc	hl
	push	ix
	exx
	pop	de
	ld	l, a
	add	a, a
	sbc	a, a
	ld	h, a
	add	hl, de
	and	a		; clear CF
	ret

backBC:	ld	a, (hl)
	add	a, l
	ld	c, a
	ld	a, 0xFF
	adc	a, h
	ld	b, a
	inc	hl
	and	a
	ret

core2:	defb	0			; end of vocabulary
