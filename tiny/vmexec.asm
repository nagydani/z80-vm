vm_tick:ld	a, (hl)
	inc	hl
vm_tail:rlca
	exx
	jr	nc, vm_effect
	rrca
vm_rec:	ld	l, c
	ld	h, b
	add	a, (hl)
	jr	nc, vm_prev

vm_cont:ld	l, a
	ld	h, 0
	adc	hl, bc
	ld	e, (hl)
	ld	d, 0
	add	hl, de
	ret

vm_effect:
	ld	l, a
	ld	h, EFFECT / 0x100
	ld	e, (hl)
	inc	l
	ld	d, (hl)
	ex	de, hl
	ret

vm_prev:push	bc
	sub	a, (hl)
	dec	hl
	ld	b, (hl)
	dec	hl
	ld	c, (hl)
	call	vm_rec
	pop	bc
	ret
