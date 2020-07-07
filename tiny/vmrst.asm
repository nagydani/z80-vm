token_rst:
	ex	(sp), hl
	call	vm_tick
	exx
	ex	(sp), hl
	jr	vm_token

	defs	token_rst + 8 - $, 0xFF

;emit_rst:
;	push	af
;	ld	(de), a
;	inc	de
;	rst	token_rst
;	defb	  emit
;	pop	af
;	ret
;
;	defs	emit_rst + 8 - $, 0xFF

vm_rst:	ex	(sp), hl
do_vm:	rst	vm_exec
do_ok:	jp	nc, do_vm	; faster than jr
	pop	hl
	ret

	defs	vm_rst + 8 - $, 0xFF

vm_exec:call	vm_tick
jpdep:	push	de
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

cmp_rst:ex	de, hl
	dec	hl
	ld	a, (hl)
	dec	hl
	cp	(hl)
	inc	hl
	ex	de, hl
	ret

	defs	cmp_rst + 8 - $, 0xFF

