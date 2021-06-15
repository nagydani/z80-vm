; ( -( heap )- a )
here:	ld	bc, (DP)
	fromBC
	jp	(ix)

; ( n -( heap )- )
comma:	toBC
	push	hl
	ld	hl, (DP)
	ld	(hl), c
	inc	hl
	ld	(hl), b
commax:	inc	hl
	ld	(DP), hl
	pop	hl
	jp	(ix)

; ( c -( heap )- )
ccomma:	toBC
	push	hl
	ld	hl, (DP)
	ld	(hl), c
	jr	commax
