litN16:	ldi
	ldi
	jp	(ix)

litN8:	ldi
	xor	a
	ld	(de), a
	inc	de
	jp	(ix)

litS8:	ld	c, (hl)
	inc	hl
	ld	b, 0
	ex	de, hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
	inc	hl
	ld	(hl), c
	inc	hl
	ld	(hl), b
lit_e:	inc	hl
	ex	de, hl
	add	hl, bc
	jp	(ix)

litE8:	ld	c, (hl)
	inc	hl
	ld	b, 0
	ex	de, hl
	ld	(hl), e
	inc	hl
	ld	(hl), d
	jr	lit_e
