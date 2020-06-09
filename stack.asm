; Swap an address with an integer on the stack
; N A
; RETURNS A N
NAswap:

; Swap an integer with an address on the stack
; A N
; RETURNS N A
ANswap:

; Swap the top two integers on the stack
; N N
; RETURNS N N
NNswap:
	ex	(sp), hl
	jp	(ix)

; Drop an integer from the stack
; N
Ndrop:	pop	hl
	jp	(ix)

; Convert a Sequence to a Vector (i.e. put stuff on the stack)
; S
; RETURNS V
StoV:	push	hl
	exx
	pop	bc		; lenght
	pop	hl		; start address
	add	hl, bc		; end + 1
StoV_l:	ld	a, b
	or	c
	jr	z, emptyStoV
	dec	hl
	ld	a, (hl)
	dec	bc
	push	af
	inc	sp
	jr	StoV_l
emptyStoV:
	exx
	jp	(ix)
