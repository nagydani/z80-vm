	defb	t_see - do_see
; ( : wrds E : code E -( emit )- )
do_see:	rst	vm_rst
	defb	use
	defb	  see_voc - $

; ---

	defb	litE
	defb	  e_in_type - do_in_type
	NOP
	; ( :code E -( emit )- E )
do_in_type:	rst	vm_rst
		defb	litS8
		DEFB	  3
		DEFB	 "in["	; TODO properly
		defb	writesp
		defb	zero	; tup
		defb	tick
		defb	  typWords
		defb	tail
		defb	  cant
e_in_type:	equ	$
	defb	local
	defb	  -4		; code
	defb	fetchE
	defb	tryAt
	defb	ascii, "]"
	defb	emit
	defb	cr

	; [ :wrds E :code E ]
	defb	local
	defb	  -2
	defb	fetchE
	; [ :wrds E :code1 E :code2 E ]
	defb	op
	; [ :wrds E :code1 E :code2 E :opcode N8 ]
	defb	litN8
		  rst	vm_rst
	; [ :wrds E :code1 E :code2 E :opcode N8 :vmrst N8 ]
	defb	litE
	defb	  e_see - s_see
	NOP
	; ( :code2 E N8 N8 -( emit )- )
s_see:		rst	vm_rst
		defb	eq
		defb	drop	; comparison
		defb	seeVm
		defb	tail
		defb	  pass
	; [ :wrds E :code1 E :code 2 E :opcode N8 :vmrst N8 :ssee E ]
e_see:	defb	local
	defb	  -10		;; wrds
	defb	tick
	defb	  tryAt
	defb	litE
	defb	  e_seeRaw - s_seeRaw
	NOP
	; ( ??? -( ??? )- ??? )
s_seeRaw:	rst	vm_rst
		defb	seeRaw
		defb	tail
		defb	  pass
e_seeRaw:	equ	$
	defb	or

	; [ :wrds E :code E ]
	defb	litE
	defb	  e_out_type - do_out_type
	NOP
	; ( :wrds E :code E -( emit )-  )
do_out_type:	rst	vm_rst
		defb	litS8
		DEFB	  5
		DEFB	  "can-("
		defb	writesp
		defb	litN8
		defb	  1		; effects
		; [ :wrds E :code E N8 ]
		defb	local
		defb	  -5		; wrds
		defb	fetchE
		; [ :wrds E :code E N8 :wrds2 E ]
		defb	cant
		defb	litS8
		defb	  e_seeOut - seeOut
seeOut:			defb	")-", 0x0A
			defb	"out["
e_seeOut:	DEFB	writesp
		defb	litN8
		defb	  2		; out type
		defb	tick
		defb	  typWords
		defb	tail
		defb	  cant
e_out_type:	equ	$
	defb	local
	defb	  -4		;; code1
	defb	fetchE
	defb	tryAt
	defb	ascii, "]"
	defb	emit
	defb	litN8, " "
	defb	emit
	DEFB	pass
	defb	tail
	DEFB	  pass

t_see:	defb	1;, vocabFunc
	defb	1, emit
	defb	0

do_seeWords:
	rst	vm_rst
	defb	litS8
	defb	  end_see_words - see_words
see_words:
	defb	see_last
	defb	"cant"
	defb	fn
	defb	"seeRec"
	defb	fn
	defb	"speak"
	defb	fn
	defb	"cite"
	defb	fn
	defb	"tell"
	defb	fn
	defb	"say"
	defb	fn
	defb	"cr!"
	defb	fn
end_see_words:	equ	$
	defb	tick
	defb	  synWords
	defb	tail
	defb	  moreWords

; ---

	defw	do_seeWords
	defw	effects_tab
see_voc:defb	0x80

; ---

; ( -( emit )- )
; number
	defw	do_see_number

; ( -( emit )- )
; printable
	defw	do_see_printable

; ( -( emit )- )
; quote
	defw	do_see_quote

; ( -( emit )- )
; brace
	defw	do_see_brace

; ( -( emit )- )
; voc
	defw	do_see_voc

; ( -( emit )- )
; fn
	defw	do_see_fn

; ( -( emit )- )
; tailFn
	defw	do_see_tailFn

; ( -( emit )- )
; failOver
	defw	do_see_failOver

; ( -( emit )- )
; selfRef
	defw	do_see_selfRef

; ( -( emit )- )
; tailSelfRef
	defw	do_see_tailSelfRef

; ( -( emit )- )
; fnRef
	defw	do_see_fnRef

; ( -( emit )- )
; tailFnRef
	defw	do_see_tailFnRef

; ( -( emit )- )
; varRef
	defw	do_see_varRef

; ( -( emit )- )
; tailVarRef
	defw	do_see_tailVarRef

; ( -( emit )- )
; makeRef
	defw	do_see_makeRef

; ( -( emit )- )
; raw
	defw	do_see_raw

; ( -( tail unpend )- )
see_tail:equ	($ - see_voc - 1) / 2 + words_first
	defw	do_see_tail

; ( -( emit fail )- )
crf:	equ	($ - see_voc - 1) / 2 + words_first
	defw	do_crf

; ( S8 -( emit )- )
writesp:equ     ($ - see_voc - 1) / 2 + words_first
	defw	do_writesp

; ( E E -( emit )- )
seeVm:	equ	($ - see_voc - 1) / 2 + words_first
	defw	do_see_vm

; ( N8 -( emit access )- )
cite:	equ	($ - see_voc - 1) / 2 + words_first
	defw	do_cite

; ( S8 -( emit access )- )
speak:	equ	($ - see_voc - 1) / 2 + words_first
	defw	do_speak

; ( E -( emit access )- )
seeRec:	equ	($ - see_voc - 1) / 2 + words_first
	defw	do_seeRec

; ( : tup N8 : voc E : base E -( ??? )- ??? )
cant:	equ	($ - see_voc - 1) / 2 + words_first
	defw	do_cant

see_last:	equ     ($ - see_voc - 1) / 2 + words_first

; ---

	NOP
do_see_number:
	rst	vm_rst
	defb	write
	defb	op
	defb	cpu
	dec	de
	xor	a
	ex	de, hl
	rld
	inc	hl
	ld	(hl), a
	call	do_see_digit
	ex	de, hl
	dec	hl
	xor	a
	rrd
	call	do_see_digit
	rst	vm_rst
	defb	crf
do_see_digit:
	ex	de, hl
	ld	a, (de)
	daa
	add	a, 0xF0
	adc	a, 0x40
do_tailemit:
	ld	(de), a
	inc	de
	rst	vm_rst
	defb	tail
	defb	  emit

	NOP
do_see_printable:
	rst	vm_rst
	defb	writesp
	defb	op
	defb	emit
	defb	tail
	defb	  crf

	NOP
do_see_quote:
	rst	vm_rst
	defb	write
	defb	op
	defb	local
	defb	  -3
	defb	fetchS8
	defb	tick
	defb	  bite
	defb	litE
	defb	  e_c_quote - c_quote
	NOP
	; ( ??? -( ??? )- ??? )
c_quote:	rst	vm_rst
		defb	litE
		defb	  e_quote - s_quote
		NOP
		; ( ??? -( ??? )- ??? )
s_quote:		rst	vm_rst
			defb	dup
			defb	stroke
			defb	drop
			defb	tail
			defb	  emit
e_quote:	defb	litE
		defb	  e_nonpr - s_nonpr
		NOP
		; ( ??? -( ??? )- ??? )
s_nonpr:		rst	vm_rst
			defb	litS8
			defb	  e_q - s_q
s_q:			defb	  "\"..", 0x0A, "\""
e_q:			defb	write
			defb	tail
			DEFB	  drop		; TODO print ascii code
e_nonpr:	defb	tail
		defb	  or
e_c_quote:	equ	$
	defb	while
	defb	ascii
	defb	  "\""
	defb	emit
	defb	adv
	defb	tail
	defb	  crf

	NOP
do_see_brace:
	rst	vm_rst
	defb	writesp
	defb	op
	defb	var
	defb	  0	; wrds
	defb	fetchE
	defb	local
	defb	  -5	; code
	defb	fetchE
	defb	op
	defb	drop	; skip type
	defb	see
	defb	ascii
	defb	  "}"
	defb	emit
	defb	adv
	defb	litN8
	defb	  1
	defb	adv	; skip more
	defb	tail
	defb	  crf

	NOP
; ( E S8 -( emit unpend fail )- E )
do_see_voc:
	rst	vm_rst
	defb	writesp
	defb	local
	defb	  -2
	defb	fetchE	; code2
	defb	op
	defb	adv	; vocab
	defb	litE
	defb	  e_list_voc - do_list_voc
		NOP
do_list_voc:	HALT
e_list_voc:	equ	$
	defb	local
	defb	  -4	; vocab
	defb	fetchE	; vocab2
	defb	tryAt
	defb	pass	; vocab
	defb	fail	; next
	defb	  0

	NOP
do_see_fn:
	rst	vm_rst
	defb	write
	defb	crf

	NOP
do_see_tailFn:
	rst	vm_rst
	defb	tick
	defb	  fn
	defb	see_tail

	NOP
do_see_failOver:
do_see_selfRef:
	rst	vm_rst
	defb	writeln
	defb	op
	defb	fail
	defb	  -1

	NOP
do_see_tailSelfRef:
	rst	vm_rst
	defb	tick
	defb	  selfRef
	defb	see_tail

	NOP
do_see_fnRef:
	rst	vm_rst
	defb	writesp
	defb	op
	defb	var
	defb	  0		; voc
	defb	fetchE
	defb	name
	defb	drop
	defb	tail
	defb	  fn

	NOP
do_see_tailFnRef:
	rst	vm_rst
	defb	tick
	defb	  fnRef
	defb	see_tail

	NOP
do_see_varRef:
	jr	do_see_failOver

	NOP
do_see_tailVarRef:
	jr	do_see_tailSelfRef

	NOP
do_see_makeRef:
	rst	vm_rst
	defb	writeln
	defb	op
	defb	drop
	defb	op
	defb	fail
	defb	  -1

	NOP
do_see_raw:
	rst	vm_rst
	defb	drip		; empty string dropped
	defb	tail
	defb	  seeRaw

	NOP
; ( -( tail unpend )- )
do_see_tail:
	rst	vm_rst
	defb	emptyE
	defb	or
	defb	unpend
	defb	tail2

	NOP
; ( -( emit fail )- )
do_crf:	rst	vm_rst
	defb	cr
	defb	fail
	defb	  0

	NOP
; ( S8 -( emit )- )
do_writesp:
	rst	vm_rst
	defb	write
	defb	litN8
	defb	  " "
	defb	tail
	defb	  emit

	NOP
; ( E -( emit )- )
do_see_vm:
	rst	vm_rst
	defb	oppend
	defb	var
	defb	  0
	defb	fetchE
	defb	name
	defb	token
	defb	tail
	defb	  call

	NOP
; ( N8 -( emit var )- )
do_cite:rst	vm_rst
	defb	var
	defb	  0
	defb	fetchE
	defb	name
	defb	drop
	defb	tail
	defb	  writesp

	NOP
do_speak:
	rst	vm_rst
	defb	scan
	defb	cite
	defb	fail
	defb	  0

	NOP
do_seeRec:
	rst	vm_rst
	
	defb	ascii
	defb	  "]"
	defb	emit
	defb	tail
	defb	  cr


	NOP
	; ( : tup N8 : voc E -( emit )- )
do_cant:	rst	vm_rst
		defb	var
		defb	  0		; code
		defb	var
		defb	  -1		; type
		defb	fetchN8
		defb	zero
		defb	litE
		defb	  e_hastype - do_hastype
		NOP
		; ( : tup N8 : voc E : base E N8 -( emit )- )
do_hastype:		rst	vm_rst
			defb	neq
			defb	adv
			defb	local
			defb	  -5	; tup
			defb	fetchN8
			defb	litE
			defb	  e_skip_rec - do_skip_rec
				NOP
do_skip_rec:			rst	vm_rst
				defb	one_minus
				defb	  0
				defb	local
				defb	  -3	; base
				defb	fetchE
				defb	op
				defb	adv
				defb	local
				defb	  -5	; base
				defb	Estore
				defb	tailself
				defb	  do_skip_rec -$
e_skip_rec:		defb	emptyE
			defb	or
			defb	op
			defb	tick
			defb	  speak
			defb	emptyE
			defb	tick
			defb	  or
			defb	local
			defb	  -11	; voc
			defb	tryAt
			defb	pass	; voc
			defb	tail
			defb	  drop	; tup
e_hastype:	defb	litE
		defb	  e_notype - do_notype
		NOP
		; ( : tup N8 : voc E : base E -( emit )- )
do_notype:		RST	vm_rst
			DEFB	pass	; base
			DEFB	pass	; voc
			DEFB	drop	; tup
			DEFB	ascii, "?"
			DEFB	emit
			DEFB	litN8, " "
			DEFB	tail
			DEFB	  emit
e_notype:	defb	tail
		defb	  or


; ---

