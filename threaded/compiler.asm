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
		defw	tail, fetch
cworde:	defw	litS8
	defb	  cnume - cnum
cnum:		vm
		defw	pad
		defw	sToNumber
		defw	litN16, literal
		defw	tail2
cnume:	defw	or
	defw	exec
	defw	tailself
	defb	  compile - $

endcomp:vm
	defw	comma
	defw	fail

endtail:vm
	defw	comma
	defw	word
	defw	find
	defw	cellplus
	defw	comma
	defw	fail

link_final:
link_final_compiler:
quotation_link:
	defw	link_final_vocabulary
	defb	"{", 0
	defw	quotate

quotation:
	vm
	defw	here
	defw	vmcomma
	defw	litN16, compile
	defw	tickidtailor

quotate:vm
	defw	sopen
	defw	exec
	defw	tail, sclose

