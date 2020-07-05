do_repl:rst	vm_rst

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
