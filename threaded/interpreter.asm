interpret:
	vm
	defw	word
	defw	litS8
	defb	  iworde - iword
iword:		vm
		defw	find
		defw	cellplus
		defw	litN16, exec
		defw	litS8
		defb	  ifaile - ifail
ifail:			vm
			defw	litS8
			defb	  ifailte - ifailt
ifailt:				defb	" fail", 13, 0
ifailte:		defw	type
			defw	fail
ifaile:		defw	tailor
iworde:	defw	litS8
	defb	  inume - inum
inum:		vm
		defw	pad
		defw	tail, sToNumber
inume:	defw	or
	defw	tailself
	defb	  interpret - $
