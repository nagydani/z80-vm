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

spell:	vm
	defw	litS8
	defb	  spell2e - spell2
spell2:		vm
		defw	dup
		defw	cfetch
		defw	litN8
		defb	  $80
		defw	band
		defw	iszero
		defw	drop
		defw	oneplus
		defw	litN16, spell2
spell2e:defw	pend
	defw	dup
	defw	cfetch
	defw	litN8
	defb	  $7F
	defw	tail, band

