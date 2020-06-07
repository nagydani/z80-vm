; Mutate an integer argument in the stack
N_chg:	push	hl
	ld	a, (de)
	inc	de
	ld	l, a
	ld	h, 0

; Mutate the referenced integer argument in the stack
N_mut:	add	hl, sp
	pop	bc
	ld	(hl), c
	inc	hl
	ld	(hl), b
	pop	hl
	jp	(ix)


