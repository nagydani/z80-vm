; Mutate an integer argument in the stack
; N
Nchg:	push	hl
	ld	a, (de)
	inc	de
	ld	l, a
	ld	h, 0

; Mutate the referenced integer argument in the stack
; N N:depth
mut:	add	hl, sp
	pop	bc
	ld	(hl), c
	inc	hl
	ld	(hl), b
	pop	hl
	jp	(ix)


