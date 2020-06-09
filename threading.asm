; Return an integer to the calling thread
; CAN end
; A:caller N:returnValue
Nend:	ex	(sp), hl

; Return to calling thread
; A:returnAddress
end:	ex	de, hl
	pop	hl

; The threading loop
vm_l:	ex	de, hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	hl
	ex	de, hl
	push	bc
	ret	nc		; no fail

; Failure branch
	pop	bc		; discard next token
	dec	de
	dec	de		; move back
	ld	bc, FAIL_EFFECT
	ex	de, hl
	ex	(sp), hl
	push	bc
	ret

; Hand back control to CPU
; A:returnAddress
cpu:	ex	de, hl
	ex	(sp), hl
	ret

; Catch exception
catch:	ld	sp, (ERR_SP)	; restore stack pointer
	pop	hl		; old ERR_SP
	ld	(ERR_SP), hl	; restore ERR_SP
	pop	de		; previous handler address
	pop	hl		; effect address
	sbc	hl, bc		; set ZF, if it's me
	add	hl,bc		; effect address, ZF intact
	inc	hl
	ld	(hl), e		; restore handler address
	inc	hl
	ld	(hl), d
	jr	nz, catch	; continue searching, if not me
	exx
	pop	de		; return address
	pop	hl		; old HL
	push	bc
	ret

; Skip a code section
; followed by length
skip:	ld	a, (de)
	add	a, e
	jr	nc, skip_nc
	inc	d
	and	a
skip_nc:ld	e, a
	jp	(ix)
