litS8:	ld	c, (hl)
	inc	hl
	ld	b, 0
	ex	de, hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
	inc	hl
	ex	de, hl
	add	hl, bc
	jp	(ix)

literal_link:
	defw	link_final_io
	defb	"literal", 0
	defw	exec

literal:vm
	defw	litS8
	defb	  lit8e - lit8
lit8:		vm
		defw	litN8
		defb	  255
		defw	le
		defw	litS8
		defb	  litN8e - litN8
litN8:			ldi
			xor	a
			ld	(de), a
			inc	de
			jp	(ix)
litN8e:		defw	comma
		defw	tail, ccomma
lit8e:	defw	litS8
	defb	  lit16e - lit16
lit16:		vm
		defw	litS8
		defb	  litN16e - litN16
litN16:			ldi
			ldi
			jp	(ix)
litN16e:	defw	comma
		defw	tail, comma
lit16e:	defw	tail, or


tolit_link:
	defw	literal_link
	defb	">lit", 0
	defw	comma

tolit:	vm
	defw	exec
	defw	tail, literal

link_final_literal:
tick_link:
	defw	tolit_link
	defb	"'", 0
	defw	tolit

tick:	vm
	defw	word
	defw	find
	defw	tail, cellplus
