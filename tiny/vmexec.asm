vm_fail:and	a
vm_result:
	pop	hl
do_ok:	ret	c
	ld	bc, do_ok
	push	bc
	call	vm_tick
	push	hl
	exx
	ret

vm_tick:ld	a, (hl)
	inc	hl
vm_tail:add	a, a
	exx
	jr	c, vm_effect
	rrca
	ld	l, a
	ld	h, 0
	add	hl, bc
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
	and	a
	ex	de, hl
	ret
