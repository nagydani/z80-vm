do_repl:rst	vm_rst

	defb	litE
	defb	  end_repl - repl
	NOP
	; ( ??? -( ??? )- ??? )
repl:		rst	vm_rst
		defb	litS8
		defb	  end_hello - hello
hello:		defm	  "Ok"
end_hello:	defb	writeln

; Test words generator
;		defb	litE
;		defb	  end_wordList - do_wordList
;		NOP
;		; ( ??? -( ??? )- ??? )
;do_wordList:		rst	vm_rst
;			defb	effWords
;			defb	drop		; word class
;			defb	writeln
;			defb	fail
;			defb	  0
;end_wordList:	defb	emptyE
;		defb	or

; Test name
;		defb	litN8
;		defb	  index
;		defb	tick
;		defb	  effWords
;		defb	name
;		defb	drop			; word class
;		defb	writeln

; Test index
;		defb	litS8
;		defb	  end_testwrd - testwrd
;testwrd:	defm	  "index"
;end_testwrd:	defb	tick
;		defb	  effWords
;		defb	index
;		defb	drop			; word class
;		defb	tick
;		defb	  effWords
;		defb	name
;		defb	drop			; word class
;		defb	writeln

; Test decompiler
		defb	tick
		defb	  effWords
		defb	tick
		defb	  verbatim
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
	NOP
	; ( ??? -( ??? )- ??? )
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
