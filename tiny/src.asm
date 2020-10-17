; ( N8 -( fail )- maybe C8 )
do_stroke:	dec	de
		ld	a, (de)
		cp	"!"
		ret	c
		add	a, a
		ret	c
		inc	de
		ret

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

; ( S8 -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
do_words:	rst	vm_rst
		defb	bite
		defb	litE
		defb	  words_g_e - words_g
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

; ( N8 -( emit )- )
do_indent:	rst	vm_rst
		defb	litE
		defb	  indent_e - indent_s
indent_s:		rst	vm_rst
			defb	one_minus
			defb	  0
			defb	litN8
			defb	  0x09  ; tab
			defb	emit
			defb	tailself
			defb	  indent_s - $
indent_e:		equ  $
		defb	emptyE
		defb	tail
		defb	  or

; ( S8 -( write )- )
do_writesp:	rst	vm_rst
		defb	write
		defb	litN8
		defb	  " "
		defb	tail
		defb	  emit

; ( N8 -( emit )- )
do_hexnum:
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
