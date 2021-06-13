; ( a b -- b a )
swap:	toBC
	push	bc
	toBC
	push	bc
	pop	af
	pop	bc
	push	af
	fromBC
	pop	bc
	fromBC
	jp	(ix)

; ( a b -- a b a )
over:	push	hl
	ld	hl, -4
	jr	ontop

; ( a -- a a )
dup:	push	hl
	ld	hl, -2
ontop:	add	hl, de
	ldi
	ldi
	pop	hl
	jp	(ix)

; ( a -- )
drop:	dec	de
	dec	de
	jp	(ix)
