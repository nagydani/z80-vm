; ( -- a )
pad:	vm
	defw	litN16, PAD
	defw	tail2

; ( a -- a )
skipws:	vm
	defw	litS8
	defb	  skws1e - skws1
skws1:		vm
		defw	dup
		defw	cfetch
		defw	nonzero
		defw	whitespace
		defw	drop
		defw	oneplus
		defw	tail, skws1
skws1e:	defw	litN16, ok
	defw	tail, or

; ( a -( fail )- )
word:	vm
	defw	skipws
	defw	pad
	defw	litS8
	defb	  word1e - word1
word1:		vm
		defw	over		; a pad a
		defw	cfetch		; a pad c
		defw	printable
		defw	over		; a pad c pad
		defw	cstore		; a pad
		defw	pad
		defw	litN8
		defb	  PAD_LEN
		defw	plus
		defw	lt
		defw	oneplus
		defw	swap
		defw	oneplus
		defw	swap
		defw	tail, word1
word1e:	defw	litS8
	defb	  word2e - word2
word2:		vm
		defw	litN8
		defb	  0
		defw	cstore
		defw	cfetch
		defw	tail, whitespace
word2e:	defw	tail, or
