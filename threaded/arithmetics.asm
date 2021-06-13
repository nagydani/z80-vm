oneminus:
	toBC
	dec	bc
	fromBC
	ld	a, b
	and	c
	add	a, 1
	jp	(ix)
