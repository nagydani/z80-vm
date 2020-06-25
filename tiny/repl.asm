	rst	vm_rst

	defb	litE
	defb	repl_local_end - repl_local
repl_local:	rst	vm_rst
		defb	litS8
		defb	  end_repl_dict - repl_dict
repl_dict:	equ	$

; ( -( key )- S8 )
readln:			equ	$ - repl_dict + seed_last
			defb	do_readln

end_repl_dict:	equ	$
		defb	tail
		defb	  dict


; ( -( key )- S8 )
do_readln:	rst	vm_rst
		defb	zero
		defb	litE
		defb	  readln_end - readln_start
readln_start:		defb	litN8
			defb	  0x10
			defb	key
			defb	neq
			defb	append
			defb	tailself
			defb	  readln_start - $
readln_end:	defb	tick
		defb	  string
		defb	tail
		defb	  or


repl_local_end:	equ	$
	defb	call

	defb	litE
	defb	  end_repl - repl
repl:		rst	vm_rst
		defb	litS8
		defb	  end_hello - hello
hello:		defb	  "Hello", 0x0A
end_hello:
		defb	write

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
