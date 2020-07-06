do_repl:rst	vm_rst

	defb	litE
	defb	  end_repl - repl
repl:		rst	vm_rst
		defb	litS8
		defb	  end_hello - hello
hello:		defm	  "Ok"
end_hello:

; Test words generator
		defb	coreWords
		defb	litE
		defb	  end_wordList - do_wordList
do_wordList:		rst	vm_rst
			defb	words
			defb	drop		; word class
			defb	writeln
			defb	fail
end_wordList:	defb	emptyE
		defb	or

; Test decompiler
		defb	tick
		defb	  writeln
		defb	see

; Test readln and writeln
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
