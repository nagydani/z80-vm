do_repl:rst	vm_rst

	defb	litE
	defb	  end_repl - repl
	; ( ??? -( ??? )- ??? )
repl:		rst	vm_rst
		defb	litS8
		defb	  end_hello - hello
hello:		defm	  "Ok"
end_hello:	defb	writeln

; Test generators
;		defb	litS8
;		defb	  e_teststr - teststr
;teststr:		defb	"ABCDEFG"
;e_teststr:	equ	$

; Safe string
;		defb	local
;		defb	  -3
;		defb	fetchS8
;		defb	scan
;		defb	dup
;		defb	emit
;		defb	ascii
;		defb	 "?"
;		defb	emit
;		defb	ascii
;		defb	  "D"
;		defb	eq
;		defb	unpend
;		defb	cr
;		defb	emit
;		defb	cr
; Unsafe string
;		defb	local
;		defb	  -3
;		defb	fetchE
;		defb	oppend
;		defb	dup
;		defb	emit
;		defb	ascii
;		defb	 "?"
;		defb	emit
;		defb	ascii
;		defb	  "D"
;		defb	eq
;		defb	unpend
;		defb	cr
;		defb	emit
;		defb	cr
;		defb	pass

;		defb	writeln

; Test words generator
;		defb	litE
;		defb	  end_wordList - do_wordList
;		; ( ??? -( ??? )- ??? )
;do_wordList:		rst	vm_rst
;			defb	typWords
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

; Test function type
;		defb	tick
;		defb	  index
;		defb	fnType


; Test decompiler
;		defb	zero
;		defb	tick
;		defb	  effWords
;		defb	tick
;		defb	  see
;		defb	see

; Test emitBuf
;		defb	litE
;		defb	  e_tryBuf - s_tryBuf
;s_tryBuf:		rst	vm_rst
;			defb	litS8
;			defb	  3
;			defb	  "ABC"
;			defb	tail
;			defb	  writeln
;e_tryBuf:		equ	$
;		defb	tryEmitBuf

; Test readln and writeln
;		defb	readln
;		defb	writeln
;		defb	rain

; Test word
;		defb	word
;		defb	string
;		defb	writeln
;		defb	rain

; Test compiler
		defb	litS8
		defb	  e_teststr - s_teststr
s_teststr:		defb	"ascii X ~ emit\n"
e_teststr:		equ	$
		defb	litE
		defb	  e_testcomp - s_testcomp
s_testcomp:		rst	vm_rst
			defb	input
			defb	emit
			defb	fail
			defb	  0
e_testcomp:		equ	$
		defb	feed

; REPL
;		defb	tick
;		defb	  emit
;		defb	litE
;		defb	  e_emitBuf - s_emitBuf
;s_emitBuf:		rst	vm_rst
;			defb	comp
;			defb	tick
;			defb	  emitBuf
;			defb	op
;			defb	drop
;			defb	local
;			defb	  -4
;			defb	fetchE
;			defb	tryTo
;			defb	  emit
;			defb	tail2
;e_emitBuf:	equ	$
;		defb	tryEmitBuf

		defb	tailself
		defb	  0x100 + repl - $

end_repl:
	defb	litE
	defb	  end_failure - failure
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
