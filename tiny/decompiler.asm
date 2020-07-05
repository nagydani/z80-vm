; ( S8 E -( emit )- )
do_see:	rst	vm_rst
	defb	use
	defb	  end_see_local - see_local
see_local:	defw	io_tab
see_voc:	defb	0x100 - io_last

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
; failOver
	defw	do_see_failOver

; ( -( emit )- )
; fnRef
	defw	do_see_fnRef

; ( -( emit )- )
; selfRef
	defw	do_see_selfRef

; ( -( emit )- )
; varRef
	defw	do_see_varRef

; ( -( emit )- )
; raw
	defw	do_see_raw

; ---

do_see_quote:
do_see_brace:
do_see_voc:
do_see_fn:
do_see_failOver:
do_see_fnRef:
do_see_selfRef:
do_see_varRef:
do_see_raw:

; ---

end_see_local:	equ	$

	defb	locals
	defb	  -5
	defb	litE
	defb	  end_see_scan - see_scan
see_scan:	defb	litN8
		defb	  1
		defb	bite
		defb	varS8
		defb	  -5
		defb	words
		defb	varN8
		defb	  +5
		defb	varN8
		defb	  +2
		defb	eq
		defb	drop		; code
		defb	drop		; word type
		defb	writeln
		defb	fail
end_see_scan:	equ	$
	
