words_first:equ	0x80

; syntax
number:	equ	words_first + 0
printable:equ	words_first + 1
quote:	equ	words_first + 2
brace:	equ	words_first + 3
voc:	equ	words_first + 4
fn:	equ	words_first + 5
tailFn:	equ	words_first + 6
failOverFn:equ	words_first + 7
selfRef:equ	words_first + 8
tailSelfRef:equ	words_first + 9
fnRef:	equ	words_first + 10
tailFnRef:equ	words_first + 11
varRef:	equ	words_first + 12
tailVarRef:equ	words_first + 13
makeRef:equ	words_first + 14
raw:	equ	words_first + 15
syn_last:equ	words_first + 16

types_first:equ	syn_last

; types
N8:	equ	types_first + 0
S8:	equ	types_first + 1
addr:	equ	types_first + 2
func:	equ	types_first + 3
recType:equ	types_first + 4
V8:	equ	types_first + 5
C8:	equ	types_first + 6
N8max:	equ	types_first + 7
minusOne:equ	types_first + 8
V8plus:	equ	types_first + 9
vocab:	equ	types_first + 10
state:	equ	types_first + 11
setminus:equ	types_first + 13
dict:	equ	types_first + 14
pred:	equ	types_first + 15
body:	equ	types_first + 16
forWhile:equ	types_first + 17
forOr:	equ	types_first + 18
forUnless:equ	types_first + 19
handler:equ	types_first + 20
overrun:equ	types_first + 21
ormaybe:equ	types_first + 22
tickcode:equ	types_first + 23
backticktok:equ	types_first + 24
backtickself:equ types_first + 25
backtick_:equ	types_first + 26
tok:	equ	types_first + 27
selfArg:equ	types_first + 28
selfVal:equ	types_first + 29
sub:	equ	types_first + 30
emptyFn:equ	types_first + 31
funcType:equ	types_first + 32
effSet:	equ	types_first + 33
funcArg:equ	types_first + 34
funcEff:equ	types_first + 35
funcVal:equ	types_first + 36
types_last:equ	types_first + 37

do_moreWords:
	rst	vm_rst
	defb	tick
	defb	  words
	defb	tail
	defb	  unless

do_typWords:
	rst	vm_rst
	defb	litS8
	defb	  end_typ_words - typ_words
typ_words:
	defb	types_last
	defb	"(?)`val"
	defb	fn
	defb	"(?)`eff"
	defb	fn
	defb	"(?)`arg"
	defb	fn
	defb	"-(?)-"
	defb	fn
	defb	"(?)`"
	defb	fn
	defb	"(--)"
	defb	fn
	defb	"_"
	defb	fn
	defb	"'self`val"
	defb	fn
	defb	"'self`arg"
	defb	fn
	defb	"tok"
	defb	fn
	defb	"`_"
	defb	fn
	defb	"'self`"
	defb	fn
	defb	"`tok"
	defb	fn
	defb	"'code"
	defb	fn
	defb	"|maybe"
	defb	fn
	defb	"overrun"
	defb	fn
	defb	"handler"
	defb	fn
	defb	"forUnless"
	defb	fn
	defb	"for|"
	defb	fn
	defb	"forWhile"
	defb	fn
	defb	"(body)"
	defb	fn
	defb	"(pred)"
	defb	fn
	defb	"dict"
	defb	fn
	defb	"\\"
	defb	fn
	defb	";;"
	defb	fn
	defb	"vocab"
	defb	fn
	defb	"V8+"
	defb	fn
	defb	"[-1]"
	defb	fn
	defb	"[256]"
	defb	fn
	defb	"C8"
	defb	fn
	defb	"V8"
	defb	fn
	defb	"[?]"
	defb	fn
	defb	"(?)"
	defb	fn
	defb	"addr"
	defb	fn
	defb	"S8"
	defb	fn
	defb	"N8"
	defb	fn
end_typ_words:equ	$
	defb	tick
	defb	  effWords
	defb	tail
	defb	  moreWords


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
	defb	"defBumpFn"
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
	defb	"core;"
	defb	fn
	defb	"io;"
	defb	fn
	defb	"src;"
	defb	fn
	defb	"eff;"
	defb	fn
	defb	"syntax;"
	defb	fn
	defb	"typ;"
	defb	fn
	defb	"moreWords;"
	defb	fn
	defb	"index"
	defb	fn
	defb	"name"
	defb	fn
	defb	"words;"
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
	defb	"times;"
	defb	fn
;	defb	"pour"
;	defb	fn
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
	defb	"op;"
	defb	fn
	defb	"bite;"
	defb	fn
	defb	"!!"
	defb	fn
	defb	"~;"
	defb	tailFn
	defb	"val"
	defb	fn
	defb	"eff"
	defb	fn
	defb	"arg"
	defb	fn
	defb	"`"
	defb	fn
	defb	"adv"
	defb	fn
	defb	"local"
	defb	varRef
	defb	"var"
	defb	varRef
	defb	"swap"
	defb	fn
	defb	"chop"
	defb	fn
	defb	"bite"
	defb	fn
	defb	"{}"
	defb	fn
	defb	"'self"
	defb	selfRef
	defb	"'"
	defb	fnRef
	defb	"op"
	defb	fn
	defb	"0"
	defb	fn
	defb	"~bump"
	defb	failOverFn
	defb	"1-"
	defb	failOverFn
	defb	"1+"
	defb	failOverFn
	defb	","
	defb	failOverFn
	defb	"token"
	defb	fn
	defb	"tryTo"
	defb	fnRef
	defb	">!"
	defb	fn
	defb	"=!"
	defb	fn
	defb	"="
	defb	fn
	defb	"~fail"
	defb	tailVarRef
	defb	"'fail|"
	defb	varRef
	defb	"make"
	defb	makeRef
	defb	"dup"
	defb	fn
	defb	"drop"
	defb	fn
	defb	"{"
	defb	brace
	defb	"\""
	defb	quote
	defb	"0x"
	defb	number
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
end_core_words:	equ	$
	defb	tail
	defb	  words

