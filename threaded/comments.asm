backslash_link:
	defw	link_final_io
	defb	"\\", 0
	defw	exec

backslash:
	vm
	defw	tail, input

link_final_comments:
paren_link:
	defw	backslash_link
	defb	"(", 0
	defw	exec

paren:	vm			; TODO recursive
	defw	litS8
	defb	  parenle - parenl
parenl:		vm
		defw	word
		defw	pad
		defw	litS8
		defb	  2
		defb	  ")", 0
		defw	strneq
		defw	drop
		defw	tailself
		defb	  parenl - $
parenle:defw	tickidtailor
