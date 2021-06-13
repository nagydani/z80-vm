; ( n -( carry )- n )
oneminus:
	toBC
	dec	bc
	fromBC
	ld	a, b
	and	c
	add	a, 1
	jp	(ix)

; ( n -( carry )- n )
oneplus:toBC
	inc	bc
	fromBC
	ld	a, b
	or	c
	sub	a, 1
	jp	(ix)

; ( n n -( carry )- n )
plus:	toBC
	push	bc
	toBC
	ex	(sp), hl
	add	hl, bc
	ld	c, l
	ld	b, h
	pop	hl
	fromBC
	jp	(ix)

; ( n n -- n )
band:	toBC
	dec	de
	ld	a, (de)
	and	b
	ld	(de), a
	dec	de
	ld	a, (de)
	and	c
	ld	(de), a
	inc	de
	inc	de
	jp	(ix)

; ( a -- a )
cellplus:
	toBC
	inc	bc
	inc	bc
	fromBC
	jp	(ix)
