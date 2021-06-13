; ( c -( fail )- c )
printable:
	vm
	defw	litN8
	defb	  "!"
	defw	ge
	defw	dup
	defw	litN16, $FF80
	defw	band
	defw	iszero
	defw	tail, drop

; ( c -( fail )- c )
whitespace:
	vm
	defw	litN8
	defb	  " "
	defw	tail, le

; ( c -( fail )- c )
ddigit:	vm
	defw	litN8
	defb	  "0"
	defw	ge
	defw	litN8
	defb	  "9"
	defw	tail, le

; ( c -( fail )- c )
alpha:	vm
	defw	dup
	defw	litN8
	defb	  $20
	defw	bor
	defw	litN8
	defb	  "a"
	defw	ge
	defw	litN8
	defb	  "z"
	defw	le
	defw	tail, drop

; ( c -( fail )- c )
alphanum:
	vm
	defw	litN16, ddigit
	defw	litN16, alpha
	defw	tail, or
