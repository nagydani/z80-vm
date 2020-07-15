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
	defb	"raw~"
	defb	fn
	defb	"binM"
	defb	fn
	defb	"var~"
	defb	fn
	defb	"var"
	defb	fn
	defb	"fn~Ref"
	defb	fn
	defb	"fnRef"
	defb	fn
	defb	"self~Ref"
	defb	fn
	defb	"selfRef"
	defb	fn
	defb	"failOver"
	defb	fn
	defb	"defFn~"
	defb	fn
	defb	"defFn"
	defb	fn
	defb	"voc"
	defb	fn
	defb	"lCode"
	defb	fn
	defb	"lStr"
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
	defb	"core:"
	defb	fn
	defb	"io:"
	defb	fn
	defb	"src:"
	defb	fn
	defb	"eff:"
	defb	fn
	defb	"syntax:"
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
	defb	"tryAt"
	defb	fn
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
	defb	"pass"
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
	defb	"op"
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
	defb	">!"
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

