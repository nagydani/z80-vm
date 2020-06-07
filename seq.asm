seq:
	pop	de
	pop	hl
	vm
	defw	argN
	defb	  6	; from
	defw	argN
	defb	  4	; step
	defw	N_N_add
	defw	N_chg
	defb	  8
	defw	cpu
; Sequence generator
; N:from N:to N:step
N_N_N_seq:
	vm
	defw	argN
	defb	  6	; from
	defw	argN
	defb	  6	; to
	defw	N_N_le
	defw	N_drop
	defw	if
	defb	  seq - $
	defw	argN
	defb	  0xC	; from
	defw	cpu
	push	hl
	ld	hl, 6
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ex	de, hl
	jp	(ix)
