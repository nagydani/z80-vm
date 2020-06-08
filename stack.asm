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
