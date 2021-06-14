; ( c -( fail )- c )
printable:
	vm
	defw	litN8
	defb	  "!"
	defw	ge
	defw	dup
	defw	litN16, 0xFF80
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
	defb	  0x20
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

; ( -- a )
base:	vm
	defw	litN16, BASE
	defw	tail2

; ( c -( fail )- n )
digitToInt:
	vm
	defw	alphanum
	defw	litN8
	defb	  "0"
	defw	minus
	defw	carry
	defw	litN8
	defb	  9
	defw	litN16, le
	defw	litS8
	defb	  ad2i_e - ad2i
ad2i:		vm
		defw	litN8
		defb	  0x20
		defw	bor
		defw	litN8
		defb	  39
		defw	tail, minus
ad2i_e:	defw	or
	defw	base
	defw	cfetch
	defw	tail, lt

; ( a n -( fail )- n )
tonumber:
	vm
	defw	base		; a n base
	defw	cfetch		; a n @base
	defw	star		; a n
	defw	over		; a n a
	defw	cfetch		; a n c
	defw	digitToInt	; a n n
	defw	plus		; a n
	defw	carry		; a n
	defw	swap		; n a
	defw	oneplus		; n a
	defw	dup		; n a a
	defw	cfetch		; n a c
	defw	litS8
	defb	  numws_e - numws
numws:		vm
		defw	whitespace
		defw	drop
		defw	tail, drop
numws_e:defw	litS8
	defb	  numdg_e - numdg
numdg:		vm
		defw	drop
		defw	swap
		defw	tail, tonumber
numdg_e:defw	tail, or

; ( a -( fail )- n )
sToNumber:
	vm
	defw	litN8
	defb	  0
	defw	tail, tonumber

