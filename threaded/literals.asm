sopen_link:
	defw	link_final_comments
	defb	"s{{", 0
	defw	comma

; ( -( heap )- a )
sopen:	vm
	defw	litS8
	defb	  litS8e - litS8
litS8:		ld	c, (hl)
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
litS8e:	defw	comma
	defw	litN8
	defb	  0
	defw	ccomma
	defw	tail, here

vmcomma_link:
	defw	sopen_link
	defb	"vm,", 0
	defw	comma

vmcomma:vm
	defw	litN8
		  vm
	defw	tail, ccomma

qopen_link:
	defw	vmcomma_link
	defb	"{{", 0
	defw	comma

qopen:	vm
	defw	sopen
	defw	tail, vmcomma

sclose_link:
	defw	qopen_link
	defb	"}}", 0
	defw	comma

; ( a -( heap )- )
sclose:	vm
	defw	dup		; a a
	defw	here		; a a b
	defw	swap		; a b a
	defw	minus		; a l
	defw	swap		; l a
	defw	oneminus	; l a
	defw	tail, cstore

literal_link:
	defw	sclose_link
	defb	"literal", 0
	defw	comma

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
lit16e:	defw	tailor


tolit_link:
	defw	literal_link
	defb	">lit", 0
	defw	comma

tolit:	vm
	defw	exec
	defw	tail, literal

tick_link:
	defw	tolit_link
	defb	"'", 0
	defw	tolit

tick:	vm
	defw	word
	defw	find
	defw	tail, cellplus

ascii_link:
	defw	tick_link
	defb	"ascii", 0
	defw	tolit

ascii:	vm
	defw	word
	defw	pad
	defw	tail, cfetch

bite_link:
	defw	ascii_link
	defb	"bite", 0
	defw	comma

bite:	vm
	defw	tib
	defw	fetch	; tib
	defw	dup	; tib tib
	defw	cfetch	; tib c
	defw	nonzero
	defw	swap	; c tib
	defw	oneplus	; c tib
	defw	tib
	defw	tail, store	; c

link_final_literal:
quote_link:
	defw	bite_link
	defb	"\"", 0
	defw	quotate

quote:	vm
	defw	here
	defw	bite
	defw	drop
	defw	litS8
	defb	  quot1e - quot1
quot1:		vm
		defw	bite
		defw	litN8
		defb	  "\""
		defw	neq
		defw	ccomma
		defw	tailself
		defb	  quot1 - $
quot1e:	defw	litS8
	defb	  quot2e - quot2
quot2:		vm
		defw	litN8
		defb	  0
		defw	tail, ccomma
quot2e:	defw	tailor

