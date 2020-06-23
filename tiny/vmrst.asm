vm_rst:	ex	(sp), hl
	ld	bc, vm_result
	push	bc
	jp	do_ok
	defs	vm_rst + 8 - $, 0xFF
