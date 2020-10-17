; ( : dent N8 : wrds E : code E -( emit )- )
do_see:	rst	vm_rst
	defb	use
	defb	  see_voc - $

; ---

	defb	op
	defb	litN8
		rst	vm_rst
	defb	litE
	defb	  rst_e - rst_s
rst_s:		rst	vm_rst
		defb	neq
		defb	drop
		defb	tail
		defb	  seeRaw
rst_e:		equ	$
	defb	litE
	defb	  see_e - see_s
see_s:		rst	vm_rst
		defb	local
		defb	  -5		; dent
		defb	fetchN8
		defb	indent
		defb	op
		defb	local
		defb	  -5		; wrds
		defb	fetchE
		defb	name
		defb	token
		defb	call
		defb	cr
		defb	tailself
		defb	  see_s - $
see_e:		equ	$
	defb	tick
	defb	  or
	defb	tick
	defb	  cr
	defb	or
	defb	pass
	defb	pass
	defb	tail
	defb	  drop

; ---

	defw	do_synWords
	defw	effects_tab
see_voc:defb	0x80

; ---

; ( -( emit )- )
; number
	defw	do_see_number

; ( -( emit )- )
; printable
	defw	do_see_printable

; ( -( emit )- )
; quote
	defw	do_see_quote

; ( -( emit )- )
; brace
	defw	do_see_brace

; ( -( emit )- )
; voc
	defw	do_see_voc

; ( -( emit )- )
; fn
	defw	do_see_fn

; ( -( emit )- )
; tailFn
	defw	do_see_tailFn

; ( -( emit )- )
; failOver
	defw	do_see_failOver

; ( -( emit )- )
; selfRef
	defw	do_see_selfRef

; ( -( emit )- )
; tailSelfRef
	defw	do_see_tailSelfRef

; ( -( emit )- )
; fnRef
	defw	do_see_fnRef

; ( -( emit )- )
; tailFnRef
	defw	do_see_tailFnRef

; ( -( emit )- )
; varRef
	defw	do_see_varRef

; ( -( emit )- )
; tailVarRef
	defw	do_see_tailVarRef

; ( -( emit )- )
; makeRef
	defw	do_see_makeRef

; ( -( emit )- )
; raw
	defw	do_see_raw



; ---

do_see_number:
	rst	vm_rst
	defb	write
	defb	op
	defb	tail
	defb	  hexnum

do_see_printable:
	rst	vm_rst
	defb	writesp
	defb	op
	defb	tail
	defb	  emit

do_see_quote:
	rst	vm_rst
	defb	write
	defb	op
	defb	local
	defb	  -3
	defb	fetchS8
	defb	litE
	defb	  quote_e - quote_s
quote_s:	rst	vm_rst
		defb	bite
		defb	litE
		defb	  char_e - char_s
char_s:			rst	vm_rst
			defb	dup
			defb	ascii
			defb	  "\\"
			defb	neq
			defb	stroke
			defb	drop
			defb	tail
			defb	  emit
char_e:			equ	$
		defb	litE
		defb	  code_e - code_s
code_s:			rst	vm_rst
			defb	litS8
			defb	  3
			defb	  "\\0x"
			defb	write
			defb	tail
			defb	  hexnum
code_e:			equ	$
		defb	or
		defb	tailself
		defb	  quote_s - $
quote_e:	equ	$
	defb	emptyE
	defb	or
	defb	adv
	defb	ascii
	defb	  "\""
	defb	tail
	defb	  emit


do_see_brace:
	rst	vm_rst
	defb	writeln
	; : quot
	defb	local
	defb	  -2
	defb	fetchE
	defb	op
	defb	drop		; length
	defb	local
	defb	  -7		; dent
	defb	fetchN8
	defb	one_plus
	defb	  0
	defb	local
	defb	  -7		; wrds
	defb	fetchE
	defb	local
	defb	  -5		; quot
	defb	fetchE
	defb	see
	defb	pass
	defb	op
	defb	adv
	defb	local
	defb	  -5		; dent
	defb	fetchN8
	defb	indent
	defb	ascii
	defb	  "}"
	defb	tail
	defb	  emit

; ( E S8 -( emit unpend fail )- E )
do_see_voc:
	rst	vm_rst
	defb	writesp
	defb	op
	defb	tail
	defb	  drop

do_see_fn:
	rst	vm_rst
	defb	tail
	defb	  write

do_see_tailFn:
	rst	vm_rst
	defb	write
	defb	fail
	defb	  0

do_see_failOver:
	
do_see_selfRef:
	rst	vm_rst
	defb	write
	defb	op
	defb	tail
	defb	  drop

do_see_tailSelfRef:
	rst	vm_rst
	defb	write
	defb	fail
	defb	  0

do_see_fnRef:
	rst	vm_rst
	defb	writesp
	defb	op
	defb	local
	defb	  -5
	defb	fetchE
	defb	name
	defb	drop
	defb	tail
	defb	  write

do_see_tailFnRef:
	rst	vm_rst
	defb	fnRef
	defb	fail
	defb	  0

do_see_varRef:
	rst	vm_rst
	defb	writesp
	defb	litS8
	defb	  2
	defb	  "0x"
	defb	tail
	defb	  number

do_see_tailVarRef:
	jr	do_see_tailSelfRef

do_see_makeRef:
	rst	vm_rst
	defb	varRef
	defb	litS8
	defb	  3
	defb	  " 0x"
	defb	tail
	defb	  number

do_see_raw:
	rst	vm_rst
	defb	drip		; empty string dropped
	defb	tail
	defb	  seeRaw

; ---

