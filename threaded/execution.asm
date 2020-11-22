cpu:	ex	(sp), hl
	ret

tail:	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ex	(sp), hl
	ret

tail2:	pop	hl
	jp	(ix)

tailself:
	ld	c, (hl)
	ld	b, 0xFF
	add	hl, bc
	jp	(ix)


; ( -( fail )- )
fail:	ld	bc, FAIL

; BC = exception pointer
; Handler frame:
;	handler pointer, previous handler address, previous ERR_SP, previous data stack pointer
catch:	ld	sp, (ERR_SP)
	pop	hl		; handler pointer
	and	a
	sbc	hl, bc
	add	hl, bc		; ZF = 1, if found
	pop	de		; previous handler address
	ld	a, (hl)
	ld	(hl), e
	ld	e, a
	inc	hl
	ld	a, (hl)
	ld	(hl), d		; restore previous handler address
	ld	d, a		; DE = current handler address
	pop	hl		; previous ERR_SP
	ld	(ERR_SP), hl
	jr	nz, catch	; next handler, if not found
	ex	de, hl		; HL = current handler address
	pop	de		; restore data stack pointer
	ex	(sp), hl	; HL = continue here after handler
	ret			; continue with handler

; ( arg ( arg -( effect )- val ) 'handler 'effect -- val )
handle:	push	hl		; outer function on call stack
	toBC
	inc	bc		; BC = handler pointer
	push	bc
	toBC			; BC = new handler address
	push	bc
	exx
	pop	bc		; BC = new handler address
	pop	hl		; HL = handler pointer
	ld	a, (hl)
	ld	(hl), c
	ld	c, a
	inc	hl
	ld	a, (hl)
	ld	(hl), b
	ld	b, a		; BC = old handler address
	dec	hl
	exx
	push	de		; data stack pointer on call stack
	ld	bc, (ERR_SP)
	push	bc		; old ERR_SP on call stack
	exx
	push	bc		; old handler address on call stack
	push	hl		; handler pointer on call stack
	ld	(ERR_SP), sp	; ERR_SP updated
	exx
	ld	hl, tailcut

; ( a ( a -( e )- b ) -( e )-  b )
call:	toBC
	push	bc
	ret

tailcut:defw	cut
	defw	tail2

; ( -( \handle )- )
cut:	exx
	pop	hl		; handler pointer
	pop	de		; previous handler address
	ld	(hl), e
	inc	hl
	ld	(hl), d		; restore previous handler
	pop	hl		; previous ERR_SP
	ld	(ERR_SP), hl	; restore previous ERR_SP
	pop	de		; discard data stack pointer
	exx
	jp	(ix)

; ( ( -( e )- val ) ( -( f )- val ) -( e f )- val )
or:	vm
	defw	litN16, FAIL - 1
	defw	tail, handle
