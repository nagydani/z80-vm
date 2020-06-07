; Decrement
; CAN fail
N_decr:	dec	hl
	ld	a, h
	and	l
	add	a, 1
	jp	(ix)

; Addition
; CAN fail
N_N_add:pop	bc
	add	hl, bc
	jp	(ix)

; Less or equal
; CAN fail
N_N_le:	pop	bc
	sbc	hl, bc
	add	hl, bc
	jp	(ix)

; Drop
N_drop:	pop	hl
	jp	(ix)

