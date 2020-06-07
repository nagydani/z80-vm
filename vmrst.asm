; Restart for starting the VM
vm_rst:	ex	(sp), hl
	ex	de, hl
thread:	ld	ix, (VM_PTR)
	jp	(ix)
	defs	vm_rst + 8 - $
