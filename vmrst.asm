; Restart for starting the VM
vm_rst:	ex	(sp), hl
	ex	de, hl
	jp	(ix)
	defs	vm_rst + 8 - $
