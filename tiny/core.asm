	include	"vmexec.asm"
; ---

core_tab:
	defb	0			; first code

; ( -- )
ok:	equ	($ - core_tab - 1) / 2
	defw	do_nop

; ( -( tail )- )
tail:	equ	($ - core_tab - 1) / 2
	defw	do_tail

; ( -( tail )- )
tail2:	equ	($ - core_tab - 1) / 2
	defw	do_tail2

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
litN8:	equ	($ - core_tab - 1) / 2
	defw	do_litN8

; ( -- S8 )
litS8:	equ	($ - core_tab - 1) / 2
	defw	do_litS8

; ( -- (?) )
litE:	equ	($ - core_tab - 1) / 2
	defw	do_litE

; ( N8 -- )
drop:	equ	($ - core_tab - 1) / 2
	defw	do_drop

; ( N8 -- N8 N8 )
dup:	equ	($ - core_tab - 1) / 2
	defw	do_dup

; ( a -- b a )
make:	equ	($ - core_tab - 1) / 2
	defw	do_make

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
eq:	equ	($ - core_tab - 1) / 2
	defw	do_eq

; ( N8 N8 -( fail )- maybe N8 )
neq:	equ	($ - core_tab - 1) / 2
	defw	do_neq

; ( ( a -( e f )- b ) e -( f monad )- b )
tryTo:	equ	($ - core_tab - 1) / 2
	defw	do_tryTo

; ( N8 -- (?) )
token:	equ	($ - core_tab - 1) / 2
	defw	do_token

; ( V8 C8 -( fail )- V8 )
append:	equ	($ - core_tab - 1) / 2
	defw	do_append

; ( N8 -( fail )- N8 )
one_plus:equ	($ - core_tab - 1) / 2
	defw	do_one_plus

; ( N8 -( fail )- maybe N8 )
one_minus:equ	($ - core_tab - 1) / 2
	defw	do_one_minus

; ( -( tail )- )
failOver:equ	($ - core_tab - 1) / 2
	defw	do_failOver

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

; ( -- (--) )
emptyE:	equ	($ - core_tab - 1) / 2
	defw	do_emptyE

; ( S8 -( fail ) -- maybe S8 N8 )
bite:	equ	($ - core_tab - 1) / 2
	defw	do_bite

; ( S8 -( fail ) -- maybe S8 N8 )
chop:	equ	($ - core_tab - 1) / 2
	defw	do_chop

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

; ( (?) -- F )
backtick:equ	($ - core_tab - 1) / 2
	defw	do_backtick

; ( F -- [?] )
arg:	equ	($ - core_tab - 1) / 2
	defw	do_arg

; ( F -- -(?)- )
eff:	equ	($ - core_tab - 1) / 2
	defw	do_eff

; ( F -- [?] )
val:	equ	($ - core_tab - 1) / 2
	defw	do_val

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

; ( V8 S8 -( fail )- V8 |maybe V8 S8 )
grow:	equ	($ - core_tab - 1) / 2
	defw	do_grow

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

; ( N8 E -- S8 N8 )
name:	equ	($ - core_tab - 1) / 2
	defw	do_name

; ( S8;nam E;voc -- N8;idx N8;cls )
index:	equ	($ - core_tab - 1) / 2
	defw	do_index

; ( ( a -( e )- b ) -( emit )- )
fnType:	equ	($ - core_tab - 1) / 2
	defw	do_fnType

; ( S8 E -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
moreWords:equ	($ - core_tab - 1) / 2
	defw	do_moreWords

; ( -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
typWords:equ	($ - core_tab - 1) / 2
	defw	do_typWords

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

	defb	t_nop - do_nop
; ( -- )
do_nop:	ret

t_nop:	defb	0
	defb	0
	defb	0

	defb	t_tail - do_tail
; ( -( tail )- )
do_tail:pop	bc		; discard return address
	ld	a, (hl)
	pop	hl
	call	vm_tail
	push	de
	exx
	ret

	defb	t_tail2 - do_tail2
; ( -( tail )- )
do_tail2:
	pop	bc		; discard return address
	pop	hl		; pick up threading
	ret

	defb	t_tailself - do_tailself
; ( -( tail )- )
do_tailself:
	pop	bc		; discard return address
	call	backBC
	pop	hl		; restore threading
jpbc:	push	bc
	ret

	defb	t_cpu - do_cpu
; ( -( tail )- )
do_cpu:	pop	bc		; discard do_ok
	ex	(sp), hl
	ret

t_tail:
t_tail2:
t_tailself:
t_cpu:	defb	0
	defb	1, tail
	defb	0

	defb	t_litN8 - do_litN8
; ( -- N8 )
do_litN8:
	ldi
	ret

t_litN8:
	defb	0
	defb	0
	defb	1, N8

	defb	t_litS8 - do_litS8
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

t_litS8:defb	0
	defb	0
	defb	S8

	defb	t_litE - do_litE
; ( -- E )
do_litE:ld	a, (hl)
	inc	hl
	ex	de, hl
	inc	de
	ld	(hl), e
	inc	hl
	ld	(hl), d
	jr	do_lit

t_litE:	defb	0
	defb	0
	defb	1, func

	defb	t_drop - do_drop
; ( N8 -- )
do_drop:dec	de
	ret

t_drop:	defb	1, N8
	defb	0
	defb	0

	defb	t_dup - do_dup
; ( N8 -- N8 N8 )
do_dup:	dec	de
	ld	a, (de)
	inc	de
	ld	(de), a
	inc	de
	ret

t_dup:	defb	1, N8
	defb	0
	defb	2, N8, N8

	defb	t_make - do_make
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

t_make:	defb	1, selfArg
;;	defb	1, missingValue
	defb	2, selfVal, selfArg

	defb	t_failor - do_failor
; ( a ( a -( e )- b )  -( e fail )- maybe b )
do_failor:
	call	do_call
	inc	hl
	ret	nc
	dec	hl
;	jr	do_fail
	defb	0x3e		; LD A, skip next byte

t_failor:
	;;defb	2, predArg, Pred
	;;defb	2, predEff, fail
	;;defb	1, predVal
	;;defb	0

	defb	t_fail - do_fail
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

t_fail:	defb	1, funcArg
	defb	1, fail
	defb	0

	defb	t_ge - do_ge
; ( N8 N8 -( fail )- maybe N8 )
do_ge:	rst	cmp_rst
	ret	nc
	dec	de
	ret

	defb	t_eq - do_eq
; ( N8 N8 -( fail )- maybe N8 )
do_eq:	rst	cmp_rst
	ret	z
f_eq:	dec	de
do_fail0:
	scf
	ret

	defb	t_neq - do_neq
; ( N8 N8 -( fail )- maybe N8 )
do_neq:	rst	cmp_rst
	jr	z, f_eq
	and	a
	ret

t_ge:
t_eq:
t_neq:	defb	2, N8, N8
	defb	1, fail
	defb	1, N8
	defb	0

	defb	t_tryTo - do_tryTo
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

t_tryTo:defb	1, tryArg
	defb	1, tryEff
	defb	1, tryVal

	defb	t_token - do_token
; ( tok -- `tok )
do_token:dec	de
	ld	a, (de)
	call	vm_tail
	jr	a_tick

t_token:defb	1, tok
	defb	0
	defb	1, backticktok

	defb	t_append - do_append
; ( V8 N8 -( failOver )- V8 |maybe V8+ )
do_append:
	rst	vm_rst
	defb	swap
	defb	tail
	defb	  one_plus

t_append:
	defb	2, V8, N8
	defb	1, failOver
	defb	1, V8
	defb	1, V8plus

	defb	t_one_plus - do_one_plus
; ( N8 -( failOver )- N8 |maybe [256] )
do_one_plus:
	dec	de
	ld	a, (de)
	inc	a
	jr	nz, N8ok
	jr	do_failOver

t_one_plus:
	defb	1, N8
	defb	1, failOver
	defb	1, N8
	defb	1, N8max

	defb	t_one_minus - do_one_minus
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

t_one_minus:
	defb	1, N8
	defb	1, failOver
	defb	1, N8
;;	defb	1, minus1

	defb	t_plus - do_plus
; ( N8 N8 -( failOver )- N8 |maybe N8+ )
do_plus:rst	pop_rst
	ld	a, b
	add	c
	jr	nc, N8ok
N8_f:	ld	(de), a
	inc	de
	defb	0x3E		; LD A, skip byte

	defb	t_failOver - do_failOver
; ( -( failOver )- )
do_failOver:
	xor	a
	cp	(hl)
	jr	z, do_fail0
	ld	c, (hl)
	ld	b, a
	add	hl, bc
	ret

t_plus:	defb	2, N8, N8
	defb	1, failOver
	defb	1, N8
;;	defb	1, N8plus

t_failOver:
	defb	0
	defb	1, failOver
	defb	0

	defb	t_zero - do_zero
; ( -- [0] )
do_zero:xor	a
	jr	pushA

t_zero:	defb	0
	defb	0
	defb	1, N8

	defb	t_op - do_op
; ( A -( overrun )- A N8 )
do_op:	rst	pop_rst
	ld	a, (bc)
	inc	bc
	call	pushBC
	jr	pushA

t_op:	defb	1, N8Ref
	defb	1, overrun
	defb	1, N8Ref, N8

	defb	t_tick - do_tick
; ( -- (?) )
do_tick:call	vm_tick
a_tick:	push	de
	exx
	pop	bc
	jr	pushBC

t_tick:	defb	0
	defb	0
	defb	1, func

	defb	t_tickself - do_tickself
; ( -- `self )
do_tickself:
	call	backBC
	jr	pushBC
t_tickself:
	defb	0
	defb	0
	defb	1, backtickself

	defb	t_emptyE - do_emptyE
; ( -- (--) )
do_emptyE:
	ld	bc, do_nop
	jr	pushBC
t_emptyE:
	defb	0
	defb	0
	defb	1, emptyFn

	defb	t_bite - do_bite
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

	defb	t_chop - do_chop
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

t_chop:
t_bite:	defb	1, S8
	defb	1, fail
	defb	1, S8, N8
	defb	0

	defb	t_swap - do_swap
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

t_swap:	defb	2, N8, N8
	defb	0
	defb	2, N8, N8

	defb	t_var - do_var
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

t_var:	defb	0
	defb	1, var
	defb	1, N8Ref

	defb	t_local - do_local
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

t_local:defb	0
	defb	1, local
	defb	1, N8Ref

	defb	t_adv - do_adv
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

t_adv:	defb	2, N8Ref, N8
	defb	1, overrun
	defb	1, N8Ref

	defb	t_backtick - do_backtick
; ( (?) -- (?)` )
do_backtick:rst	pop_rst
	dec	bc
advBC:	ld	a, (bc)
	add	a, c
	ld	c, a
	ld	a, 0
	adc	a, b
	ld	b, a
	jr	pushBC
t_backtick:
	defb	1, func
	defb	0
	defb	1, funcType

	defb	t_arg - do_arg
; ( F -- [?] )
do_arg:	ret

t_arg:	defb	1, funcType
	defb	0
	defb	1, recType

	defb	t_eff - do_eff
; ( F -- -(?)- )
do_eff:	call	backtick
advBC2:	rst	pop_rst
	jr	advBC

t_eff:	defb	1, funcType
	defb	0
;;	defb	1, effs

	defb	t_val - do_val
; ( F -- [?] )
do_val:	call	do_eff
	jr	advBC2

t_val:	defb	1, funcType
	defb	0
	defb	1, recType

	defb	t_tailpend - do_tailpend
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

t_tailpend:
	defb	1, handler
	defb	2, tail, tailpend
	defb	1, state

	defb	t_unpend - do_unpend
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

t_unpend:
	defb	0
	defb	2, setminus, tailpend
	defb	0

	defb	t_scan - do_scan
; ( S8 -( fail pend )- maybe S8 ;; N8 )
do_scan:rst	vm_rst
	defb	bite
	defb	tickself
	defb	  do_scan - $
	defb	tailpend

t_scan:	defb	1, S8
	defb	2, fail, tailpend
;;	defb	1, maybeS8StateN8

	defb	t_oppend - do_oppend
; ( E -( pend )- ;; N8 )
do_oppend:
	rst	vm_rst
	defb	op
	defb	tickself
	defb	  do_oppend - $
	defb	tailpend
t_oppend:
	defb	1, N8Ref
	defb	2, fail, tailpend
;;	defb	1, stateN8

	defb	t_rain - do_rain
; ( V8 -- )
do_rain:dec	de
	ld	a, (de)
rain_l:	or	a
	ret	z
	dec	de
	dec	a
	jr	rain_l

t_rain:	defb	1, V8
	defb	0
	defb	0

	defb	t_drip - do_drip
; ( S8 -- )
do_drip:dec	de
;	jr	do_pass
	defb	0x3E		; LD A, skip next byte

	defb	t_pass - do_pass
; ( A -- )
do_pass:
	dec	de
	dec	de
	ret

t_drip:	defb	1, S8
	defb	0
	defb	0

t_pass:	defb	1, N8Ref
	defb	0
	defb	0

	defb	t_call - do_call
; ( a ( a -( e )- b) -( e )- b )
do_call:rst	pop_rst
	push	bc
	ret

t_call:	defb	2, funcArg, func
	defb	1, funcEff
	defb	1, funcVal

	defb	t_while - do_while
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

t_while:;;defb	1, predArgPredBodyWhile
	;;defb	3, predEff, setminus ,bodyEff
	;;defb	1, maybeBodyVal

	defb	t_or - do_or
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

t_or:	;;defb	1, predArgBodyArgPredBodyOr
	;;defb	1, predEff
	;;defb	2, val, pred

	defb	t_unless - do_unless
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
t_unless:
	;;defb	1, predArgBodyPredUnless
	;;defb	3, predEff, setminus, bodyEff
	;;defb	1, maybeBodyVal


	defb	t_string - do_string
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
t_string:
	defb	1, V8
	defb	0
	defb	2, V8, S8

	defb	t_grow - do_grow
; ( V8 S8 -( fail )- V8 |maybe V8 S8 )
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
grow_r:	ex	de, hl
	inc	de
	ret

no_grow:inc	hl
	inc	hl
	inc	hl
	jr	grow_r

t_grow:	defb	2, V8, S8
	defb	1, fail
	defb	1, V8
	defb	1, V8, S8

	defb	t_use - do_use
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

	defb	t_expose - do_expose
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


t_expose:
t_use:	defb	0
	defb	1, dict
	defb	0



;; ( -( pour )- )
;do_pour:push	ix
;	pop	de
;	ret


	defb	t_times - do_times
; ( N8 -( fail pend )- maybe N8 :: )
do_times:
	rst	vm_rst
	defb	one_minus
	defb	  0
	defb	tickself
	defb	  do_times - $
	defb	tailpend

t_times:;;defb	1, N8
	;;defb	2, fail, tailpend
	;;defb	1, maybeN8State

	defb	t_fetchN8 - do_fetchN8
; ( A -- N8 )
do_fetchN8:	rst	pop_rst
		ld	a, (bc)
		ld	(de), a
		inc	de
		ret

t_fetchN8:	defb	1, N8Ref
		defb	0
		defb	1, N8

	defb	t_fetchE - do_fetchE
; ( A -- func )
do_fetchE:	rst	pop_rst
		ld	a, 2
		jr	do_fetch

t_fetchE:	defb	1, N8Ref
		defb	0
		defb	1, func

	defb	t_fetchS8 - do_fetchS8
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

t_fetchS8:	defb	1, S8Ref
		defb	0
		defb	1, S8

	defb	t_N8store - do_N8store
; ( N8 A -- )
do_N8store:	rst	pop_rst
do_store1:	dec	de
		ld	a, (de)
		ld	(bc), a
		ret

t_N8store:	defb	2, N8, N8Ref
		defb	0
		defb	0

	defb	t_Estore - do_Estore
; ( A A -- )
do_Estore:	rst	pop_rst
		inc	bc
do_store2:	dec	de
		ld	a, (de)
		ld	(bc), a
		dec	bc
		jr	do_store1

t_Estore:	defb	2, N8Ref, N8Ref
		defb	0
		defb	0

	defb	t_S8store - do_S8store
; ( S8 A -- )
do_S8store:	rst	pop_rst
		inc	bc
		inc	bc
		dec	de
		ld	a, (de)
		ld	(bc), a
		dec	bc
		jr	do_store2

t_S8store:	defb	2, S8, S8Ref
		defb	0
		defb	0

	defb	t_tryAt - do_tryAt
; ( a ( a -( e )- b ) A -( e \ access )- b )
do_tryAt:	push	ix
		rst	pop_rst
		push	bc
		pop	ix
		call	do_call
		pop	ix
		ret

t_tryAt:
; ( a ( a -( e )- b ) A -( e \ access )- b )
	;;defb	1, tryAtArg
	;;defb	1, tryAtEff
	;;defb	1, tryVal

; -- I/O --

	defb	t_write - do_write
; ( S8 -( emit )- )
do_write:	rst	vm_rst
		defb	tick
		defb	  bite
		defb	tick
		defb	  emit
		defb	tail
		defb	  while

	defb	t_cr - do_cr
; ( -( emit )- )
do_cr:		rst	vm_rst
		defb	litN8
		defb	  0x0A
		defb	tail
		defb	  emit

	defb	t_sp - do_sp
; ( -( emit )- )
do_sp:		rst	vm_rst
		defb	litN8
		defb	  0x20
		defb	tail
		defb	  emit

t_sp:
t_cr:	defb	0
	defb	1, emit
	defb	0

	defb	t_writeln - do_writeln
; ( S8 -( emit )- )
do_writeln:	rst	vm_rst
		defb	write
		defb	tail
		defb	  cr
t_write:
t_writeln:	defb	1, S8
		defb	1, emit
		defb	0

	defb	t_readln - do_readln
; ( -( key )- S8 )
do_readln:	rst	vm_rst
		defb	zero
		defb	litE
		defb	  end_readln - start_readln
		NOP
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
t_readln:
	defb	0
	defb	1, key
	defb	1, S8


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

