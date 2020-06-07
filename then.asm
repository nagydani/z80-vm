; Roll back the topmost handler
then:	ld	sp, (ERR_SP)	; restore stack pointer
	pop	hl		; HL = old ERR_SP
	ld	(ERR_SP), hl	; restore ERR_SP
	pop	bc		; BC = previous handler address
	pop	hl		; HL = effect address
	inc	hl
	ld	(hl), c		; restore handler address low
	inc	hl
	ld	(hl), b		; restore handler address high
	pop	hl		; restore HL
	jp	(ix)
