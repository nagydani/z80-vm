; ( n -( fail pend )- n )
countdown:
	vm
	defw	oneminus
	defw	carry
	defw	litN16, countdown
	defw	pend
	defw	tail, dup

; ( a -( fail pend )- c )
scanstr:vm
	defw	dup
	defw	cfetch
	defw	nonzero
	defw	drop
	defw	litS8
	defb	  scstr1e - scstr1
scstr1:		vm
		defw	oneplus
		defw	tail, scanstr
scstr1e:defw	pend
	defw	dup
	defw	tail, cfetch

; ( a -( fail pend )- a )
traverse:
	vm
	defw	fetch
	defw	nonzero
	defw	litN16, traverse
	defw	dup
	defw	tail, cellplus

