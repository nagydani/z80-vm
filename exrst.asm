; Restart for catching an exception
ex_rst:	exx
	pop	bc	; continue here
	exx
	jp	catch	; catch it
	defs	ex_rst + 8 - $
