vm_token:
	exx
	push	hl
	exx
	ret

vm_tick:ld	a, (hl)
	inc	hl
vm_tail:rlca
	exx
	jr	nc, effect_rst
	rrca
vm_rec:	ld	l, c
	ld	h, b
	add	a, (hl)
	jr	nc, vm_prev
	inc	hl
vm_more:cp	(hl)
	jr	nc, vm_next

vm_cont:ld	l, a
	ld	h, 0
	inc	hl
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

vm_next:sub	a, (hl)
	ex	af, af'
	ld	a, (hl)
	scf
	call	vm_cont
	ex	af, af'
	push	bc
	ld	c, l
	ld	b, h
	dec	bc
	call	vm_more
	pop	bc
	ret
