do_repl:rst	vm_rst

	defb	use
		defw	core_tab
repl_voc:	defb	0x100 - core_last
		defb	repl_last - core_last

; ( S8 -( emit )- )
writeln:	equ	$ - repl_voc + core_last - 2
		defb	do_writeln - $
; ( -( key )- S8 )
readln:		equ	$ - repl_voc + core_last - 2
		defb	do_readln - $

repl_last:	equ	$ - repl_voc + core_last - 2
		defb	end_repl_voc - $

; ---

; ( S8 -( emit )- )
do_writeln:	rst	vm_rst
		defb	write
		defb	litN8
		defb	  0x0A
		defb	tail
		defb	  emit

; ( -( key )- S8 )
do_readln:	rst	vm_rst
		defb	zero
		defb	litE
		defb	  end_readln - start_readln
start_readln:		rst	vm_rst
			defb	litN8
			defb	  0x0A
			defb	key
			defb	neq
			defb	append
			defb	tailself
			defb	  start_readln - $
end_readln:	defb	tick
		defb	  string
		defb	tail
		defb	  or

end_repl_voc:	equ	$

	defb	litE
	defb	  end_repl - repl
repl:		rst	vm_rst
		defb	litS8
		defb	  end_hello - hello
hello:		defm	  "Ok"
end_hello:	defb	writeln

		defb	readln
		defb	litS8
		defb	  end_core_words - core_words
			include	"words.asm"
end_core_words:	defb	drop
		defb	drop
		defb	drop
		defb	writeln
		defb	rain

		defb	tailself
		defb	  0x100 + repl - $

end_repl:
	defb	litE
	defb	  end_failure - failure
failure:	rst	vm_rst
		defb	litS8
		defb	  end_fmsg - fmsg
fmsg:		defm	  "Fail"
end_fmsg:
		defb	tail
		defb	  writeln
end_failure:	equ 	$
	defb	or
	defb	cpu
	halt
