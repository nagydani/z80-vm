	rst	vm_rst
	defb	litE
	defb	  end_repl - repl
repl:		rst	vm_rst
		defb	litS8
		defb	  end_hello - hello
hello:		defb	  "Hello", 0x0A
end_hello:
		defb	write

		defb	litS8
		defb	  end_repl_dict - repl_dict
repl_dict:	equ	$
; ( N8 -( fail )- N8 )

end_repl_dict:	equ	$

;		defb	tick
;		defb	  comp
;		defb	tick
;		defb	  extend
;		defb	tryto
;		defb	  emit

end_repl:
	defb	litE
	defb	  end_failure - failure
failure:	rst	vm_rst
		defb	litS8
		defb	  end_fmsg - fmsg
fmsg:		defb	  "Failure.", 0x0A
end_fmsg:
		defb	tail
		defb	  write
end_failure:
	defb	or
	defb	cpu
	halt
