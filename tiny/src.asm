	defb	t_stroke - do_stroke
; ( N8 -( fail )- maybe C8 )
do_stroke:	dec	de
		ld	a, (de)
		cp	"!"
		ret	c
		add	a, a
		ret	c
		inc	de
		ret
t_stroke:
	defb	1, N8
	defb	1, fail
	defb	1, C8

	defb	t_verbatim - do_verbatim
; ( S8 S8 -( fail )- maybe S8 )
do_verbatim:	rst	vm_rst
		defb	local
		defb	  -4
		defb	fetchN8
		defb	tick
		defb	  eq
		defb	failor
		defb	  -5
		defb	local
		defb	  -6
		defb	fetchS8
		defb	litE
		defb	  S8check_end - S8check
		NOP
		; ( S8 S8 -( fail )- S8 maybe S8 N8 S8 N8 N8 )
S8check:		rst	vm_rst
			defb	bite
			defb	local
			defb	  -7
			defb	fetchS8
			defb	bite		; cannot fail
			defb	local
			defb	  -5
			defb	tail
			defb	  fetchN8
S8check_end:	defb	litE
		defb	  S8match_end - S8match
		NOP
		; ( S8 S8 N8 S8 N8 N8 -( fail )- maybe S8 S8 )
S8match:		rst	vm_rst
			defb	tick
			defb	  eq
			defb	failor
			defb	  -10
			defb	drop
			defb	local
			defb	  -10
			defb	S8store
			defb	tail
			defb	  drop
S8match_end:	defb	tick
		defb	  while
		defb	failor
		defb	  -3
		defb	tail
		defb	  drip
t_verbatim:
	defb	2, S8, S8
	defb	1, fail
	defb	1, S8

	defb	t_words - do_words
; ( S8 -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
do_words:	rst	vm_rst
		defb	bite
		defb	litE
		defb	  words_g_e - words_g
		NOP
		; ( ??? -( ??? )- ??? )
words_g:		rst	vm_rst
			defb	one_minus
			defb	  words_l - $
			defb	local
			defb	  -4		; current word
			defb	fetchS8		; fetch it
			defb	drop
			defb	zero		; set length to zero
			defb	local
			defb	  -7		; current word
			defb	fetchS8		; fetch it
			defb	tick
			defb	  bite
			defb	failor
			defb	  -7
			defb	litE
			defb	  words_n_e - words_n
			NOP
			; ( ??? -( ??? )- ??? )
words_n:			dec	de
				ld	a, l
				ex	af, af'
				ld	  a, (de)
				add	a, a
words_loop:			ret	c
				ex	de, hl
				dec	hl
				ld	e, (hl)
				dec	hl
				ld	b, (hl)
				dec	hl
				ld	c, (hl)
				dec	hl
words_lp:			ld	a, (bc)
				inc	(hl)
				inc	bc
				dec	e
				add	a, a
				jr	nc, words_lp
				inc	hl
				ld	(hl), c
				inc	hl
				ld	(hl), b
				inc	hl
				ld	(hl), e
				inc	hl
				ex	de, hl
				ex	af, af'
				ld	l, a
				scf
				ret
words_n_e:		defb	litE
			defb	  words_a_e - words_a
			NOP
			; ( ??? -( ??? )- ??? )
words_a:			rst	vm_rst
				defb	local
				defb	  -10
				defb	S8store
				defb	one_plus
				defb	  0
				defb	tail
				defb	  chop
words_a_e:		defb	or
			defb	tickself
			defb	  words_g - $
			defb	tailpend
words_g_e:	defb	tail
		defb	  call

words_l:	defb	fail
		defb	  -3

; ( S8 -( fail pend )- maybe S8;wrds N8;tkn ;; S8;wrd N8;cls )
t_words:defb	1, S8
	defb	2, fail, tailpend
	defb	5, S8, N8, state, S8, N8

	defb	t_name - do_name
; ( N8;idx E;voc -- S8;wrd N8;cls )
do_name:	rst	vm_rst
		defb	make
		defb	  1 + 2, 3 + 1
		defb	call
		defb	local
		defb	  -5	; tkn
		defb	fetchN8
		defb	local
		defb	  -10	; idx
		defb	fetchN8
		defb	tick
		defb	  eq
		defb	failor
		defb	  -4
		defb	drop
		defb	unpend
		defb	local
		defb	  -10
		defb	N8store
		defb	local
		defb	  -12
		defb	S8store
		defb	pass
		defb	tail
		defb	  drip

; ( N8;idx E;voc -- S8;wrd N8;cls )
t_name:	defb	2, N8, vocab
	defb	0
	defb	2, S8, N8

	defb	t_index - do_index
; ( S8;nam E;voc -- N8;idx N8;cls )
do_index:	rst	vm_rst
		defb	make
		defb	  3 + 2, 1 + 1
		defb	call
		defb	local
		defb	  -4	; wrd
		defb	fetchS8
		defb	local
		defb	  -14
		defb	fetchS8
		defb	tick
		defb	  verbatim
		defb	failor
		defb	  -4
		defb	drip
		defb	unpend
		defb	local
		defb	  -12
		defb	N8store
		defb	drip
		defb	local
		defb	  -9
		defb	N8store
		defb	drip
		defb	tail
		defb	  drip

; ( S8;nam E;voc -- N8;idx N8;cls )
t_index:defb	2, S8, vocab
	defb	0
	defb	2, N8, N8

	defb	t_backtick - do_backtick
; ( (?) -- (?)` )
do_backtick:rst	pop_rst
	dec	bc
advBC:	ld	a, (bc)
	add	a, c
	ld	c, a
	ld	a, 0
	adc	a, b
	ld	b, a
	jp	pushBC
t_backtick:
	defb	1, func
	defb	0
	defb	1, funcType

	defb	t_arg - do_arg
; ( F -- [?] )
do_arg:	ret

t_arg:	defb	1, funcType
	defb	0
	defb	1, recType

	defb	t_eff - do_eff
; ( F -- -(?)- )
do_eff:	call	backtick
advBC2:	rst	pop_rst
	jr	advBC

t_eff:	defb	1, funcType
	defb	0
;;	defb	1, effs

	defb	t_val - do_val
; ( F -- [?] )
do_val:	call	do_eff
	jr	advBC2

t_val:	defb	1, funcType
	defb	0
	defb	1, recType

	defb	t_fnType - do_fnType
; ( ( a -( b )- c ) -( emit )- )
do_fnType:	rst	vm_rst
		defb	backtick
		

t_fnType:	defb	1, func
		defb	1, emit
		defb	0
