oneminus:
	toBC
	ld	a, b
	or	c
	jr	z, bump
	inc	hl
	dec	bc
	fromBC
	jp	(ix)

bump:	xor	a
	ld	c, (hl)
	cp	c
	jp	z, fail
	ld	b, a
	add	hl, bc
	jp	(ix)
