vm_token:
	exx
	push	de
	exx
	ret

vm_tick:ld	a, (hl)
	inc	hl
vm_tail:exx
	ld	l, c
	ld	h, b
vm_more:sub	(hl)
	jr	c, vm_prev
	ex	de, hl
	add	a, a
	inc	a
	ld	l, a
	ld	h, 0
	add	hl, de
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ret

vm_prev:add	a, (hl)
	dec	hl
	ld	d, (hl)
	dec	hl
	ld	e, (hl)
	ex	de, hl
	jr	vm_more
