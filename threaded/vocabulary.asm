; ( -- a )
context:vm
	defw	litN16, CONTEXT
	defw	tail2

; ( a -( pad fail )- a )
find:	vm
	defw	word
	defw	context
	defw	traverse
	defw	pad
	defw	streq
	defw	cut
	defw	tail, skipstr
