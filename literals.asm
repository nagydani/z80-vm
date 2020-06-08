; Byte literal
; RETURNS N
lit8:	push	hl
	ld	a, (de)
	inc	de
	ld	l, a
	ld	h, 0
	jp	(ix)

; Word literal
; RETURNS N
lit16:	push	hl
	ex	de, hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	inc	hl
	ex	de, hl
	jp	(ix)
