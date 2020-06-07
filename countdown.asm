countdown:
	pop	de
	pop	hl

; Countdown generator
; N:counter
N_countdown:
;	vm
;	defw	N_A_swap
;	defw	N_decr
;	defw	A_N_swap
;; this is shorter and faster
	dec	hl
	ld	a, h
	and	l
	add	a, 1
	vm
;;
	defw	if
	defb	  countdown - $
	defw	argN
	defb	  8	; counter
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
