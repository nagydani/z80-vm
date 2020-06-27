; ( S8 -( key emit )- )
do_comp:rst	vm_rst
	defb	use
	defb	  end_comp_local - comp_local
comp_local:	defw	seed_tab
comp_voc:	defb	0x100 - seed_last

comp_tab:	equ	$

; ---

; ( C8 -( fail )- C8 )
stroke:	equ	$ - comp_tab + seed_last
	defb	do_stroke - $

; ( -( key )- S8 )
word:	equ	$ - comp_tab + seed_last
	defb	do_word - $

; ( -( key emit )- )
quot:	equ	$ - comp_tab + seed_last
	defb	do_quot - $

; ( -( key emit )- )
brace:	equ	$ - comp_tab + seed_last
	defb	do_brace - $

; ( -( key emit )- )
voc:	equ	$ - comp_tab + seed_last
	defb	do_voc - $

; ( -( key emit )- )
fn:	equ	$ - comp_tab + seed_last
	defb	do_fn - $

; ( -( key emit )- )
fnRef:	equ	$ - comp_tab + seed_last
	defb	do_fnRef - $

; ( -( key emit )- )
selfRef:equ	$ - comp_tab + seed_last
	defb	do_selfRef - $


; ---

; ( C8 -( fail )- C8 )
do_stroke:
	dec	de
	ld	a, (de)
	inc	de
	cp	"!"
	ret	nc
	dec	de
	ret

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

do_quot:
do_brace:
do_voc:
do_fn:
do_fnRef:
do_selfRef:


end_comp_local:	equ	$



; ---

