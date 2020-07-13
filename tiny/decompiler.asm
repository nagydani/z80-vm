; ( E;wrds E;code -( fail emit )- )
do_see:	rst	vm_rst
	defb	use
	defb	  end_see_voc - see_voc
		defw	do_seeWords
		defw	effects_tab
see_voc:	defb	0x80

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
writesp:	equ     ($ - see_voc - 1) / 2 + words_first
	defw	do_writesp

; ( S8 -( fail )- S8 E)
maul:	equ     ($ - see_voc - 1) / 2 + words_first
	defw	do_maul

see_last:	equ     ($ - see_voc - 1) / 2 + words_first

; ---

do_see_number:
	rst	vm_rst
	defb	write
	defb	bite
	defb	swap
	defb	drop
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
	defb	bite
	defb	swap
	defb	drop
	defb	emit
	defb	tail
	defb	  cr

do_see_quote:
	rst	vm_rst
	defb	writesp
	defb	bite
	defb	swap
	defb	drop
	defb	local
	defb	  -3
	defb	fetchS8
	defb	tick
	defb	  bite
	defb	litE
	defb	  e_c_quote - c_quote
c_quote:	rst	vm_rst
		defb	litE
		defb	  e_quote - s_quote
s_quote:		rst	vm_rst
			defb	dup
			defb	stroke
			defb	drop
			defb	tail
			defb	  emit
e_quote:	defb	litE
		defb	  e_nonpr - s_nonpr
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
	defb	writeln
	defb	bite
	defb	swap
	defb	drop
	defb	local
	defb	  -5	; wrds
	defb	fetchE
	defb	local
	defb	  -5	; code
	defb	fetchE
	defb	see
	defb	ascii
	defb	  "}"
	defb	emit
	defb	cr
	defb	tail
	defb	  adv

do_see_voc:
	rst	vm_rst
	defb	writesp
	defb	bite
	defb	swap
	defb	drop
	defb	local
	defb	  -3	; code
	defb	fetchS8
	defb	maul
	DEFB	cpu
	HALT

do_see_fn:
	rst	vm_rst
	defb	writeln
	defb	tail
	defb	  drop

do_see_tailFn:
	rst	vm_rst
	defb	fn
	defb	fail
	defb	  -4

do_see_failOver:
do_see_selfRef:
	rst	vm_rst
	defb	writeln
	defb	bite
	defb	drop
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
	defb	bite
	defb	swap
	defb	drop
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
	defb	bite
	defb	drop
	defb	bite
	defb	drop
	defb	tail
	defb	  drop

do_see_raw:
	rst	vm_rst
	defb	tail
	defb	  seeRaw

; ( S8 -( emit )- )
do_writesp:
	rst	vm_rst
	defb	write
	defb	litN8
	defb	  " "
	defb	tail
	defb	  emit

; ( S8 -( fail )- maybe S8 E )
do_maul:rst	vm_rst
	defb	make
	defb	  3, 5
	defb	tick
	defb	  bite
	defb	failor
	defb	  -5
	defb	local
	defb	  -6
	defb	N8store
	defb	tick
	defb	  bite
	defb	failor
	defb	  -5
	defb	local
	defb	  -5
	defb	N8store
	defb	local
	defb	  -8
	defb	tail
	defb	  S8store

; ---

end_see_voc:	equ	$

; ( E E -( emit fail )- )
	defb	litN8
	defb	  1
	defb	bite
	defb	litN8
		  rst	vm_rst
	defb	tick
	defb	  eq
	defb	tick
	defb	  seeRaw
	defb	or
	defb	drop		; comparison
	defb	drop		; zero
	defb	litE
	defb	  do_fnScan_end - do_fnScan
; ( E E -( fail emit )- S8 S8 S8 N8)
do_fnScan:	rst	vm_rst
		defb	litN8
		defb	  3
		defb	bite
		defb	local
		defb	  -6
		defb	fetchE
		defb	name
		defb	token
		defb	call
		defb	tailself
		defb	  do_fnScan - $
do_fnScan_end:	equ	$
	defb	emptyE
	defb	tail
	defb	  or

do_seeWords:
	rst	vm_rst
	defb	litS8
	defb	  end_see_words - see_words
see_words:
	defb	see_last
	defb	"maul"
	defb	fn
	defb	"say"
	defb	fn
end_see_words:	equ	$
	defb	tick
	defb	  synWords
	defb	tail
	defb	  moreWords
