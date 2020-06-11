; Advance an address by the size of an address
; A
; CAN fail
; RETURNS A
AadvA:	equ	$

; Advance an address by the size of an integer
; A
; CAN fail
; RETURNS A
AadvN:	ld	bc, 2
	add	hl, bc
	jp	(ix)

; Advance an address by one byte
; A
; CAN fail
; RETURNS A
Aadv:	equ	$

; Increment an integer
; N
; CAN fail
; RETURNS N
incr:	ld	bc, 1
	add	hl, bc
	jp	(ix)

; Decrement an integer
; N
; CAN fail
; RETURNS N
decr:	dec	hl
	ld	a, h
	and	l
	add	a, 1
	jp	(ix)

; Advance an address by an integer number of bytes
; A N
; CAN fail
; RETURNS A
ANadv:	equ	$

; Addition of two integers
; N N
; CAN fail
; RETURNS N
add:	pop	bc
	add	hl, bc
	jp	(ix)

; First integer less or equal than second, return second
; N N
; CAN fail
; RETURNS N
le:	pop	bc
	sbc	hl, bc
	add	hl, bc
	jp	(ix)

; The two integers on the stack are equal, return second
; N N
; CAN fail
; RETURNS N
eq:	pop	bc
	sbc	hl, bc
	add	hl, bc
	jr	z, eq_r
	scf
eq_r:	jp	(ix)

