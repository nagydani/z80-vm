countdown_l:
	pop	de
	pop	hl

; Countdown generator
; N:counter
countdown:
;	vm
;	defw	NAswap
;	defw	decr
;	defw	ANswap
;; this is shorter and faster
	dec	hl
	ld	a, h
	and	l
	add	a, 1
	vm
;;
	defw	if
	defb	  countdown_l - $
	defw	argN
	defb	  8	; counter
	defw	Ngenerate

seq_l:	pop	de
	pop	hl
	vm
	defw	argN
	defb	  6	; from
	defw	argN
	defb	  4	; step
	defw	add
	defw	Nchg
	defb	  8
	defw	cpu

; Sequence generator
; N:from N:to N:step
seq:	vm
	defw	argN
	defb	  6	; from
	defw	argN
	defb	  6	; to
	defw	le
	defw	Ndrop
	defw	if
	defb	  seq_l - $
	defw	argN
	defb	  0xC	; from
	defw	Ngenerate

; Generate an integer
; A:returnAddress Handling N
; CAN end
; RETURNS A Handling N A N
Ngenerate:
	ex	de, hl
	push	hl
	ld	hl, 8
	add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ex	de, hl
	jp	(ix)
