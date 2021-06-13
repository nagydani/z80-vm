countdown:
	vm
	defw	oneminus
	defw	carry
	defw	litN16, countdown
	defw	pend
	defw	tail, dup
