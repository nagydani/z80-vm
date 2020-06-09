; Restart for catching an exception
ex_rst:	exx
	pop	bc		; continue here
	exx
	push	 hl		; put HL back
	and	a		; clear failed state (CF)
	jp	catch	; catch it
	defs	ex_rst + 8 - $
