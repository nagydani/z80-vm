; ( -( key emit )- )
do_comp:

comp_tab: equ	$

; ---

; ( C8 -( fail )- C8 )
stroke:	equ	$ - comp_tab - seed_last
	defb	do_stroke - $

; ( N8 C8 -- S8 )
word:	equ	$ - comp_tab - seed_last
	defb	do_word - $

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

; ( N8 C8 -- S8 )
do_word:
	rst	vm_rst
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
