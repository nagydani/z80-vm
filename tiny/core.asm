
	include	"vmexec.asm"
; ---

core_tab:
	defb	$100 - ok		; - fist code
	defb	core0_last - ok		; number of codes

; ( -- )
ok:	equ	$ + 0x7E - core_tab
	defb	do_nop - $

; ( -( fail )- )
fail:	equ	$ + 0x7E - core_tab
	defb	do_fail - $

; ( -( tail )- )
tail:	equ	$ + 0x7E - core_tab
	defb	do_tail - $

; ( -( tail )- )
tailself: equ	$ + 0x7E - core_tab
	defb	do_tailself - $

; ( -( tail )- )
cpu:	equ	$ + 0x7E - core_tab
	defb	do_cpu - $

; ( -- N8 )
litN8:	equ	$ + 0x7E - core_tab
	defb	do_litN8 - $

; ( -- S8 )
litS8:	equ	$ + 0x7E - core_tab
	defb	do_litS8 - $

; ( -- E )
tickself: equ	$ + 0x7E - core_tab
	defb	do_tickself - $

; ( -- E )
tick:	equ	$ + 0x7E - core_tab
	defb	do_tick - $

; ( ( a -( e f )- b ) e -( f monad )- b )
tryTo:	equ	$ + 0x7E - core_tab
	defb	do_tryTo

; ( -- E )
litE:	equ	$ + 0x7E - core_tab
	defb	do_litE - $

; ( N8 -- )
drop:	equ	$ + 0x7E - core_tab
	defb	do_drop - $

; ( V8 -- )
rain:	equ	$ + 0x7E - core_tab
	defb	do_rain - $

; ( -- N8 )
zero:	equ	$ + 0x7E - core_tab
	defb	do_zero - $

; ( N8 N8 -- N8 N8 )
swap:	equ	$ + 0x7E - core_tab
	defb	do_swap - $

; ( -- E )
emptyE:	equ	$ + 0x7E - core_tab
	defb	do_emptyE - $

; ( N8 N8 -( fail )- N8 )
eq:	equ	$ + 0x7E - core_tab
	defb	do_eq - $

; ( N8 N8 -( fail )- N8 )
neq:	equ	$ + 0x7E - core_tab
	defb	do_neq - $

; ( ( a -( e )- b ) -( tail pend )- )
tailpend:equ	$ + 0x7E - core_tab
	defb	do_tailpend - $

; ( N8 -( fail )- N8 )
one_minus:equ	$ + 0x7E - core_tab
	defb	do_one_minus - $

; ( N8 -( fail pend )- N8 )
times:	equ	$ + 0x7E - core_tab
	defb	do_times - $

; ( S8 -( fail ) -- S8 C8 )
bite:	equ	$ + 0x7E - core_tab
	defb	do_bite - $

; ( S8 -( fail pend ) -- S8 C8 )
scan:	equ	$ + 0x7E - core_tab
	defb	do_scan - $

; ( a ( a -( e )- b ) -( e )- b )
call:	equ	$ + 0x7E - core_tab
	defb	do_call - $

; ( S8 -( emit )- )
write:	equ	$ + 0x7E - core_tab
	defb	do_write - $

; ( a b ( b -( e )- c ) ( a -( f )- c ) -( e f )- c )
or:	equ	$ + 0x7E - core_tab
	defb	do_or - $

; ( V8 C8 -( fail )- V8 )
append:	equ	$ + 0x7E - core_tab
	defb	do_append - $

; ( N8 -( fail )- N8 )
one_plus:equ	$ + 0x7E - core_tab
	defb	do_one_plus - $

; ( V8 -- V8 S8 )
string:	equ	$ + 0x7E - core_tab
	defb	do_string - $

core0_last: equ	$ + 0x7E - core_tab
	defb	core1 - $

; ---

; ( -( tail )- )
do_tail:pop	bc		; discard return addrerss
	rst	vm_exec
	pop	hl
	jp	do_ok

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
	push	hl
	exx
	pop	bc
	jr	pushBC

; ( ( a -( e f )- b ) e -( f monad )- b )
do_tryTo:
	ld	a, (hl)		; effect ID
	add	a, a
;	jr	nc, special_effects
	exx
	rst	effect_rst	; HL = old handler, DE = effect address + 1
	push	hl		; old handler on stack
	push	bc		; vocabulary on stack
	rst	pop_rst		; BC = new handler
	ex	de, hl		; HL = effect address + 1, DE = old handerl
	ld	(hl), b
	dec	l
	ld	(hl), c		; new handler set HL = effect address
	pop	bc		; restore vocabulary
	exx
	call	do_call		; try function inside the monad
	ld	a, (hl)		; effect ID
	inc	hl		; advance threading
	add	a, a
	exx
	ld	l, a
	ld	h, EFFECT / 0x100 ; HL = effect address
	pop	de		; DE = old handler
	ld	(hl), e
	inc	l
	ld	(hl), d		; restore old handler
	exx
	and	a
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

; ( ( a -( e )- b ) -( tail pend )- )
do_tailpend:
	rst	pop_rst
	pop	af		; return address
	pop	hl		; threading address
	push	bc		; generator

resuspend:
	call	suspend
	ccf			; clear failed state
	ret	nc		; repeat generator on failure
	pop	bc		; BC = generator
	pop	af		; AF = return address
	pop	hl		; HL = threading address
	push	hl
	push	af
	push	bc
	jr	resuspend

suspend:push	hl		; placeholder
	push	af		; return address
	and	a
	ret

; ( N8 -( fail )- N8 )
do_one_minus:
	dec	de
	ld	a, (de)
	sub	a, 1
	ret	c
pushA:	ld	(de), a
	inc	de
	ret

; ( N8 -( fail pend )- N8 )
do_times:
	rst	vm_rst
	defb	one_minus
	defb	tickself
	defb	  do_times - $
	defb	tailpend

; ( S8 -( fail )- S8 C8 )
do_bite:rst	token_rst
	defb	  one_minus
	dec	de
	dec	de
	ret	c
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

; ( S8 -( fail pend )- S8 C8 )
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
	jr	nz, pushA

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

core1:	defb	core1_last - core0_last		; number of codes

; ( -( dict )- )
use:	equ	$ - core1 + core0_last - 1
	defb	do_use - $

; ( -( monad )- )
locals:	equ	$ - core1 + core0_last - 1
	defb	do_locals - $

; ( -( pour )- )
pour:	equ	$ - core1 + core0_last - 1
	defb	do_pour - $

; ( -( var )- N8 )
varN8:	equ	$ - core1 + core0_last - 1
	defb	do_varN8 - $

; ( -( var )- E )
varE:	equ	$ - core1 + core0_last - 1
	defb	do_varE - $

; ( -( var )- S8 )
varS8:	equ	$ - core1 + core0_last - 1
	defb	do_varS8 - $

; ( N8 -( let )- )
letN8:	equ	$ - core1 + core0_last - 1
	defb	do_letN8 - $

; ( E -( let )- )
letE:	equ	$ - core1 + core0_last - 1
	defb	do_letE - $

; ( S8 -( let )- )
letS8:	equ	$ - core1 + core0_last - 1
	defb	do_letS8 - $

; ( a ( a -( e )- b ) -( e monad )- b )
tryWith:equ	$ - core1 + core0_last - 1
	defb	do_tryWith - $

; ( N8 -( fail )- N8 )
stroke:	equ	$ - core1 + core0_last - 1
	defb	do_stroke - $

; ( S8 -( tail pend )- S8 )
words:	equ	$ - core1 + core0_last - 1
		defb	do_words - $

; ( 
comp:	equ	$ - core1 + core0_last - 1
	defb	do_comp - $

; ( 
see:	equ	$ - core1 + core0_last - 1
	defb	do_see - $

core1_last:equ	$ - core1 + core0_last - 1
	defb	core2 - $

core_last:equ	core1_last

; ---

; ( -( dict )- )
do_use:	inc	hl
	inc	hl		; skip back reference
	push	hl		; stack new vocab
	inc	hl		; skip first code
use_n:	ld	c, (hl)		; number of codes
	ld	b, 0
	inc	bc
	add	hl, bc
	ld	c, (hl)		; last code
	add	hl, bc
	exx
	pop	de		; DE = new voc
	pop	hl		; HL = return address
	push	bc		; stack old vocab
	ld	c, e
	ld	b, d		; set new vocab
	call	jphlp
disuse:	exx
	pop	bc		; restore old vocab
	exx
	ret


; ( -( monad )- )
do_locals:
	pop	af	; return address
	pop	bc	; backtrack address
	push	bc
	push	ix
	push	de	; stack pointer
	pop	ix
	call	a_locals

	pop	ix
	pop	hl
	ret

a_locals:
	push	bc	; backtrack
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
		ld	a, (hl)
		inc	hl
		add	a, a
		exx
		rst	effect_rst
		push	hl
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

; ( S8 -( pend )- S8 )
do_words:	rst	vm_rst
		defb	bite
		defb	locals
		defb	times
		defb	varS8
		defb	  -4
		defb	zero
		defb	letN8
		defb	  +2
		defb	varS8
		defb	  -4
		defb	litE
		defb	  words_n_e - words_n
words_n:		rst	vm_rst
			defb	bite
			defb	stroke
			defb	drop
			defb	varN8
			defb	  +2
			defb	one_plus
			defb	letN8
			defb	  +2
			defb	tailself
			defb	  words_n - $
words_n_e:	defb	litE
		defb	  words_a_e - words_a
words_a:		rst	vm_rst
			defb	letS8
			defb	  -4
			defb	cpu
			ret
words_a_e:	defb	or
		defb	cpu
		ret

	include	"decompiler.asm"
	include	"compiler.asm"

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
