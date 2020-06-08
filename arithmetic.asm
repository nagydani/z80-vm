; Decrement an integer
; N
; CAN fail
; RETURNS N
decr:	dec	hl
	ld	a, h
	and	l
	add	a, 1
	jp	(ix)

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

