; Decrement
; CAN fail
N_decr:	dec	hl
	ld	a, h
	and	l
	add	a, 1
	jp	(ix)

