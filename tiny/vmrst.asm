vm_rst:	ex	(sp), hl
	ld	bc, vm_result
	push	bc
	jp	vm_exec
	defs	vm_rst + 8 - $, 0xFF
