words_first:equ	0x80

number:	equ	words_first + 0

printable:equ	words_first + 1

quote:	equ	words_first + 2

brace:	equ	words_first + 3

voc:	equ	words_first + 4

fn:	equ	words_first + 5

tailFn:	equ	words_first + 6

failOver:equ	words_first + 7

selfRef:equ	words_first + 8

tailSelfRef:equ	words_first + 9

fnRef:	equ	words_first + 10

tailFnRef:equ	words_first + 11

varRef:	equ	words_first + 12

tailVarRef:equ	words_first + 13

makeRef:equ	words_first + 14

raw:	equ	words_first + 15

syn_last:equ	words_first + 16


do_moreWords:
	rst	vm_rst
	defb	tick
	defb	  words
	defb	tail
	defb	  unless

do_synWords:
	rst	vm_rst
	defb	litS8
	defb	  end_syn_words - syn_words
syn_words:
	defb	syn_last
	defb	"p~raw"
	defb	fn
	defb	"pMake"
	defb	fn
	defb	"p~var"
	defb	fn
	defb	"pVar"
	defb	fn
	defb	"p~fn"
	defb	fn
	defb	"pFn"
	defb	fn
	defb	"p~self"
	defb	fn
	defb	"pSelf"
	defb	fn
	defb	"sFailOver"
	defb	fn
	defb	"s~fn"
	defb	fn
	defb	"sFn"
	defb	fn
	defb	"sVoc"
	defb	fn
	defb	"l{"
	defb	fn
	defb	"l\""
	defb	fn
	defb	"lChar"
	defb	fn
	defb	"lNum"
	defb	fn
end_syn_words:equ	$
	defb	tick
	defb	  effWords
	defb	tail
	defb	  moreWords

do_effWords:
	rst	vm_rst
	defb	litS8
	defb	  end_eff_words - eff_words
eff_words:
	defb	effects_last
	defb	"seeRaw"
	defb	fn
	defb	"key"
	defb	fn
	defb	"emit"
	defb	fn
end_eff_words:equ	$
	defb	tick
	defb	  srcWords
	defb	tail
	defb	  moreWords

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
	defb	"effWords:"
	defb	fn
	defb	"synWords:"
	defb	fn
	defb	"moreWords:"
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
	defb	  ioWords
	defb	tail
	defb	  moreWords


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
	defb	"cr"
	defb	fn
	defb	"write"
	defb	fn
end_io_words:	equ	$
	defb	tick
	defb	  coreWords
	defb	tail
	defb	  moreWords


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
	defb 	"unless"
	defb	fn
	defb 	"|"
	defb	fn
	defb	"while"
	defb	fn
	defb	"call"
	defb	fn
	defb	"drip"
	defb	fn
	defb	"rain"
	defb	fn
	defb	"scan:"
	defb	fn
	defb	"~:"
	defb	tailFn
	defb	"chop"
	defb	fn
	defb	"bite"
	defb	fn
	defb	"adv"
	defb	fn
	defb	"local"
	defb	varRef
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
	defb	failOver
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
	defb	"make"
	defb	makeRef
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
;	defb	"~raw"
	defb	raw
	defb	"~self"
	defb	tailSelfRef
	defb	"~"
	defb	tailFnRef
	defb	"ok"
	defb	fn
	defb	"~fail"
	defb	tailVarRef
	defb	"'fail|"
	defb	varRef
end_core_words:	equ	$
	defb	tail
	defb	  words

