interpret:
	vm
	defw	word
	defw	litS8
	defb	  iworde - iword
iword:		vm
		defw	context
		defw	fetch
		defw	find
		defw	skipstr
		defw	cellplus
		defw	tail, exec
iworde:	defw	litS8
	defb	  inume - inum
inum:		vm
		defw	pad
		defw	tail, sToNumber
inume:	defw	or
	defw	tailself
	defb	  interpret - $
