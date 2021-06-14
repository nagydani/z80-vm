countdown:
	vm
	defw	oneminus
	defw	carry
	defw	litN16, countdown
	defw	pend
	defw	tail, dup

traverse:
	vm
	defw	fetch
	defw	nonzero
	defw	litN16, traverse
	defw	dup
	defw	tail, cellplus

