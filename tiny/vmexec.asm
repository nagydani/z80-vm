vm_fail:and	a
vm_result:
	pop	hl
vm_exec:ret	c
	ld	a, (hl)
	inc	hl
vm_tail:add	a, a
	ld	bc, vm_exec
	push	bc
	ret	z
	exx
	jr	c, vm_user
	rrca
	ld	l, a
	ld	h, 0
	add	hl, de
	ld	c, (hl)
	ld	b, 0
	add	hl, bc
	push	hl
	exx
	ret

vm_user:ld	l, a
	ld	h, FAIL / 0x100
	ld	c, (hl)
	inc	l
	ld	b, (hl)
	push	bc
	exx
	and	a
	ret

