vm_rst:	ex	(sp), hl
do_vm:	rst	vm_exec
do_ok:	jp	nc, do_vm	; faster than jr
	pop	hl
	ret

	defs	vm_rst + 8 - $, 0xFF

vm_exec:call	vm_tick
	push	hl
	exx
	ret

	defs	vm_exec + 8 - $, 0xFF

pop_rst:ex	de, hl
	dec	hl
	ld	b, (hl)
	dec	hl
	ld	c, (hl)
	ex	de, hl
	ret

	defs	pop_rst + 8 - $, 0xFF

cmp_rst:rst	pop_rst
	ld	a, b
	ld	(de), a
	inc	de
	cp	c
	ret

	defs	cmp_rst + 8 - $, 0xFF
