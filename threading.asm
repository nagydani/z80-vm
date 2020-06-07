; Return to calling thread
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
	ld	bc, (FAIL_EFFECT + 1)
	exx			; continue with the effect
	ld	bc, FAIL_EFFECT	; failure cannot be handled, just caught
	and	a		; clear CF (failed state)

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
	push	bc
	ret

; Hand back control to CPU
cpu:	ex	de, hl
	ex	(sp), hl
	ret

