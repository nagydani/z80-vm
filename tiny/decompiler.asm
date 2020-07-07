; ( S8 E -( fail emit )- )
do_see:	rst	vm_rst
	defb	use
	defb	  end_see_voc - see_voc
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

do_see_number:
	rst	vm_rst
	defb	write
	defb	bite
	defb	cpu
	dec	de
	xor	a
	ex	de, hl
	rrd
	inc	hl
	ld	(hl), a
	inc	hl
	ex	de, hl
	call	do_see_digit
do_see_digit:
	dec	de
	ld	a, (de)
	add	a, 0x80
	daa
	adc	a, 0x40
	daa
	and	a
	ld	(de), a
	inc	de
	rst	vm_rst
	defb	tail
	defb	  emit

do_see_printable:

do_see_quote:

do_see_brace:
	defb	vm_rst
	defb	writeln
;	defb	varS8
	defb	  -2
	defb	bite		; length
;	defb	varE
	defb	  +5		; quotation
	

do_see_voc:
	

do_see_fn:
	rst	vm_rst
	defb	writeln
	defb	tail
	defb	  drop

do_see_failOver:
do_see_selfRef:

do_see_fnRef:
	rst	vm_rst
	defb	writesp
	defb	bite
;	defb	varS8
	defb	  -6
	defb	see_word
	defb	drop
	defb	tail
	defb	  fn

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

; ( N8:token S8:words -( fail pend )- S8:word N8:wordClass )
do_see_word:
	rst	vm_rst
	defb	words
	defb	drop
;	defb	varN8
	defb	  -1
;	defb	varN8
	defb	  -5
	defb	eq
	defb	tail
	defb	  drop

; ---

end_see_voc:	equ	$

; ( S8 E -( emit )- )
;	defb	locals
	defb	  -5
	defb	litN8
	defb	  1
	defb	bite
;	defb	litN8
		  rst	vm_rst
	defb	tick
	defb	  eq
	defb	litE
	defb	  end_seeRawFn - do_seeRawFn
do_seeRawFn:	rst	vm_rst
		defb	drop
		defb	litS8
		defb	  end_tailRaw - tailRaw
tailRaw:		defm	"~raw"
end_tailRaw:	defb	writeln
		defb	fail
end_seeRawFn:	equ	$
	defb	or
	defb	drop		; comparison
	defb	drop		; zero
	defb	litE
	defb	  do_fnScan_end - do_fnScan
; ( S8 E -( fail emit )- S8 S8 S8 N8)
do_fnScan:	rst	vm_rst
		defb	litN8
		defb	  2
		defb	bite
;		defb	varS8
		defb	  -5		; words
		defb	see_word
		defb	token
		defb	call
		defb	fail
do_fnScan_end:	equ	$
	defb	emptyE
	defb	tail
	defb	  or
