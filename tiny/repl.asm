do_repl:rst	vm_rst

	defb	use
		defb	end_repl_voc - repl_voc
		defw	io_tab
repl_voc:	defb	io_last

; ( S8 -( emit )- )
writeln:	equ	io_last
		defw	do_writeln
; ( -( key )- S8 )
readln:		equ	writeln + 1
		defw	do_readln

repl_last:	equ	readln + 1

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
			defb	key
			defb	litN8
			defb	  0x0A
			defb	neq
			defb	append
			defb	  0
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

		defb	litS8
		defb	  end_core_words - core_words
			include	"words.asm"
end_core_words:	defb	litE
		defb	  end_wordlist - wordlist
wordlist:		rst	vm_rst
			defb	words
			defb	drop
			defb	writeln
			defb	fail
end_wordlist:	defb	emptyE
		defb	or
		defb	readln
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
