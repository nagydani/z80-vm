context_link:
	defw	link_final_output
	defb	"context", 0
	defw	comma

; ( -- a )
context:vm
	defw	litN16, CONTEXT
	defw	tail2

link_final:
link_final_vocabulary:
find_link:
	defw	context_link
	defb	"find", 0
	defw	comma

; ( -( pad fail )- a )
find:	vm
	defw	context
	defw	traverse
	defw	pad
	defw	streq
	defw	cut
	defw	nip
	defw	tail, skipstr
