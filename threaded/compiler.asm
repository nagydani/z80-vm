compile:
	vm
	defw	word
	defw	litS8
	defb	  cworde - cword
cword:		vm
		defw	find
		defw	dup
		defw	cellplus
		defw	swap
		defw	fetch
		defw	tail, exec
cworde:	defw	litS8
	defb	  cnume - cnum
cnum:		vm
		defw	pad
		defw	sToNumber
		defw	tail, literal
cnume:	defw	or
	defw	tailself
	defb	  compile - $
