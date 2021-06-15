; ( -- a )
context:vm
	defw	litN16, CONTEXT
	defw	tail2

; ( -( pad fail )- a )
find:	vm
	defw	context
	defw	traverse
	defw	pad
	defw	streq
	defw	cut
	defw	nip
	defw	tail, skipstr
