interpret:
	vm
	defw	word
	defw	litS8
	defb	  iworde - iword
iword:		vm
		defw	find
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
