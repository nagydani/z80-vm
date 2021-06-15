; ( n -- c )
intToDigit:
	vm
	defw	litS8
	defb	  i2dde - i2dd
i2dd:		vm
		defw	litN8
		defb	  9
		defw	le
		defw	litN8
		defb	  "0"
		defw	tail2
i2dde:	defw	litS8
	defb	  i2dhe - i2dh
i2dh:		vm
		defw	litN8
		defb	  -10 + "A"
		defw	tail2
i2dhe:	defw	or
	defw	tail, plus

; ( n -- )
dot:	vm
	defw	litS8
	defb	  dot0e - dot0
dot0:		vm
		defw	iszero
		defw	litN8
		defb	  "0"
		defw	tail, emit
dot0e:	defw	litS8
	defb	  dotnze - dotnz
dotnz:		vm
		defw	litS8
		defb	  dotnzie - dotnzi
dotnzi:			vm
			defw	nonzero
			defw	base
			defw	cfetch
			defw	slashmod
			defw	swap
			defw	dotnz
			defw	intToDigit
			defw	tail, emit
dotnzie:	defw	litN16, drop
		defw	tail, or
dotnze:	defw	tail, or

