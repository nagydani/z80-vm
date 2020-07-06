words_first:equ	0x80

quote:	equ	words_first + 0

brace:	equ	words_first + 1

voc:	equ	words_first + 2

fn:	equ	words_first + 3

failOver:equ	words_first + 4

fnRef:	equ	words_first + 5

selfRef:equ	words_first + 6

varRef:	equ	words_first + 7

raw:	equ	words_first + 8


core_words:
	defb	core_last
	defb	"see"
	defb	fn
	defb	"comp"
	defb	fn
	defb	"words"
	defb	fn
	defb	"readln"
	defb	fn
	defb	"writeln"
	defb	fn
	defb	"stroke"
	defb	fn
	defb	"tryWith"
	defb	fnRef
	defb	"strLet"
	defb	varRef
	defb	"fnLet"
	defb	varRef
	defb	"let"
	defb	varRef
	defb	"$"
	defb	varRef
	defb	"fn"
	defb	varRef
	defb	"@"
	defb	varRef
	defb	"pour"
	defb	fn
	defb	"locals"
	defb	varRef
	defb	"use"
	defb	voc
	defb	"toStr"
	defb	fn
	defb 	"|"
	defb	fn
	defb	"write"
	defb	fn
	defb	"call"
	defb	fn
	defb	"scan:"
	defb	fn
	defb	"chop"
	defb	fn
	defb	"bite"
	defb	fn
	defb	"times:"
	defb	fn
	defb	"~:"
	defb	selfRef
	defb	"=!"
	defb	fn
	defb	"="
	defb	fn
	defb	"1-"
	defb	failOver
	defb	"1+"
	defb	failOver
	defb	","
	defb	fn
	defb	"{}"
	defb	fn
	defb	"swap"
	defb	fn
	defb	"0"
	defb	fn
	defb	"rain"
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
	defb	"`"
	defb	fnRef
	defb	"~raw"
	defb	raw
	defb	"~self"
	defb	selfRef
	defb	"~"
	defb	fnRef
	defb	"ok"
	defb	fn
	defb	"fail"
	defb	fn
end_core_words:	equ	$
