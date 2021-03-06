	include	"vmexec.asm"
; ---

core_tab:
	defb	0			; first code


; --- core vocabulary ---

; ( -( tail )- )
tail:	equ	($ - core_tab - 1) / 2
	defw	do_tail

; ( -( tail )- )
tail2:	equ	($ - core_tab - 1) / 2
	defw	do_tail2

; ( -( tail )- )
tailself: equ	($ - core_tab - 1) / 2
	defw	do_tailself

; ( -- )
ok:	equ	($ - core_tab - 1) / 2
	defw	do_nop

; ( -( tail )- )
cpu:	equ	($ - core_tab - 1) / 2
	defw	do_cpu

; ( -- C8 )
ascii:	equ	($ - core_tab - 1) / 2
	defw	do_litN8

; ( -- N8 )
litN8:	equ	($ - core_tab - 1) / 2
	defw	do_litN8

; ( -- S8 )
litS8:	equ	($ - core_tab - 1) / 2
	defw	do_litS8

; ( -- (?) )
litE:	equ	($ - core_tab - 1) / 2
	defw	do_litE

; ( N8 -- N8 N8 )
dup:	equ	($ - core_tab - 1) / 2
	defw	do_dup

; ( a -- b a )
make:	equ	($ - core_tab - 1) / 2
	defw	do_make

; ( ( a -( e f )- b ) e -( f monad )- b )
tryTo:	equ	($ - core_tab - 1) / 2
	defw	do_tryTo

; ( -( fail )- )
failor:	equ	($ - core_tab - 1) / 2
	defw	do_failor

; ( -( fail )- )
fail:	equ	($ - core_tab - 1) / 2
	defw	do_fail

; ( N8 N8 -( fail )- maybe N8 )
ge:	equ	($ - core_tab - 1) / 2
	defw	do_ge

; ( N8 N8 -( fail )- maybe N8 )
neq:	equ	($ - core_tab - 1) / 2
	defw	do_neq

; ( N8 N8 -( fail )- maybe N8 )
eq:	equ	($ - core_tab - 1) / 2
	defw	do_eq

; ( V8 N8 -( fail )- V8 )
append:	equ	($ - core_tab - 1) / 2
	defw	do_append

; ( V8 S8 -( failOver )- V8 |maybe V8 S8 )
grow:	equ	($ - core_tab - 1) / 2
	defw	do_grow

; ( N8 -( failOver )- N8 |maybe N8max )
one_plus:equ	($ - core_tab - 1) / 2
	defw	do_one_plus

; ( N8 -( failOver )- N8 |maybe N8max )
one_minus:equ	($ - core_tab - 1) / 2
	defw	do_one_minus

; ( N8 N8 -( failOver )- N8 |maybe N8+ )
plus:	equ	($ - core_tab - 1) / 2
	defw	do_plus

; ( -( tail )- )
failOver:equ	($ - core_tab - 1) / 2
	defw	do_failOver

; ( N8 -- (?) )
token:	equ	($ - core_tab - 1) / 2
	defw	do_token

; ( -- N8 )
zero:	equ	($ - core_tab - 1) / 2
	defw	do_zero

; ( E -( overrun )- E N8 )
op:	equ	($ - core_tab - 1) / 2
	defw	do_op

; ( -- (?) )
tick:	equ	($ - core_tab - 1) / 2
	defw	do_tick

; ( -- (?) )
tickself: equ	($ - core_tab - 1) / 2
	defw	do_tickself

; ( S8 -( fail ) -- maybe S8 N8 )
bite:	equ	($ - core_tab - 1) / 2
	defw	do_bite

; ( S8 -( fail ) -- maybe S8 N8 )
chop:	equ	($ - core_tab - 1) / 2
	defw	do_chop

; ( -- (--) )
emptyE:	equ	($ - core_tab - 1) / 2
	defw	do_emptyE

; ( N8 N8 -- N8 N8 )
swap:	equ	($ - core_tab - 1) / 2
	defw	do_swap

; ( -( var )- A )
var:	equ	($ - core_tab - 1) / 2
	defw	do_var

; ( -- A )
local:	equ	($ - core_tab - 1) / 2
	defw	do_local

; ( A N8 -( overrun )- A )
adv:	equ     ($ - core_tab - 1) / 2
	defw	do_adv

; ( ( a -( e )- b ) -( tailpend )- )
tailpend:equ	($ - core_tab - 1) / 2
	defw	do_tailpend

; ( -( \ ~; )- )
unpend:equ	($ - core_tab - 1) / 2
	defw	do_unpend

; ( S8 -( fail pend ) -- maybe S8 N8 )
scan:	equ	($ - core_tab - 1) / 2
	defw	do_scan

; ( E -( pend ) -- ;; N8 )
oppend:	equ	($ - core_tab - 1) / 2
	defw	do_oppend

; ( V8 -- )
rain:	equ	($ - core_tab - 1) / 2
	defw	do_rain

; ( S8 -- )
drip:	equ	($ - core_tab - 1) / 2
	defw	do_drip

; ( E -- )
pass:	equ	($ - core_tab - 1) / 2
	defw	do_pass

; ( N8 -- )
drop:	equ	($ - core_tab - 1) / 2
	defw	do_drop

; ( a ( a -( e )- b ) -( e )- b )
call:	equ	($ - core_tab - 1) / 2
	defw	do_call

; ( ( a -( e fail )- b maybe c ) ( b c -( f fail )- maybe a ) -( f fail )- maybe b )
while:	equ	($ - core_tab - 1) / 2
	defw	do_while

; ( a b ( b -( e )- c maybe d ) ( a c -( f )- c d ) -( e f )- c d )
or:	equ	($ - core_tab - 1) / 2
	defw	do_or

; ( a b ( a c -( f )- c d ) ( b -( e )- c maybe d ) -( e f )- c d )
unless:	equ	($ - core_tab - 1) / 2
	defw	do_unless

; ( a ( a -( e fail )- b ) -( e fail )- )
not:	equ	($ - core_tab - 1) / 2
	defw	do_not

; ( V8 -- V8 S8 )
string:	equ	($ - core_tab - 1) / 2
	defw	do_string

; ( V8 -( fail )- maybe V8 N8 )
pinch:	equ	($ - core_tab - 1) / 2
	defw	do_pinch

; ( -( dict )- )
use:	equ	($ - core_tab - 1) / 2
	defw	do_use

; ( -( dict )- )
expose:	equ	($ - core_tab - 1) / 2
	defw	do_expose

;; ( -( pour )- )
;pour:	equ	($ - core_tab - 1) / 2
;	defw	do_pour

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

; ( a ( a -( e )- b ) A -( e monad )- b )
tryAt:	equ	($ - core_tab - 1) / 2
	defw	do_tryAt

core_last:equ	($ - core_tab - 1) / 2

; --- io vocabulary ---

; ( S8 -( emit )- )
write:	equ	($ - core_tab - 1) / 2
	defw	do_write

; ( -( emit )- )
cr:	equ	($ - core_tab - 1) / 2
	defw	do_cr

; ( S8 -( emit )- )
writeln:equ	($ - core_tab - 1) / 2
	defw	do_writeln

; ( -( key )- S8 )
readln:	equ	($ - core_tab - 1) / 2
	defw	do_readln

; ( -( key tailpend )- C8 ;; )
input:	equ	($ - core_tab - 1) / 2
	defw	do_input

; ( S8 ( -( key )- ) -- )
feed:	equ	($ - core_tab - 1) / 2
	defw	do_feed 

io_last:equ	($ - core_tab - 1) / 2

; --- src vocabulary ---

; ( N8 -( fail )- maybe N8 )
stroke:	equ	($ - core_tab - 1) / 2
	defw	do_stroke

; ( S8 S8 -( fail )- maybe S8 )
verbatim:equ	($ - core_tab - 1) / 2
	defw	do_verbatim

; ( S8 -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
words:	equ	($ - core_tab - 1) / 2
	defw	do_words

; ( N8 E -- S8 N8 )
name:	equ	($ - core_tab - 1) / 2
	defw	do_name

; ( S8;nam E;voc -- N8;idx N8;cls )
index:	equ	($ - core_tab - 1) / 2
	defw	do_index

; ( N8 -( emit )- )
indent:	equ	($ - core_tab - 1) / 2
	defw	do_indent

; ( S8 -( write )- )
writesp:equ	($ - core_tab - 1) / 2
	defw	do_writesp

; ( N8 -( emit )- )
hexnum:	equ	($ - core_tab - 1) / 2
	defw	do_hexnum

; ( S8 E -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
moreWords:equ	($ - core_tab - 1) / 2
	defw	do_moreWords

; ( -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
synWords:equ	($ - core_tab - 1) / 2
	defw	do_synWords

; ( -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
effWords:equ	($ - core_tab - 1) / 2
	defw	do_effWords

; ( -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
srcWords:equ	($ - core_tab - 1) / 2
	defw	do_srcWords

; ( -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
ioWords:equ	($ - core_tab - 1) / 2
	defw	do_ioWords

; ( -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
coreWords:equ	($ - core_tab - 1) / 2
	defw	do_coreWords

; ( E -( monad )- )
tryBuf:	equ	($ - core_tab - 1) / 2
	defw	do_tryBuf

; ( N8 -( ??? )- )
buf:	equ	($ - core_tab - 1) / 2
	defw	do_buf

; ( ( -( emit e )- ) -( emit e )- )
tryEmitBuf: equ	($ - core_tab - 1) / 2
	defw	do_tryEmitBuf

; ( -( key )- V8 )
word:	equ	($ - core_tab - 1) / 2
	defw	do_word

; ( 
comp:	equ	($ - core_tab - 1) / 2
	defw do_comp

; ( 
see:	equ	($ - core_tab - 1) / 2
	defw do_see

src_last:equ	($ - core_tab - 1) / 2

; ---


; ( -( tail )- )
do_tail:pop	bc		; discard return address
	ld	a, (hl)
	pop	hl
	call	vm_tail
	push	de
	exx
	ret

; ( -( tail )- )
do_tail2:
	pop	bc		; discard return address
	pop	hl		; pick up threading
	ret

; ( -( tail )- )
do_tailself:
	pop	bc		; discard return address
	call	backBC
	pop	hl		; restore threading
jpbc:	push	bc
; ( -- )
do_nop:	ret

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
do_lit:	inc	hl
	ex	de, hl
	ld	c, a
	ld	b, 0
	add	hl, bc
	ret

; ( -- E )
do_litE:ld	a, (hl)
	inc	hl
	ex	de, hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
	jr	do_lit

; ( N8 -- N8 N8 )
do_dup:	dec	de
	ld	a, (de)
	inc	de
	ld	(de), a
	inc	de
	ret

; ( x -( missingValue )- y x )
do_make:ld	a, (hl)
	inc	hl
	ld	c, (hl)
	inc	hl
	ld	b, 0
	push	hl
	dec	de
	ld	l, e
	ld	h, d
	add	hl, bc
	push	hl
	or	a
	jr	z, make0
	ld	c, a
	ex	de, hl
	lddr
make0:	pop	de
	inc	de
	pop	hl
	ret

; ( a ( a -( e f )- b ) handler -( f )- b )
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

; ( a ( a -( e )- b )  -( e fail )- maybe b )
do_failor:
	call	do_call
	inc	hl
	ret	nc
	dec	hl

; ( x -( fail )- )
do_fail:ld	a, (hl)
	inc	hl
	or	a
	jr	z, do_fail0
	ld	c, a
	ld	b, 0xFF
	ex	de, hl
	add	hl, bc
	ex	de, hl
	ret

; ( N8 N8 -( fail )- maybe N8 )
do_ge:	rst	cmp_rst
	ret	nc
	dec	de
	ret

; ( N8 N8 -( fail )- maybe N8 )
do_neq:	rst	cmp_rst
	jr	z, f_eq
	and	a
	ret

; ( N8 N8 -( fail )- maybe N8 )
do_eq:	rst	cmp_rst
	ret	z
f_eq:	dec	de
do_fail0:
	scf
	ret

; ( V8 N8 -( failOver )- V8 |maybe V8+ )
do_append:
	rst	vm_rst
	defb	swap
	defb	tail
	defb	  one_plus

; ( V8 S8 -( failOver )- V8 |maybe V8 S8 )
do_grow:dec	de
	ld	a, (de)
	rst	pop_rst
	ex	de, hl
	dec	hl
	add	(hl)
	jr	c, no_grow
	sub	(hl)
grow_l:	ex	af, af'
	ld	a, (hl)
	inc	a
	inc	hl
	ld	(hl), a
	dec	hl
	ld	a, (bc)
	inc	bc
	ld	(hl), a
	inc	hl
	ex	af, af'
	dec	a
	jr	nz, grow_l
	inc	hl
grow_r:	ex	de, hl
	inc	de
	ret

no_grow:inc	hl
	inc	hl
	inc	hl
	inc	hl
	ex	de, hl
	jr	do_failOver

; ( N8 -( failOver )- N8 |maybe [256] )
do_one_plus:
	dec	de
	ld	a, (de)
	inc	a
	jr	nz, N8ok
	jr	do_failOver

; ( N8 -( failOver )- N8 |maybe [-1] )
do_one_minus:
	dec	de
	ld	a, (de)
	sub	a, 1
	jr	c, do_failOver
N8ok:	inc	hl
pushA:	ld	(de), a
	inc	de
	ret

; ( N8 N8 -( failOver )- N8 |maybe N8+ )
do_plus:rst	pop_rst
	ld	a, b
	add	c
	jr	nc, N8ok
N8_f:	ld	(de), a
	inc	de

; ( -( failOver )- )
do_failOver:
	xor	a
	cp	(hl)
	jr	z, do_fail0
	ld	c, (hl)
	ld	b, a
	add	hl, bc
	ret

; ( tok -- `tok )
do_token:dec	de
	ld	a, (de)
	call	vm_tail
	jr	a_tick

; ( -- [0] )
do_zero:xor	a
	jr	pushA

; ( A -( overrun )- A N8 )
do_op:	rst	pop_rst
	ld	a, (bc)
	inc	bc
	call	pushBC
	jr	pushA

; ( -- (?) )
do_tick:call	vm_tick
a_tick:	push	de
	exx
	pop	bc
	jr	pushBC

; ( -- `self )
do_tickself:
	call	backBC
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
pushA2:	jr	pushA

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
	jr	pushA2

f_bite:	defb	fail
	defb	  -2

; ( -- (--) )
do_emptyE:
	ld	bc, do_nop
	jr	pushBC

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
pushBC:	ex	de, hl
	ld	(hl), c
	inc	hl
	ld	(hl), b
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

; ( A N8 -( overrun )- A )
do_adv:	dec	de
	ld	a, (de)
	rst	pop_rst
	adc	a, c
	ld	c, a
	ld	a, 0
	adc	a, b
	ld	b, a
adv_nc:	jr	pushBC

; ( handler -( tail, tailpend )- ;; )
do_tailpend:
	rst	pop_rst		; fetch generator
	pop	af		; return address
	pop	hl		; threading address
	push	bc		; stack generator
	call	suspend
pending:ccf			; clear failed state
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
repending:
	pop	bc		; BC = generator
	pop	hl		; HL = threading
	push	bc
	ret

suspend:push	hl		; threading
resuspend:
	push	af		; return address
	and	a
	ret

; ( -( \~ )- )
do_unpend:
	exx
	pop	de	; return
	exx
	pop	bc	; discard threading
	pop	bc	; BC = pending?
;	ld	a, pending - 0x100 * (pending / 0x100)
;	cp	c
;	jr	nz, unp_x
;	ld	a, pending / 0x100
;	cp	b
;	jr	nz, unp_x
	pop	bc	; discard generator
	pop	bc
	xor	a
	cp	b
	jr	nz,unp_l
	ld	a, do_ok
	cp	c
	jr	nz, unp_l
unp_x:	exx
	push	de	; return
	exx
	ret

unp_l:	pop	bc	; discard generator
	and	a
	ret

; ( S8 -( fail pend )- maybe S8 ;; N8 )
do_scan:rst	vm_rst
	defb	bite
	defb	tickself
	defb	  do_scan - $
	defb	tailpend

; ( E -( pend )- ;; N8 )
do_oppend:
	rst	vm_rst
	defb	op
	defb	tickself
	defb	  do_oppend - $
	defb	tailpend

; ( V8 -- )
do_rain:dec	de
	ld	a, (de)
rain_l:	or	a
	ret	z
	dec	de
	dec	a
	jr	rain_l

; ( S8 -- )
do_drip:dec	de

; ( A -- )
do_pass:
	dec	de

; ( N8 -- )
do_drop:dec	de
	ret

; ( a ( a -( e )- b) -( e )- b )
do_call:rst	pop_rst
	push	bc
	ret

; ( a ( a -( e fail )- b maybe c ) ( b c -( f fail )- maybe a ) -( e f fail )- maybe b )
; ( args pred pred body forWhile -( effs pred effs body fail )- maybe sureVals pred )
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
; ( args body args pred pred body forOr -( effs pred effs body )- vals pred )
do_or:	rst	pop_rst
	push	bc
	call	do_call
or_c:	ccf
	ret	nc
	pop	bc		; discard other function
	ccf
	ret

; ( a b ( a -( f )- c ) ( b -( e )- c ) -( e f )- c )
; ( args body args pred body pred forUnless -( effs pred effs body )- vals pred )
do_unless:
	rst	pop_rst
	push	bc
	rst	pop_rst
	pop	af
	push	bc
	call	resuspend
	jr	or_c

; ( a ( a -( e fail )- b ) -( e fail )- )
do_not:	call	do_call
	ccf
	ld	c, (hl)
	inc	hl
	ret	nc
	ld	b, 0xFF
	ex	de, hl
	add	hl, bc
	ex	de, hl
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

; ( V8 -( fail )- maybe V8 N8 )
do_pinch:
	rst	vm_rst
	defb	one_minus
	defb	  0
	defb	tail
	defb	  swap

; ( -( dict )- )
do_use:	push	hl		; stack here
	inc	hl		; skip vocab offset
	exx
	pop	hl		; here
	ld	e, (hl)
	ld	d, 0		; DE = vocab offset
	add	hl, de		; HL = new vocab
	pop	de		; DE = return address
	pop	af		; AF = threading address
	push	bc		; stack old vocab
	ld	c, l
	ld	b, h		; set new vocab
	call	setvoc
disuse:	exx
	pop	bc		; restore old vocab
	exx
	ret

setvoc:	push	af
	and	a
	push	de
	exx
	ret

; ( -( dict )- )
do_expose:
	pop	bc		; discard return address
	pop	hl		; restore threading
	exx
	ld	hl, 0
	add	hl, sp		; skip return and threading
expo_a:	ld	a, (hl)
	inc	hl
	cp	disuse - 0x100 * (disuse / 0x100)
	jr	nz, expo_l
	ld	a, (hl)
	cp	disuse / 0x100
	jr	nz, expo_l
	ld	e, l
	ld	d, h
	inc	de
	inc	de
	inc	de
	dec	hl
	sbc	hl, sp
	jr	z, expose_0
	push	bc
	ld	c, l
	ld	b, h
	add	hl, sp
	dec	hl
	lddr
expose_0:
	ex	de, hl
	dec	hl
	ld	sp, hl
	exx
	ret

expo_l:	inc	hl
	inc	hl
	inc	hl
	jr	expo_a

; ( N8 -( fail pend )- maybe N8 :: )
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

; ( A -- func )
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

; ( A A -- )
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

; ( a ( a -( e )- b ) A -( e \ access )- b )
do_tryAt:	push	ix
		rst	pop_rst
		push	bc
		pop	ix
		call	do_call
		pop	ix
		ret

; -- I/O --

; ( S8 -( emit )- )
do_write:	rst	vm_rst
		defb	tick
		defb	  bite
		defb	tick
		defb	  emit
		defb	tail
		defb	  while

; ( -( emit )- )
do_cr:		rst	vm_rst
		defb	litN8
		defb	  0x0A
		defb	tail
		defb	  emit

; ( -( emit )- )
do_sp:		rst	vm_rst
		defb	litN8
		defb	  0x20
		defb	tail
		defb	  emit

; ( S8 -( emit )- )
do_writeln:	rst	vm_rst
		defb	write
		defb	tail
		defb	  cr

; ( -( key )- V8 S8 )
do_readln:	rst	vm_rst
		defb	zero
		defb	litE
		defb	  end_readln - start_readln
		; ( V8 -( fail key )- V8 )
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

do_input:	rst	vm_rst
		defb	key
		defb	tickself
		defb	  do_input - $
		defb	tailpend

; ( S8 ( -( key )- ) -- )
do_feed:	rst	vm_rst
		defb	litE
		defb	  e_feed - s_feed
s_feed:			rst	vm_rst
			defb	tick
			defb	  keyBuf
			defb	fetchS8
			defb	bite
			defb	local
			defb	  -4
			defb	fetchS8
			defb	tick
			defb	  keyBuf
			defb	S8store
			defb	local
			defb	  -4
			defb	N8store
			defb	tail
			defb	  pass
e_feed:			equ	$
		defb	litE
		defb	  e_tryKey - s_tryKey
s_tryKey:		rst	vm_rst
			defb	tryTo
			defb	  key
			defb	tail2
e_tryKey:		equ	$
		defb	local
		defb	  -9
		defb	tryTo
		defb	  keyBuf
		defb	tail2

	include "src.asm"
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

