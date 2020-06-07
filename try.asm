; Set new effect handler address
; followed by effect to handle and the new handler's unsigned offset - 1
; places three words on the stack: effect address, old handler address, old ERR_SP
try:	push	hl		; save HL
	ex	de, hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)		; DE = effect to handle
	inc	hl
	ld	a, (hl)
	inc	hl
	add	a, l
	ld	c, a
	ld	b, h
	ex	de, hl		; HL = effect to handle
	inc	hl
	jr	nc, try_nc
	inc	b
	jr	try_c

; Set new failure handler address
; followed by the new handler's signed offset
; places three words on the stack: effect address, old handler address, old ERR_SP
if:	push	hl
	ld	a, (de)
	ld	l, a
	add	a, a
	sbc	a, a
	ld	h, a
	add	hl, de
	inc	de
	ld	c, l
	ld	b, h
	ld	hl, FAIL_EFFECT + 1
try_c:	and	a
try_nc:	ld	a, (hl)
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
