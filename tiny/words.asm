words_first:equ	0x80

number:	equ	words_first + 0

printable:equ	words_first + 1

quote:	equ	words_first + 2

brace:	equ	words_first + 3

voc:	equ	words_first + 4

fn:	equ	words_first + 5

failOver:equ	words_first + 6

selfRef:equ	words_first + 7

fnRef:	equ	words_first + 8

varRef:	equ	words_first + 9

raw:	equ	words_first + 10


do_srcWords:
	rst	vm_rst
	defb	litS8
	defb	  end_src_words - src_words
src_words:
	defb	src_last
	defb	"see"
	defb	fn
	defb	"comp"
	defb	fn
	defb	"coreWords:"
	defb	fn
	defb	"ioWords:"
	defb	fn
	defb	"srcWords:"
	defb	fn
	defb	"index"
	defb	fn
	defb	"name"
	defb	fn
	defb	"words:"
	defb	fn
	defb	"verbatim"
	defb	fn
	defb	"stroke"
	defb	fn
end_src_words:	equ	$
	defb	tick
	defb	  words
	defb	tick
	defb	  ioWords
	defb	tail
	defb	  or



do_ioWords:
	rst	vm_rst
	defb	litS8
	defb	  end_io_words - io_words
io_words:
	defb	io_last
	defb	"readln"
	defb	fn
	defb	"writeln"
	defb	fn
	defb	"write"
	defb	fn
end_io_words:	equ	$
	defb	tick
	defb	  words
	defb	tick
	defb	  coreWords
	defb	tail
	defb	  or


do_coreWords:
	rst	vm_rst
	defb	litS8
	defb	  end_core_words - core_words
core_words:
	defb	core_last
	defb	"tryWith"
	defb	fnRef
	defb	"let$"
	defb	fn
	defb	"letFn"
	defb	fn
	defb	"let"
	defb	fn
	defb	"$"
	defb	fn
	defb	"fn"
	defb	fn
	defb	"@"
	defb	fn
	defb	"times:"
	defb	fn
	defb	"pour"
	defb	fn
	defb	"use"
	defb	voc
	defb	"toStr"
	defb	fn
	defb 	"|"
	defb	fn
	defb	"while"
	defb	fn
	defb	"call"
	defb	fn
	defb	"rain"
	defb	fn
	defb	"scan:"
	defb	fn
	defb	"~:"
	defb	fn
	defb	"chop"
	defb	fn
	defb	"bite"
	defb	fn
	defb	"local"
	defb	fn
	defb	"var"
	defb	varRef
	defb	"swap"
	defb	fn
	defb	"0"
	defb	fn
	defb	"{}"
	defb	fn
	defb	"1-"
	defb	failOver
	defb	"1+"
	defb	failOver
	defb	","
	defb	fn
	defb	"=!"
	defb	fn
	defb	"="
	defb	fn
	defb	"dup"
	defb	fn
	defb	"drop"
	defb	fn
	defb	"{"
	defb	brace
	defb	"tryTo"
	defb	fnRef
	defb	"token"
	defb	fn
	defb	"'"
	defb	fnRef
	defb	"'self"
	defb	selfRef
	defb	"\""
	defb	quote
	defb	"0x"
	defb	number
	defb	"`"
	defb	fnRef
	defb	"ascii"
	defb	printable
	defb	"~raw"
	defb	raw
	defb	"~self"
	defb	selfRef
	defb	"~"
	defb	fnRef
	defb	"ok"
	defb	fn
	defb	"~fail"
	defb	varRef
	defb	"'fail|"
	defb	varRef
end_core_words:	equ	$
	defb	tail
	defb	  words

