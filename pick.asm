; Pick an address argument in the stack
; RETURNS A
argA:	equ	$

; Pick an integer argument in the stack
; RETURNS N
argN:	push	hl
	ld	a, (de)
	inc	de
	ld	l, a
	ld	h, 0

; Pick the referenced integer argument in the stack
; RETURNS N
N_pickN:add	hl, sp
	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	jp	(ix)

