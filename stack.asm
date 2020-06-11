; Duplicate the address on the top of the stack
; A
; RETURNS A A
Adup:	equ	$

; Duplicate the integer on the top of the stack
; N
; RETURNS N N
Ndup:	push	hl
	jp	(ix)


; Swap the top two addresses on the stack
; A A
; RETURNS A A
AAswap:

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


; Return to the calling thread with an integer, removing an integer argument
; N R N
; RETURNS N
; CAN end
Ntail:	pop	de

; Nip an address from the stack
; A N
; RETURNS N
Anip:	equ	$

; Nip an integer from the stack
; N N
; RETURNS N
Nnip:	pop	bc
	jp	(ix)


; Nip a fixed-size chunk from the stack
; ... N
; RETURNS N
nip:	ld	a, (de)
	inc	de
	defb	1		; LD BC, skip 2 bytes
;	jr	nip_c

; Return to the calling thread with an integer, removing arguments
; ... R N
; RETURNS N
; CAN end
tail:	ld	a, (de)
	pop	de
nip_c:	ld	c, l
	ld	b, h
	ld	l, a
	ld	h, 0
	add	hl, sp
	ld	sp, hl
	ld	l, c
	ld	h, b
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
