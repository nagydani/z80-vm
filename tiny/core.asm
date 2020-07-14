	include	"vmexec.asm"
; ---

core_tab:
	defb	0			; first code

; ( -( fail )- )
failor:	equ	($ - core_tab - 1) / 2
	defw	do_failor

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

; ( a -- b a )
make:	equ	($ - core_tab - 1) / 2
	defw	do_make

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

; ( N8 N8 -( fail )- maybe N8 )
ge:	equ	($ - core_tab - 1) / 2
	defw	do_ge

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

; ( E -( overrun )- E N8 )
op:	equ	($ - core_tab - 1) / 2
	defw	do_op

; ( A N8 -( overrun )- A )
adv:	equ     ($ - core_tab - 1) / 2
	defw	do_adv

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

; ( S8 -- )
drip:	equ	($ - core_tab - 1) / 2
	defw	do_drip

; ( E -- )
pass:	equ	($ - core_tab - 1) / 2
	defw	do_pass

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

; ( V8 -- V8 S8 )
string:	equ	($ - core_tab - 1) / 2
	defw	do_string

; ( -( dict )- )
use:	equ	($ - core_tab - 1) / 2
	defw	do_use

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

io_last:equ	($ - core_tab - 1) / 2

; ( N8 -( fail )- maybe N8 )
stroke:	equ	($ - core_tab - 1) / 2
	defw	do_stroke

; ( S8 S8 -( fail )- maybe S8 )
verbatim:equ	($ - core_tab - 1) / 2
	defw	do_verbatim

; ( S8 -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
words:	equ	($ - core_tab - 1) / 2
	defw	do_words

; ( N8 S8 -- S8 N8 )
name:	equ	($ - core_tab - 1) / 2
	defw	do_name

; ( S8 S8 -- N8 N8 )
index:	equ	($ - core_tab - 1) / 2
	defw	do_index

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
srcWords:equ     ($ - core_tab - 1) / 2
	defw	do_srcWords

; ( -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
ioWords:equ     ($ - core_tab - 1) / 2
	defw	do_ioWords

; ( -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
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

failor_name:
	defb	"'fail|", varRef
	defb	$ - failor_name
; ( -( fail )- )
do_failor:
	call	do_call
	inc	hl
	ret	nc
	dec	hl
	jr	do_fail

fail_name:
	defb	"~fail", tailVarRef
	defb	$ - fail_name
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
	ret

ok_name:
	defb	"ok", fn
	defb	$ - ok_name
; ( -- )
do_nop:	ret


tail_name:
	defb	"~", tailFnRef
	defb	$ - tail_name
; ( -( tail )- )
do_tail:pop	bc		; discard return address
	ld	a, (hl)
	pop	hl
	call	vm_tail
	push	de
	exx
	ret

tailself_name:
	defb	"~self", tailSelfRef
	defb	$ - tailself_name
; ( -( tail )- )
do_tailself:
	pop	bc		; discard return address
	call	backBC
	pop	hl		; restore threading
jpbc:	push	bc
	ret

cpu_name:
	defb	raw
	defb	$ - cpu_name
; ( -( tail )- )
do_cpu:	pop	bc		; discard do_ok
	ex	(sp), hl
	ret

litN8_name:
	defb	byte
	defb	$ - litN8_name
; ( -- N8 )
do_litN8:
	ldi
	ret

quote_name:
	defb	"\"", quote
	defb	$ - quote_name
; :TYPE S8 ( A;first N8;length )
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

tickself_name:
	defb	"'self", selfRef
	defb	$ - tickself_name
; ( -- E )
do_tickself:
	call	backBC
	jr	pushBC

tick_name:
	defb	"'", fnRef
	defb	$ - tick_name
; ( -- E )
do_tick:call	vm_tick
a_tick:	push	de
	exx
	pop	bc
	jr	pushBC

make_name:
	defb	"make", makeRef
	defb	$ - make_name
; ( a -- b a )
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

token_name:
	defb	"token", fn
	defb	$ - token_name
; ( N8 -- E )
do_token:dec	de
	ld	a, (de)
	call	vm_tail
	jr	a_tick

tryTo_name:
	defb	"tryTo", fnRef
	defb	$ - tryTo_name
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

brace_name:
	defb	"{", brace
	defb	$ - brace_name
; ( -- E )
do_litE:rst	token_rst
	defb	  litS8
	dec	de
	ret

drop_name:
	defb	"drop", fn
	defb	$ - drop_name
; ( N8 -- )
do_drop:dec	de
	ret

dup_name:
	defb	"dup", fn
	defb	$ - dup_name
; ( N8 -- N8 N8 )
do_dup:	dec	de
	ld	a, (de)
	inc	de
	ld	(de), a
	inc	de
	ret

eq_name:
	defb	"=", fn
	defb	$ - eq_name
; ( N8 N8 -( fail )- maybe N8 )
do_eq:	rst	cmp_rst
	ret	z
f_eq:	dec	de
do_fail0:
	scf
	ret

neq_name:
	defb	"=!", fn
	defb	$ - neq_name
; ( N8 N8 -( fail )- maybe N8 )
do_neq:	rst	cmp_rst
	jr	z, f_eq
	and	a
	ret

ge_name:
	defb	">!", fn
	defb	$ - ge_name
; ( N8 N8 -( fail )- maybe N8 )
do_ge:	rst	cmp_rst
	ret	nc
	dec	de
	ret

append_name:
	defb	",", failOver
	defb	$ - append_name
; ( V8 C8 -( failOver )- V8 |maybe V8+ )
do_append:
	rst	vm_rst
	defb	swap
	defb	tail
	defb	  one_plus

one_plus_name:
	defb	"1+", failOver
	defb	$ - one_plus_name
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

one_minus_name:
	defb	"1-", failOver
	defb	$ - one_minus_name
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

emptyE_name:
	defb	"{}", fn
	defb	emptyE_name - $
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

zero_name:
	defb	"0", fn
	defb	zero_name - $
; ( -- N8 )
do_zero:xor	a
	jr	pushA

swap_name:
	defb	"swap", fn
	defb	swap_name - $
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

var_name:
	defb	"var", varRef
	defb	var_name - $
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

local_name:
	defb	"local", varRef
	defb	local_name - $
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

op_name:
	defb	"op", fn
	defb	op_name - $
; ( E -( overrun )- E N8 )
do_op:	rst	pop_rst
	ld	a, (bc)
	inc	bc
	call	pushBC
	jr	pushA

adv_name:
	defb	"adv", fn
	defb	adv_name - $
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

bite_name:
	defb	"bite", fn
	defb	bite_name - $
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

chop_name:
	defb	"chop", fn
	defb	chop_name - $
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

tailpend_name:
	defb	"~:", tailFn
	defb	tailpend_name - $
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

scan_name:
	defb	"scan:", fn
	defb	scan_name - $
; ( S8 -( fail pend )- maybe S8 N8 )
do_scan:rst	vm_rst
	defb	bite
	defb	tickself
	defb	  do_scan - $
	defb	tailpend

rain_name:
	defb	"rain", fn
	defb	rain_name - $
; ( V8 -- )
do_rain:dec	de
	ld	a, (de)
rain_l:	or	a
	ret	z
	dec	de
	dec	a
	jr	rain_l

drip_name:
	defb	"drip", fn
	defb	drip_name - $
; ( S8 -- )
do_drip:dec	de
	jr	do_pass

pass_name:
	defb	"pass", fn
	defb	pass_name - $
; ( E -- )
do_pass:
	dec	de
	dec	de
	ret

call_name:
	defb	"call", fn
	defb	call_name - $
; ( a ( a -( e )- b ) -( e )- b )
do_call:rst	pop_rst
	push	bc
	ret

while_name:
	defb	"while", fn
	defb	while_name - $
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

or_name:
	defb	"|", fn
	defb	or_name - $
; ( a b ( b -( e )- c ) ( a -( f )- c ) -( e f )- c )
do_or:	rst	pop_rst
	push	bc
	call	do_call
or_c:	ccf
	ret	nc
	pop	bc		; discard other function
	ccf
	ret

unless_name:
	defb	"unless", fn
	defb	unless_name - $
; ( a b ( a -( f )- c ) ( b -( e )- c ) -( e f )- c )
do_unless:
	rst	pop_rst
	push	bc
	rst	pop_rst
	pop	af
	push	bc
	call	resuspend
	jr	or_c

str_name:
	defb	"toStr", fn
	defb	str_name - $
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

use_name:
	defb	"use", voc
	defb	use_name - $
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

;; ( -( pour )- )
;do_pour:push	ix
;	pop	de
;	ret


times_name:
	defb	"times:", fn
	defb	times_name - $
; ( N8 -( fail pend )- maybe N8 )
do_times:
	rst	vm_rst
	defb	one_minus
	defb	  0
	defb	tickself
	defb	  do_times - $
	defb	tailpend

fetchN8_name:
	defb	"@", fn
	defb	fetchN8_name - $
; ( A -- N8 )
do_fetchN8:	rst	pop_rst
		ld	a, (bc)
		ld	(de), a
		inc	de
		ret

fetchE_name:
	defb	"fn", fn
	defb	fetchE_name - $
; ( A -- E )
do_fetchE:	rst	pop_rst
		ld	a, 2
		jr	do_fetch

fetchS8_name:
	defb	"$", fn
	defb	fetchS8_name - $

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

N8store_name:
	defb	"let", fn
	defb	N8store_name - $
; ( N8 A -- )
do_N8store:	rst	pop_rst
do_store1:	dec	de
		ld	a, (de)
		ld	(bc), a
		ret

Estore_name:
	defb	"letFn", fn
	defb	Estore_name - $
; ( E A -- )
do_Estore:	rst	pop_rst
		inc	bc
do_store2:	dec	de
		ld	a, (de)
		ld	(bc), a
		dec	bc
		jr	do_store1

S8store_name:
	defb	"let$", fn
	defb	S8store_name - $
; ( S8 A -- )
do_S8store:	rst	pop_rst
		inc	bc
		inc	bc
		dec	de
		ld	a, (de)
		ld	(bc), a
		dec	bc
		jr	do_store2

tryAt_name:
	defb	"tryAt", fn
	defb	tryAt_name - $
; ( a ( a -( e )- b ) A -( e monad )- b )
do_tryAt:	push	ix
		rst	pop_rst
		push	bc
		pop	ix
		call	do_call
		pop	ix
		ret

write_name:
	defb	"write", fn
	defb	write_name - $
; ( S8 -( emit )- )
do_write:	rst	vm_rst
		defb	tick
		defb	  bite
		defb	tick
		defb	  emit
		defb	tail
		defb	  while

cr_name:
	defb	"cr", fn
	defb	cr_name - $
; ( -( emit )- )
do_cr:		rst	vm_rst
		defb	litN8
		defb	  0x0A
		defb	tail
		defb	  emit

writeln_name:
	defb	"print", fn
	defb	writeln_name - $
; ( S8 -( emit )- )
do_writeln:	rst	vm_rst
		defb	write
		defb	tail
		defb	  cr

readln_name:
	defb	"readln", fn
	defb	readln_name - $
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

stroke_name:
	defb	"stroke", fn
	defb	stroke_name - $
; ( N8 -( fail )- C8 )
do_stroke:	dec	de
		ld	a, (de)
		cp	"!"
		ret	c
		add	a, a
		ret	c
		inc	de
		ret

verbatim_name:
	defb	"$=", fn
	defb	verbatim_name - $
; ( S8 S8 -( fail )- maybe S8 )
do_verbatim:	rst	vm_rst
		defb	local
		defb	  -4
		defb	fetchN8
		defb	tick
		defb	  eq
		defb	failor
		defb	  -5
		defb	local
		defb	  -6
		defb	fetchS8
		defb	litE
		defb	  S8check_end - S8check
S8check:		rst	vm_rst
			defb	bite
			defb	local
			defb	  -7
			defb	fetchS8
			defb	bite
			defb	local
			defb	  -5
			defb	tail
			defb	  fetchN8
S8check_end:	defb	litE
		defb	  S8match_end - S8match
S8match:		rst	vm_rst
			defb	eq
			defb	drop
			defb	local
			defb	  -10
			defb	S8store
			defb	tail
			defb	  drop
S8match_end:	defb	tick
		defb	  while
		defb	failor
		defb	  -13
		defb	tail
		defb	  drip

words_name:
	defb	"words:", fn
	defb	words_name - $
; ( S8 -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
do_words:	rst	vm_rst
		defb	bite
		defb	litE
		defb	  words_g_e - words_g
words_g:		rst	vm_rst
			defb	one_minus
			defb	  words_l - $
			defb	local
			defb	  -4		; current word
			defb	fetchS8		; fetch it
			defb	drop
			defb	zero		; set length to zero
			defb	local
			defb	  -7		; current word
			defb	fetchS8		; fetch it
			defb	tick
			defb	  bite
			defb	failor
			defb	  -7
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

words_l:	defb	fail
		defb	  -4

name_name:
	defb	"name", fn
	defb	name_name - $
; ( N8;idx E;voc -- S8;wrd N8;cls )
do_name:	rst	vm_rst
		defb	make
		defb	  3, 4
		defb	litE
		defb	  s_name_end - s_name
s_name:			rst	vm_rst
			defb	call
			defb	local
			defb	  -5		; tkn
			defb	fetchN8
			defb	local
			defb	  -10		; idx
			defb	fetchN8
			defb	tick
			defb	  eq
			defb	failor
			defb	  -4		; ::
			defb	drop		; token number
			defb	local
			defb	  -10		; cls
			defb	N8store
			defb	local
			defb	  -12		; wrd
			defb	S8store
			defb	fail
			defb	  0
s_name_end:	defb	tick
		defb	  drop			; tkn
		defb	tail
		defb	  or

index_name:
	defb	"index", fn
	defb	index_name - $
; ( S8;nam E;voc -- N8;idx N8;cls )
do_index:	rst	vm_rst
		defb	make
		defb	  5, 2
		defb	litE
		defb	  s_index_end - s_index
s_index:		rst	vm_rst
			defb	call
			defb	local
			defb	  -4		; wrd
			defb	fetchS8
			defb	local
			defb	  -14		; nam
			defb	fetchS8
			defb	tick
			defb	  verbatim
			defb	failor
			defb	  -4		; ::
			defb	drip
			defb	local
			defb	  -12		; cls
			defb	N8store
			defb	drip
			defb	dup		; tkn
			defb	local
			defb	  -10		; idx
			defb	N8store
			defb	fail
			defb	  0
s_index_end:	defb	litE
		defb	  e_index_end - e_index
e_index:		rst	vm_rst
			defb	tail
			defb	  drip
e_index_end:	defb	tail
		defb	  or

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

