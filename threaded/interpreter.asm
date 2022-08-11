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
			defw	cut
			defw	fail
ifaile:		defw	tailor
iworde:	defw	litS8
	defb	  inumue - inumu
inumu:		vm
		defw	litS8
		defb	  inume - inum
inum:			vm
			defw	pad
			defw	tail, sToNumber
inume:		defw	litS8
		defb	  iunde - iund
iund:			vm
			defw	litS8
			defb	  iundte - iundt
iundt:				defb	"undefined", 13, 0
iundte:			defw tail, type
iunde:		defw	tailor
inumue:	defw	or
	defw	tailself
	defb	  interpret - $
