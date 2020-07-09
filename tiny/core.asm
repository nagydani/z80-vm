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

; ( -- C8 )
ascii:	equ	($ - core_tab - 1) / 2
	defw	do_litN8

; ( -- N8 )
backtick:equ	($ - core_tab - 1) / 2
	defw	do_litN8

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

; ( N8 -- E )
token:	equ	($ - core_tab - 1) / 2
	defw	do_token

; ( ( a -( e f )- b ) e -( f monad )- b )
tryTo:	equ	($ - core_tab - 1) / 2
	defw	do_tryTo

; ( -- E )
litE:	equ	($ - core_tab - 1) / 2
	defw	do_litE

; ( N8 -- )
drop:	equ	($ - core_tab - 1) / 2
	defw	do_drop

; ( N8 -- N8 N8 )
dup:	equ	($ - core_tab - 1) / 2
	defw	do_dup

; ( N8 N8 -( fail )- maybe N8 )
eq:	equ	($ - core_tab - 1) / 2
	defw	do_eq

; ( N8 N8 -( fail )- maybe N8 )
neq:	equ	($ - core_tab - 1) / 2
	defw	do_neq

; ( V8 C8 -( fail )- V8 )
append:	equ	($ - core_tab - 1) / 2
	defw	do_append

; ( N8 -( fail )- N8 )
one_plus:equ	($ - core_tab - 1) / 2
	defw	do_one_plus

; ( N8 -( fail )- maybe N8 )
one_minus:equ	($ - core_tab - 1) / 2
	defw	do_one_minus

; ( -- E )
emptyE:	equ	($ - core_tab - 1) / 2
	defw	do_emptyE

; ( -- N8 )
zero:	equ	($ - core_tab - 1) / 2
	defw	do_zero

; ( N8 N8 -- N8 N8 )
swap:	equ	($ - core_tab - 1) / 2
	defw	do_swap

; ( -( var )- A )
var:	equ	($ - core_tab - 1) / 2
	defw	do_var

; ( -- A )
local:	equ	($ - core_tab - 1) / 2
	defw	do_local

; ( S8 -( fail ) -- maybe S8 N8 )
bite:	equ	($ - core_tab - 1) / 2
	defw	do_bite

; ( S8 -( fail ) -- maybe S8 N8 )
chop:	equ	($ - core_tab - 1) / 2
	defw	do_chop

; ( ( a -( e )- b ) -( tail pend )- )
tailpend:equ	($ - core_tab - 1) / 2
	defw	do_tailpend

; ( S8 -( fail pend ) -- maybe S8 N8 )
scan:	equ	($ - core_tab - 1) / 2
	defw	do_scan

; ( V8 -- )
rain:	equ	($ - core_tab - 1) / 2
	defw	do_rain

; ( a ( a -( e )- b ) -( e )- b )
call:	equ	($ - core_tab - 1) / 2
	defw	do_call

; ( ( a -( e fail )- b maybe c ) ( b c -( f fail )- maybe a ) -( f fail )- maybe b )
while:	equ	($ - core_tab - 1) / 2
	defw	do_while

; ( a b ( b -( e )- c maybe d ) ( a c -( f )- c d ) -( e f )- c d )
or:	equ	($ - core_tab - 1) / 2
	defw	do_or

; ( V8 -- V8 S8 )
string:	equ	($ - core_tab - 1) / 2
	defw	do_string

; ( -( dict )- )
use:	equ	($ - core_tab - 1) / 2
	defw	do_use

; ( -( pour )- )
pour:	equ	($ - core_tab - 1) / 2
	defw	do_pour

; ( N8 -( fail pend )- maybe N8 )
times:	equ	($ - core_tab - 1) / 2
	defw	do_times

; ( -- N8 )
fetchN8:equ	($ - core_tab - 1) / 2
	defw	do_fetchN8

; ( -- E )
fetchE:	equ	($ - core_tab - 1) / 2
	defw	do_fetchE

; ( -- S8 )
fetchS8:equ	($ - core_tab - 1) / 2
	defw	do_fetchS8

; ( N8 -- )
N8store:equ	($ - core_tab - 1) / 2
	defw	do_N8store

; ( E -- )
Estore:	equ	($ - core_tab - 1) / 2
	defw	do_Estore

; ( S8 -( let )- )
S8store:equ	($ - core_tab - 1) / 2
	defw	do_S8store

; ( a ( a -( e )- b ) -( e monad )- b )
tryWith:equ	($ - core_tab - 1) / 2
	defw	do_tryWith

core_last:equ	($ - core_tab - 1) / 2

; ( S8 -( emit )- )
write:	equ	($ - core_tab - 1) / 2
	defw	do_write

; ( S8 -( emit )- )
writeln:equ	($ - core_tab - 1) / 2
	defw	do_writeln

; ( -( key )- S8 )
readln:	equ	($ - core_tab - 1) / 2
	defw	do_readln

io_last:equ	($ - core_tab - 1) / 2

; ( N8 -( fail )- N8 )
stroke:	equ	($ - core_tab - 1) / 2
	defw	do_stroke

; ( S8 -( pend )- maybe S8:words N8:token S8:word N8:wordType )
words:	equ	($ - core_tab - 1) / 2
	defw	do_words

; ( N8 S8 -- S8 )
name:	equ	($ - core_tab - 1) / 2
	defw	do_name

; ( S8 S8 -- N8 )
index:	equ	($ - core_tab - 1) / 2
	defw	do_index

; ( -- S8 )
srcWords:equ     ($ - core_tab - 1) / 2
	defw	do_srcWords

; ( -- S8 )
ioWords:equ     ($ - core_tab - 1) / 2
	defw	do_ioWords

; ( -- S8 )
coreWords:equ     ($ - core_tab - 1) / 2
	defw	do_coreWords

; ( 
comp:	equ	($ - core_tab - 1) / 2
	defw do_comp

; ( 
see:	equ	($ - core_tab - 1) / 2
	defw do_see

src_last:equ	($ - core_tab - 1) / 2

; ---

; ( -( fail )- )
do_fail:ld	a, (hl)
	inc	hl
	or	a
	jr	z, do_fail0
	ld	c, a
	ld	b, 0xFF
	ex	de, hl
	add	hl, bc
	ex	de, hl

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
a_tick:	push	de
	exx
	pop	bc
	jr	pushBC

; ( N8 -- E )
do_token:dec	de
	ld	a, (de)
	call	vm_tail
	jr	a_tick

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

; ( N8 -- N8 N8 )
do_dup:	dec	de
	ld	a, (de)
	inc	de
	ld	(de), a
	inc	de
	ret

; ( N8 N8 -( fail )- maybe N8 )
do_eq:	rst	cmp_rst
	ret	z
f_eq:	dec	de
do_fail0:
	scf
	ret

; ( N8 N8 -( fail )- maybe N8 )
do_neq:	rst	cmp_rst
	jr	z, f_eq
	and	a
	ret

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
N8fail:	xor	a
	cp	(hl)
	jr	z, do_fail0
	ld	c, (hl)
	ld	b, a
	add	hl, bc
	and	a
	jr	pushA

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

; ( -- A )
do_local:
	ld	a, (hl)
	inc	hl
	add	a, e
	ld	c, a
	ld	a, 0xFF
	adc	a, d
	ld	b, a
	and	a
	jr	pushBC

; ( -( var )- A )
do_var:	ld	a, (hl)
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
	push	hl
	exx
	pop	bc
	jr	pushBC

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
	ld	a, (de)
	dec	de
	ex	de, hl
	ld	b, (hl)
	dec	hl
	add	a, (hl)
	ld	c, a
	jr	nc, chop_nc
	inc	b
	and	a
chop_nc:inc	hl
	ex	de, hl
	inc	de
	inc	de
	ld	a, (bc)
	jr	pushA

f_bite:	defb	fail
	defb	  -3

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

; ( S8 -( fail pend )- maybe S8 N8 )
do_scan:rst	vm_rst
	defb	bite
	defb	tickself
	defb	  do_scan - $
	defb	tailpend

; ( V8 -- )
do_rain:dec	de
	ld	a, (de)
rain_l:	or	a
	ret	z
	dec	de
	dec	a
	jr	rain_l

; ( a ( a -( e )- b ) -( e )- b )
do_call:rst	pop_rst
	push	bc
	ret

; ( ( a -( e fail )- b maybe c ) ( b c -( f fail )- maybe a ) -( f fail )- maybe b )
do_while:
	rst	pop_rst
	push	bc
	rst	pop_rst
while_l:push	bc
	call	jpbc		; pred
	jr	c, end_while
	exx
	pop	hl		; HL = pred
	ex	(sp), hl	; HL = body, stack pred
	push	hl		; stack body
	exx
	pop	bc
	push	bc
	call	jpbc		; body
	exx
	pop	hl		; HL = body
	ex	(sp), hl	; HL = pred, stack body
	push	hl		; stack pred
	exx
	pop	bc
	jr	nc, while_l
	pop	bc		; discard body
	ret			; body failure
end_while:
	pop	bc		; discard pred
	pop	bc		; discard body
	and	a		; clear CF
	ret

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

; ( -( pour )- )
do_pour:push	ix
	pop	de
	ret

; ( N8 -( fail pend )- maybe N8 )
do_times:
	rst	vm_rst
	defb	one_minus
	defb	  0
	defb	tickself
	defb	  do_times - $
	defb	tailpend

; ( A -- N8 )
do_fetchN8:	rst	pop_rst
		ld	a, (bc)
		ld	(de), a
		inc	de
		ret

; ( A -- E )
do_fetchE:	rst	pop_rst
		ld	a, 2
		jr	do_fetch

; ( A -- S8 )
do_fetchS8:	rst	pop_rst
		ld	a, 3
do_fetch:	push	hl
		ld	l, c
		ld	h, b
		ld	c, a
		ld	b, 0
		ldir
		pop	hl
		ret

; ( N8 A -- )
do_N8store:	rst	pop_rst
do_store1:	dec	de
		ld	a, (de)
		ld	(bc), a
		ret

; ( E A -- )
do_Estore:	rst	pop_rst
		inc	bc
do_store2:	dec	de
		ld	a, (de)
		ld	(bc), a
		dec	bc
		jr	do_store1

; ( S8 A -- )
do_S8store:	rst	pop_rst
		inc	bc
		inc	bc
		dec	de
		ld	a, (de)
		ld	(bc), a
		dec	bc
		jr	do_store2

; ( a ( a -( e )- b ) -( e monad )- b )
do_tryWith:	push	ix
		call	vm_tick
		push	de
		exx
		pop	ix
		call	do_call
		pop	ix
		ret

; ( S8 -( emit )- )
do_write:	rst	vm_rst
		defb	tick
		defb	  bite
		defb	tick
		defb	  emit
		defb	tail
		defb	  while

; ( S8 -( emit )- )
do_writeln:	rst	vm_rst
		defb	write
		defb	litN8
		defb	  0x0A
		defb	tail
		defb	  emit

; ( -( key )- S8 )
do_readln:	rst	vm_rst
		defb	zero
		defb	litE
		defb	  end_readln - start_readln
start_readln:		rst	vm_rst
			defb	key
			defb	litN8
			defb	  0x0A
			defb	neq
			defb	append
			defb	  0
			defb	tailself
			defb	  start_readln - $
end_readln:	defb	tick
		defb	  string
		defb	tail
		defb	  or

; ( N8 -( fail )- C8 )
do_stroke:	dec	de
		ld	a, (de)
		cp	"!"
		ret	c
		add	a, a
		ret	c
		inc	de
		ret

; ( S8 S8 -( fail )- maybe S8 )
do_verbatim:	rst	vm_rst
		defb	local
		defb	  -4
		defb	tick
		defb	  eq
		defb	litE
		defb	  len_mism_end - len_mism
len_mism:		rst	vm_rst
			defb	fail
			defb	  -5
len_mism_end:	defb	or
		defb	litE
		defb	local
		defb	  -6
		defb	fetchS8
		defb	  S8check_end - S8check
S8check:		rst	vm_rst
			defb	bite
			defb	local
			defb	  -7
			defb	fetchS8
			defb	bite
			defb	local
			defb	  -5
			defb	fetchN8
S8check_end:	defb	litE
		defb	  S8match_end - S8match
S8match:		defb	vm_rst
			defb	eq
			defb	drop
			defb	local
			defb	  -7
			defb	S8store
			defb	drop
S8match_end:	defb	tick
		defb	  while
		defb	litE
		defb	  S8mism_end - S8mism
S8mism:			rst	vm_rst
			defb	fail
			defb	  -13
S8mism_end:	defb	tail
		defb	  or


; ( S8 -( pend )- maybe S8:words N8:token S8:word N8:wordType )
do_words:	rst	vm_rst
		defb	bite
		defb	litE
		defb	  words_g_e - words_g
words_g:		rst	vm_rst
			defb	one_minus
			defb	  0
			defb	local
			defb	  -4		; current word
			defb	fetchS8		; fetch it
			defb	drop
			defb	zero		; set length to zero
			defb	local
			defb	  -7		; current word
			defb	fetchS8		; fetch it
			defb	bite
			defb	litE
			defb	  words_n_e - words_n
words_n:			rst	vm_rst
				defb	stroke
				defb	drop
				defb	local
				defb	  -4
				defb	fetchN8
				defb	one_plus
				defb	  0
				defb	local
				defb	  -5
				defb	N8store	; increment length
				defb	bite
				defb	tailself
				defb	  words_n - $
words_n_e:		defb	litE
			defb	  words_a_e - words_a
words_a:			rst	vm_rst
				defb	local
				defb	  -10
				defb	S8store
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

; ( N8 E;vocab -- S8)
do_name:	rst	vm_rst
		defb	local
		defb	  -3
		defb	fetchN8
		defb	local
		defb	  -3
		defb	fetchE
		defb	litE
		defb	  s_name_end - s_name
s_name:			rst	vm_rst
			defb	call
			defb	drop		; word class
			defb	local
			defb	  -4
			defb	fetchN8
			defb	local
			defb	  -11
			defb	fetchN8
			defb	tick
			defb	  eq
			defb	litE
			defb	  tok_mism_end - tok_mism
tok_mism:			rst	vm_rst
				defb	fail
				defb	  -3
tok_mism_end:		defb	or
			defb	drop		; token number
			defb	local
			defb	  -14
			defb	S8store
			defb	fail
			defb	  0
s_name_end:	defb	emptyE
		defb	tail
		defb	  or

; ( S8 S8 -- N8 )
do_index:	rst	vm_rst
		

	include	"words.asm"
	include	"compiler.asm"
	include	"decompiler.asm"

; ---

backBC:	ld	a, (hl)
	add	a, l
	ld	c, a
	ld	a, 0xFF
	adc	a, h
	ld	b, a
	inc	hl
	and	a
	ret

