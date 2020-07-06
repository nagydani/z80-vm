; ( S8 E -( fail emit )- )
do_see:	rst	vm_rst
	defb	use
	defb	  end_see_local - see_local
see_local:	defw	effects_tab
see_voc:	defb	0x80

; ---

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
; fnRef
	defw	do_see_fnRef

; ( -( emit )- )
; failOver
	defw	do_see_failOver

; ( -( emit )- )
; selfRef
	defw	do_see_selfRef

; ( -( emit )- )
; varRef
	defw	do_see_varRef

; ( -( emit )- )
; raw
	defw	do_see_raw

; ( S8 -( emit )- )
writesp:	equ     ($ - see_voc - 1) / 2 + words_first
	defw	do_writesp

; ( N8 S8 -( emit )- )
see_word:	equ	($ - see_voc - 1) / 2 + words_first
	defw	do_see_word

; ---

do_see_quote:
	rst	vm_rst
	defb	writesp
	defb	varS8
	defb	  -2
	defb	bite
	defb	swap
	defb	drop
	defb	write
	defb	litN8
	defb	  "\""
	defb	emit
	defb	litN8
	defb	  0xA
	defb	tail
	defb	  emit

do_see_brace:
	defb	vm_rst
	defb	writeln
	defb	varS8
	defb	  -2
	defb	bite		; length
	defb	varE
	defb	  +5		; quotation
	

do_see_voc:
	

do_see_fn:
	rst	vm_rst
	defb	tail
	defb	  writeln

do_see_failOver:
do_see_selfRef:
	defb	vm_rst
	defb	writeln
	defb	varS8
	defb	  -2
	defb	bite
	defb	drop
	defb	letS8
	defb	  -2
	defb	tail
	defb	  ok

do_see_fnRef:
	rst	vm_rst
	defb	writesp
	defb	varS8
	defb	  -2
	defb	bite
	defb	varS8
	defb	  -5
	defb	see_word
	defb	drop
	defb	writeln
	defb	letS8
	defb	  -2
	defb	tail
	defb	  ok

do_see_varRef:
do_see_raw:

; ( S8 -( emit )- )
do_writesp:
	rst	vm_rst
	defb	write
	defb	litN8
	defb	  " "
	defb	tail
	defb	  emit

; ( N8:token S8:words -- S8:word N8:wordClass )
do_see_word:
	rst	vm_rst
	defb	words
	defb	varN8
	defb	  -5
	defb	eq
	defb	found
	defb	pour
	defb	tail
	defb	  drop

; ---

end_see_local:	equ	$

; ( S8 E -( fail emit )- )

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
	defb	drop
	defb	locals
	defb	litE
	defb	  end_see_scan - see_scan
see_scan:	defb	litN8
		defb	  2
		defb	bite
		defb	varS8
		defb	  -5
		defb	words
		defb	token
		defb	call
		defb	drop
		defb	tailself
		defb	  see_scan - $
end_see_scan:	equ	$
	defb	tail
	defb	  call
