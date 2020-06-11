; Return an integer to the calling thread
; R N
; CAN end
; RETURNS N
Nend:	ex	(sp), hl
; This would be faster, but longer:
;	pop	de
;	jp	(ix)

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
	ld	bc, (FAIL_EFFECT + 1)
	exx
	ld	bc, FAIL_EFFECT	; failures can only be caught
	and	a		; clear failed state (CF)


; Catch exception
catch:	inc	bc
catch1:	ld	sp, (ERR_SP)	; restore stack pointer
	pop	hl		; old ERR_SP
	ld	(ERR_SP), hl	; restore ERR_SP
	pop	de		; previous handler address
	pop	hl		; effect address
	sbc	hl, bc		; set ZF, if it's me
	add	hl,bc		; effect address, ZF intact
	ld	(hl), e		; restore handler address
	inc	hl
	ld	(hl), d
	jr	nz, catch1	; continue searching, if not me
	exx
	pop	de		; return address
	pop	hl		; old HL
	push	bc
	ret

; Hand back control to CPU
; A:returnAddress
cpu:	ex	de, hl

; Call function
; a E(a->b)
; RETURNS b
call:	ex	(sp), hl
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
