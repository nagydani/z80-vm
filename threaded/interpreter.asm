interpret:
	vm
	defw	word
	defw	pad
	defw	cfetch
	defw	litN16, nonzero
	defw	litS8
	defb	  ioke - iok
iok:		vm
		defw	litS8
		defb	  iokte - iokt
iokt:			defb	" ok", 0x0D, 0
iokte:		defw	type
		defw	fail
ioke:	defw	or
	defw	drop
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
