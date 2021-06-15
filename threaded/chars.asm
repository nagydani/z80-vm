; ( c -( fail )- c )
whitespace:
	vm
	defw	litN8
	defb	  " "
	defw	tail, le

; ( c -( fail )- c )
printable:
	vm
	defw	litN8
	defb	  "!"
	defw	ge
	defw	litN8
	defb	  127
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
lower:	vm
	defw	litN8
	defb	  "a"
	defw	ge
	defw	litN8
	defb	  "z"
	defw	tail, le

; ( c -( fail )- c )
upper:	vm
	defw	litN8
	defb	  "A"
	defw	ge
	defw	litN8
	defb	  "Z"
	defw	tail, le

; ( c -( fail )- c )
alpha:	vm
	defw	litN16, lower
	defw	litN16, upper
	defw	tail, or

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

; ( a a -( fail )- a )
streq:	vm
	defw	over
	defw	litS8
	defb	  streq1e - streq1
streq1:		vm
		defw	over
		defw	cfetch
		defw	over
		defw	cfetch
		defw	litN16, eq
		defw	litS8
		defb	  streq2e - streq2
streq2:			vm
			defw	cut
			defw	fail
streq2e:	defw	or
		defw	nonzero
		defw	drop
		defw	oneplus
		defw	swap
		defw	oneplus
		defw	tailself
		defb	  streq1 - $
streq1e:defw	litN16, ok
	defw	or
	defw	drop, tail, drop

; ( a -- a )
skipstr:vm
	defw	litS8
	defb	  skipste - skipst
skipst:		vm
		defw	dup
		defw	cfetch
		defw	nonzero
		defw	drop
		defw	oneplus
		defw	tailself
		defb	  skipst - $
skipste:defw	litN16, oneplus
	defw	tail, or

; ( a -- n )
strlen:	vm
	defw	dup
	defw	skipstr
	defw	oneminus
	defw	swap
	defw	tail, minus
