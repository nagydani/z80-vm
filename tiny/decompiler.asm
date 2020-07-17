; ( E;wrds E;code -( emit )- )
do_see:	rst	vm_rst
	defb	use
	defb	  see_voc - $

; ---

	defb	litE
	defb	  e_in_type - do_in_type
	NOP
	; ( ??? -( ??? )- ??? )
do_in_type:	rst	vm_rst
		defb	litS8
		DEFB	  3
			DEFB	 "in["	; TODO properly
		defb	writesp
		defb	tick
		defb	  typWords
		defb	var
		defb	  0		; code
		defb	var
		defb	  -1		; type
		defb	fetchN8
		defb	adv
		defb	tick
		defb	  seeRec
		defb	local
		defb	  -6
		defb	tryAt
		defb	tail
		defb	  pass
e_in_type:	equ	$
	defb	local
	defb	  -4
	defb	fetchE
	defb	tryAt

	defb	op
	defb	litN8
		  rst	vm_rst
	defb	litE
	defb	  e_see - s_see
	NOP
	; ( ??? -( ??? )- ??? )
s_see:		rst	vm_rst
		defb	eq
		defb	drop	; comparison
		defb	tail
		defb	  seeVm
e_see:	defb	local
	defb	  -8		;; wrds
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
	defb	tail
	defb	  or

do_seeWords:
	rst	vm_rst
	defb	litS8
	defb	  end_see_words - see_words
see_words:
	defb	see_last
	defb	"seeRec"
	defb	fn
	defb	"speak"
	defb	fn
	defb	"cite"
	defb	fn
	defb	"vm"
	defb	fn
	defb	"say"
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

see_last:	equ     ($ - see_voc - 1) / 2 + words_first

; ---

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
	defb	tail
	defb	  cr
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

do_see_printable:
	rst	vm_rst
	defb	writesp
	defb	op
	defb	emit
	defb	tail
	defb	  cr

do_see_quote:
	rst	vm_rst
	defb	writesp
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
e_q:			defb	writesp
			defb	tail
			DEFB	  drop		; TODO print ascii code
e_nonpr:	defb	tail
		defb	  or
e_c_quote:	equ	$
	defb	while
	defb	ascii
	defb	  "\""
	defb	emit
	defb	cr
	defb	tail
	defb	  adv

do_see_brace:
	rst	vm_rst
	defb	writesp
	defb	op
	defb	var
	defb	  0	; wrds
	defb	fetchE
	defb	var
	defb	  2	; code
	defb	fetchE
	defb	op
	defb	drop	; skip type
	defb	see
	defb	ascii
	defb	  "}"
	defb	emit
	defb	cr
	defb	adv
	defb	litN8
	defb	  1
	defb	tail
	defb	  adv	; skip more

do_see_voc:
	rst	vm_rst
	defb	writesp
	defb	op
	defb	make
	defb	  3, 2
	defb	adv		; voc
	defb	litE
	defb	  end_setVoc - do_setVoc
	NOP
	; ( ??? -( ??? )- ??? )
do_setVoc:	rst	vm_rst
		defb	var
		defb	  -5	; words
		defb	fetchE
		defb	local
		defb	  -8
		defb	Estore
		defb	var
		defb	  -5	; words
		defb	fetchE
		defb	litN8
		defb	  2
		defb	adv	; lenWords
		defb	op
		defb	adv
		defb	litN8
		defb	  2
		defb	bite
		defb	drop
		defb	bite
		defb	var
		defb	  -5
		defb	fetchE
		defb	name
		defb	drop
		defb	writeln
		defb	drip

		defb	zero
		defb	var
		defb	  -5
		defb	fetchE
		defb	litE
		defb	  end_countVoc - do_countVoc
		NOP
		; ( ??? -( ??? )- ??? )
do_countVoc:		rst	vm_rst
			defb	call
			defb	var
			defb	  -1
			defb	fetchN8
			defb	local
			defb	  -6
			defb	fetchN8
			defb	tick
			defb	  ge
			defb	failor
			defb	  -4
			defb	drop
			defb	make
			defb	  9, 4
			defb	local
			defb	  -10
			defb	N8store
			defb	local
			defb	  -12
			defb	S8store
			defb	local
			defb	  -5
			defb	fetchN8
			defb	one_plus
			defb	  0
			defb	local
			defb	  -6
			defb	N8store
			defb	fail
			defb	  0
end_countVoc:	defb	emptyE
		defb	or

		defb	var
		defb	  0
		defb	litE
		defb	  end_listVoc - do_listVoc
		NOP
; ( S8;nam N8;cls N8;num E;tab -( fail emit )- )
do_listVoc:		rst	vm_rst
			defb	local
			defb	  -3
			defb	fetchN8
			defb	one_minus
			defb	  0
			defb	var
			defb	  -5
			defb	fetchE
			defb	local
			defb	  -5
			defb	fetchE
			defb	fetchE
			defb	ascii
			defb	  "{"
			defb	emit
			defb	cr
			defb	see
			defb	litS8
			defb	  e_endBody - s_endBody
s_endBody:		defb	  "} \" "
e_endBody:		defb	write
			defb	local
			defb	  -8
			defb	fetchS8
			defb	write
			defb	ascii
			defb	  "\""
			defb	emit
			defb	litN8
			defb	  " "
			defb	emit
			defb	local
			defb	  -5
			defb	fetchN8
			defb	var
			defb	  -5
			defb	fetchE
			defb	name
			defb	drop
			defb	writeln
			defb	local
			defb	  -8
			defb	N8store
			defb	litN8
			defb	  2
			defb	adv
			defb	local
			defb	  -6
			defb	Estore
			defb	tail
			defb	  pass
end_listVoc:	defb	emptyE
		defb	tail
		defb	  while

end_setVoc:	equ	$
	defb	local
	defb	  -4		; voc
	defb	fetchE
	defb	tryAt
	defb	pass
	defb	tail
	defb	  drip

do_see_fn:
	jp	do_writeln

do_see_tailFn:
	rst	vm_rst
	defb	fn
	defb	fail
	defb	  -4

do_see_failOver:
do_see_selfRef:
	rst	vm_rst
	defb	writeln
	defb	op
	defb	tail
	defb	  drop

do_see_tailSelfRef:
	rst	vm_rst
	defb	selfRef
	defb	fail
	defb	  -4

do_see_fnRef:
	rst	vm_rst
	defb	writesp
	defb	op
	defb	local
	defb	  -5
	defb	fetchE
	defb	name
	defb	drop
	defb	tail
	defb	  writeln

do_see_tailFnRef:
	rst	vm_rst
	defb	fnRef
	defb	fail
	defb	  -4

do_see_varRef:
	jr	do_see_failOver
do_see_tailVarRef:
	jr	do_see_tailSelfRef
do_see_makeRef:
	rst	vm_rst
	defb	writeln
	defb	op
	defb	drop
	defb	op
	defb	tail
	defb	  drop

do_see_raw:
	rst	vm_rst
	defb	drip		; empty string dropped
	defb	seeRaw
	defb	fail
	defb	  -2

; ( S8 -( emit )- )
do_writesp:
	rst	vm_rst
	defb	write
	defb	litN8
	defb	  " "
	defb	tail
	defb	  emit

do_see_vm:
	rst	vm_rst
	defb	litE
	defb	  do_fnScan_end - do_fnScan
	NOP
; ( E -( fail emit )- E )
do_fnScan:	rst	vm_rst
		defb	op
		defb	var
		defb	  0
		defb	fetchE
		defb	name
		defb	token	; ( E S8 -( emit )- )
		defb	tail
		defb	  call
do_fnScan_end:	equ	$
	defb	emptyE
	defb	tail
	defb	  while

; ( N8 -( emit var )- )
do_cite:rst	vm_rst
	defb	var
	defb	  0
	defb	fetchE
	defb	name
	defb	drop
	defb	tail
	defb	  writesp

do_speak:
	rst	vm_rst
	defb	scan
	defb	cite
	defb	fail
	defb	  0

do_seeRec:
	rst	vm_rst
	defb	op
	defb	tick
	defb	  speak
	defb	emptyE
	defb	or
	defb	ascii
	defb	  "]"
	defb	emit
	defb	tail
	defb	  cr

; ---

