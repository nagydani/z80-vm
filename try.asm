; Set new effect handler address
; followed by effect to handle and the new handler address
; places three words on the stack: effect address, old handler address, old ERR_SP
try:	push	hl		; save HL
	ex	de, hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)		; DE = effect to handle
	inc	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)		; BC = new handler address
	inc	hl
	ex	de, hl		; HL = effect to handle
	inc	hl
	ld	a, (hl)
	ld	(hl), c
	ld	c, a
	inc	hl
	ld	a, (hl)
	ld	(hl), b
	ld	b, a		; old handler address in BC
	dec	hl
	dec	hl
	push	hl		; effect on stack
	push	bc		; old handler address on stack
	ld	hl, (ERR_SP)
	push	hl		; old ERR_SP on stack
	ld	(ERR_SP), sp
	pop	hl		; adjust SP
	jp	(ix)
