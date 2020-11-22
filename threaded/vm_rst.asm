; Begin threading
vm_rst:	ex	(sp), hl
vm_l:	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	hl
	push	bc
	ret

	defs	vm_rst + 8 - $, 0xFF

; Catch exception
ex_rst:	pop	bc	; handler address pointer
	jp	catch

	defs	ex_rst + 8 - $, 0xFF

; pop BC from data stack
pop_rst:ex	de, hl
	dec	hl
	ld	b, (hl)
	dec	hl
	ld	c, (hl)
	ex	de, hl
	ret

	defs	pop_rst + 8 - $, 0xFF

; push BC to data stack
push_rst:
	ex	de, hl
	ld	(hl), c
	inc	hl
	ld	(hl), b
	inc	hl
	ex	de, hl
	ret

	defs	push_rst + 8 - $, 0xFF
