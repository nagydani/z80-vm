interpret_link:
	defw	link_final_output
	defb	"interpret", 0
	defw	comma

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
			defw	pad
			defw	type
			defw	litS8
			defb	  iundte - iundt
iundt:				defb	" undefined", 10, 0
iundte:			defw tail, type
iunde:		defw	tailor
inumue:	defw	or
	defw	tailself
	defb	  interpret - $

meta_link:
	defw	interpret_link
	defb	"[", 0
	defw	exec

meta:	vm
	defw	litN16, interpret
	defw	tickidtailor

link_final_interpreter:
endmeta_link:
	defw	meta_link
	defb	"]", 0
	defw	fail		; TODO not allowed in compile mode

endmeta:vm
	defw	fail
