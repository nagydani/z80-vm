interpret:
	vm
	defw	tib
	defw	fetch
	defw	word
	defw	tib
	defw	store
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
