; ( S8 -( key emit )- )
do_comp:rst	vm_rst
	defb	use
	defb	  end_comp_local - comp_local
comp_local:	defw	core_tab
comp_voc:	defb	0x100 - core1_last

comp_tab:	equ	$

; ---

; ( -( key emit )- )
quote:	equ	$ - comp_tab + core1_last
	defb	do_quote - $

; ( -( key emit )- )
brace:	equ	$ - comp_tab + core1_last
	defb	do_brace - $

; ( -( key emit )- )
voc:	equ	$ - comp_tab + core1_last
	defb	do_voc - $

; ( -( key emit )- )
fn:	equ	$ - comp_tab + core1_last
	defb	do_fn - $

; ( -( key emit )- )
fnRef:	equ	$ - comp_tab + core1_last
	defb	do_fnRef - $

; ( -( key emit )- )
selfRef:equ	$ - comp_tab + core1_last
	defb	do_selfRef - $

; ( -( key emit )- )
raw:	equ	$ - comp_tab + core1_last
	defb	do_raw - $

; ( -( key )- S8 )
word:	equ	$ - comp_tab + core1_last
	defb	do_word - $

; ---

do_quote:
do_brace:
do_voc:
do_fn:
do_fnRef:
do_selfRef:
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
			defb	pend
			defb	  word_s - $
word_e:		defb	call
		defb	append
		defb	fail
word_a:	defb	tick
	defb	  string
	defb	tail
	defb	  or

end_comp_local:	equ	$

	defb	litE
	defb	  end_parse - parse
parse:		rst	vm_rst
		defb	word
		defb	pend
		defb	  parse - $
end_parse:
	defb	tick
	defb	  writeln
	defb	tail
	defb	  or

; ---

