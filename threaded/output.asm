bl_link:
	defw	0
	defb	"bl", 0
	defw	comma

; ( -- c )
bl:	vm
	defw	litN8
	defb	  " "
	defw	tail2

space_link:
	defw	bl_link
	defb	"space", 0
	defw	comma

; ( -( emit )- )
space:	vm
	defw	bl
	defw	tail, emit

intToDigit_link:
	defw	space_link
	defb	">digit", 0
	defw	comma

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


dot_link:
	defw	intToDigit_link
	defb	".", 0
	defw	comma

; ( n -( emit )- )
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
dotnze:	defw	or
	defw	tail, space

type_link:
	defw	dot_link
	defb	"type", 0
	defw	comma

; ( a -( emit )- )
type:	vm
	defw	litS8
	defb	  typele - typel
typel:		vm
		defw	dup
		defw	cfetch
		defw	nonzero
		defw	emit
		defw	oneplus
		defw	tailself
		defb	  typel - $
typele:	defw	litN16, ok
	defw	tail, or

link_final:
words_link:
	defw	type_link
	defb	"words", 0
	defw	comma

; ( -( emit )- )
words:	vm
	defw	litS8
	defb	  vliste - vlist
vlist:		vm
		defw	context
		defw	traverse
		defw	type
		defw	space
		defw	fail
vliste:	defw	litN16, ok
	defw	tail, or
