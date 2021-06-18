whitespace_link:
	defw	link_final_generators
	defb	"ws", 0
	defw	comma

; ( c -( fail )- c )
whitespace:
	vm
	defw	litN8
	defb	  " "
	defw	tail, le

printable_link:
	defw	whitespace_link
	defb	"printable", 0
	defw	comma

; ( c -( fail )- c )
printable:
	vm
	defw	litN8
	defb	  "!"
	defw	ge
	defw	litN8
	defb	  126
	defw	tail, le

ddigit_link:
	defw	printable_link
	defb	"ddigit", 0
	defw	comma

; ( c -( fail )- c )
ddigit:	vm
	defw	litN8
	defb	  "0"
	defw	ge
	defw	litN8
	defb	  "9"
	defw	tail, le

lower_link:
	defw	ddigit_link
	defb	"lower", 0
	defw	comma

; ( c -( fail )- c )
lower:	vm
	defw	litN8
	defb	  "a"
	defw	ge
	defw	litN8
	defb	  "z"
	defw	tail, le

upper_link:
	defw	lower_link
	defb	"upper", 0
	defw	comma

; ( c -( fail )- c )
upper:	vm
	defw	litN8
	defb	  "A"
	defw	ge
	defw	litN8
	defb	  "Z"
	defw	tail, le

alpha_link:
	defw	upper_link
	defb	"letter", 0
	defw	comma

; ( c -( fail )- c )
alpha:	vm
	defw	litN16, lower
	defw	litN16, upper
	defw	tailor

alphanum_link:
	defw	alpha_link
	defb	"alphanum", 0
	defw	comma

; ( c -( fail )- c )
alphanum:
	vm
	defw	litN16, ddigit
	defw	litN16, alpha
	defw	tailor

toUpper_link:
	defw	alphanum_link
	defb	">upper", 0
	defw	comma

toUpper:vm
	defw	litS8
	defb	  toupe - toup
toup:		vm
		defw	lower
		defw	litN8
		defb	  0xDF
		defw	tail, band
toupe:	defw	tickidtailor

toLower_link:
	defw	toUpper_link
	defb	">lower", 0
	defw	comma

toLower:vm
	defw	litS8
	defb	  tolowe - tolow
tolow:		vm
		defw	upper
		defw	litN8
		defb	  0x20
		defw	tail, bor
tolowe:	defw	tickidtailor

base_link:
	defw	toLower_link
	defb	"base", 0
	defw	comma

; ( -- a )
base:	vm
	defw	litN16, BASE
	defw	tail2


digitToInt_link:
	defw	base_link
	defb	"digit>int", 0
	defw	comma

; ( c -( fail )- n )
digitToInt:
	vm
	defw	alphanum
	defw	toLower
	defw	litN8
	defb	  "0"
	defw	minus
	defw	carry
	defw	litS8
	defb	  ninelee - ninele
ninele:		vm
		defw	litN8
		defb	  9
		defw	tail, le
ninelee:defw	litS8
	defb	  ad2i_e - ad2i
ad2i:		vm
		defw	litN8
		defb	  39
		defw	tail, minus
ad2i_e:	defw	or
	defw	base
	defw	cfetch
	defw	tail, lt

tonumber_link:
	defw	digitToInt_link
	defb	">number", 0
	defw	comma

; ( a n -( fail )- n )
tonumber:
	vm
	defw	base		; a n base
	defw	cfetch		; a n @base
	defw	star		; a n
	defw	over		; a n a
	defw	cfetch		; a n c
	defw	digitToInt	; a n n
	defw	plus		; a n
	defw	carry		; a n
	defw	swap		; n a
	defw	oneplus		; n a
	defw	dup		; n a a
	defw	cfetch		; n a c
	defw	litS8
	defb	  numws_e - numws
numws:		vm
		defw	whitespace
		defw	drop
		defw	tail, drop
numws_e:defw	litS8
	defb	  numdg_e - numdg
numdg:		vm
		defw	drop
		defw	swap
		defw	tail, tonumber
numdg_e:defw	tailor


sToNumber_link:
	defw	tonumber_link
	defb	"s>number", 0
	defw	comma

; ( a -( fail )- n )
sToNumber:
	vm
	defw	litN8
	defb	  0
	defw	tail, tonumber

streq_link:
	defw	sToNumber_link
	defb	"s=", 0
	defw	comma

; ( a a -( fail )- a )
streq:	vm
	defw	over
	defw	cpu
	push	hl
	call	strcmp
strcmc:	pop	hl
	jp	c, fail
	jp	(ix)

strneq_link:
	defw	streq_link
	defb	"s<>", 0
	defw	comma

strneq:	vm
	defw	over
	defw	cpu
	push	hl
	call	strcmp
	ccf
	jr	strcmc

strcmp:	ex	de, hl
	dec	hl
	ld	d, (hl)
	dec	hl
	ld	e, (hl)
	dec	hl
	ld	b, (hl)
	dec	hl
	ld	c, (hl)
	ex	de, hl
strcmpl:ld	a, (bc)
	inc	bc
	cp	(hl)
	inc	hl
	scf
	ret	nz
	or	a
	jr	nz, strcmpl
	ret

;streq:	vm
;	defw	over
;	defw	litS8
;	defb	  streq1e - streq1
;streq1:		vm
;		defw	over
;		defw	cfetch
;		defw	over
;		defw	cfetch
;		defw	litN16, eq
;		defw	litS8
;		defb	  streq2e - streq2
;streq2:			vm
;			defw	cut
;			defw	fail
;streq2e:	defw	or
;		defw	nonzero
;		defw	drop
;		defw	oneplus
;		defw	swap
;		defw	oneplus
;		defw	tailself
;		defb	  streq1 - $
;streq1e:defw	tickidor
;	defw	drop, tail, drop

skipstr_link:
	defw	strneq_link
	defb	"skipstr", 0
	defw	comma

; ( a -- a )
skipstr:
	toBC
skps1:	ld	a, (bc)
	inc	bc
	or	a
	jr	nz, skps1
	fromBC
	jp	(ix)

;	vm
;	defw	litS8
;	defb	  skipste - skipst
;skipst:		vm
;		defw	dup
;		defw	cfetch
;		defw	nonzero
;		defw	drop
;		defw	oneplus
;		defw	tailself
;		defb	  skipst - $
;skipste:defw	litN16, oneplus
;	defw	tailor


link_final_chars:
strlen_link:
	defw	skipstr_link
	defb	"strlen", 0
	defw	comma

; ( a -- n )
strlen:	vm
	defw	dup
	defw	skipstr
	defw	oneminus
	defw	swap
	defw	tail, minus
