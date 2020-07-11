; ( S8 -( key emit )- )
do_comp:rst	vm_rst
	defb	use
	defb	  end_comp_voc - comp_voc
		defw	effects_tab
comp_voc:	defb	words_first

; ---

; ( -( key emit )- )
; number
	defw	do_number

; ( -( key emit )- )
; printable
	defw	do_printable

; ( -( key emit )- )
; quote
	defw	do_quote

; ( -( key emit )- )
; brace
	defw	do_brace

; ( -( key emit )- )
; voc
	defw	do_voc

; ( -( key emit )- )
; fn
	defw	do_fn

; ( -( key emit )- )
; failOver
	defw	do_failOver

; ( -( key emit )- )
; selfRef
	defw	do_selfRef

; ( -( key emit )- )
; fnRef
	defw	do_fnRef

; ( -( key emit )- )
; varRef
	defw	do_varRef

; ( -( key emit )- )
; makeRef
	defw	do_makeRef

; ( -( key emit )- )
; raw
	defw	do_raw

; ( -( key )- S8 )
word:	equ	($ - comp_voc - 1) / 2 + words_first
	defw	do_word

; ---

do_number:
do_printable:
do_quote:
do_brace:
do_voc:
do_fn:
do_failOver:
do_fnRef:
do_selfRef:
do_varRef:
do_makeRef:
do_raw:

; ( -( key )- S8 )
do_word:rst	vm_rst
	defb	zero
	defb	litE
	defb	  word_a - word_r
word_r:		rst	vm_rst
		defb	litE
		defb	  word_e - word_s
word_s:			rst	vm_rst
			defb	key
			defb	stroke
			defb	tickself
			defb	  word_s - $
			defb	tailpend
word_e:		defb	call
		defb	append
		defb	fail
word_a:	defb	tick
	defb	  string
	defb	tail
	defb	  or

end_comp_voc:	equ	$

	defb	litE
	defb	  end_parse - parse
parse:		rst	vm_rst
		defb	word
		defb	tickself
		defb	  parse - $
		defb	tailpend
end_parse:
	defb	tick
	defb	  writeln
	defb	tail
	defb	  or

; ---

