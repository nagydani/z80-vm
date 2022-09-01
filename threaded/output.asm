bl_link:
	defw	link_final_input
	defb	"bl", 0
	defw	comma

; ( -- c )
bl:	ld	bc, " "
	fromBC
	jp	(ix)

space_link:
	defw	bl_link
	defb	"space", 0
	defw	comma

; ( -( emit )- )
space:	vm
	defw	bl
	defw	tail, emit

cr_link:
	defw	space_link
	defb	"cr", 0
	defw	comma

; ( -( emit)- )
cr:	vm
	defw	litN8
	defb	  0x0A
	defw	tail, emit

intToDigit_link:
	defw	cr_link
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
		defw	emit
		defw	tail, drop
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
			defw	dotnz
			defw	intToDigit
			defw	tail, emit
dotnzie:	defw	litN16, drop
		defw	tailor
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
typele:	defw	tickidor
	defw	tail, drop

write_link:
	defw	type_link
	defb	"write", 0
	defw	comma

write:	toBC
	push	bc
	toBC
	push	bc
	exx
	pop	hl
	pop	bc
	push	bc
writel:	ld	a, (hl)
	inc	hl
	out	(0), a
	dec	bc
	ld	a, b
	or	c
	jr	nz, writel
	exx
	pop	bc
	fromBC
	jp	(ix)

link_final_output:
words_link:
	defw	write_link
	defb	"words", 0
	defw	comma

; ( -( emit )- )
words:	vm
	defw	litS8
	defb	  vliste - vlist
vlist:		vm
		defw	context
		defw	fetch
		defw	traverse
		defw	type
		defw	space
		defw	fail
vliste:	defw	litN16, cr
	defw	tailor
