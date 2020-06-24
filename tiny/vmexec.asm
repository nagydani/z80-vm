;vm_fail:and	a
;vm_result:
;	pop	hl
;do_ok:	ret	c
;	ld	bc, do_ok
;	push	bc
;	call	vm_tick
;	push	hl
;	exx
;	ret

vm_tick:ld	a, (hl)
	inc	hl
vm_tail:add	a, a
	exx
	jr	c, vm_effect
	rrca
	cp	(ix + 0)
	jr	nc, vm_next
vm_cont:ld	l, a
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

vm_next:ld	l, (ix + 1)
	ld	h, (ix + 2)
vm_next1:
	cp	(hl)
	jr	nc, vm_next2
	push	bc
	dec	hl
	ld	b, (hl)
	dec	hl
	ld	c, (hl)
	call	vm_cont
	pop	bc
	ret

vm_next2:
	inc	hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ex	de, hl
	jr	vm_next1
