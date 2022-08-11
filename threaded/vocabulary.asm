skipstr_link:
	defw	link_final_interpreter
	defb	"skipstr", 0
	defw	comma

; ( a -- a )
skipstr:vm
	defw	dup
	defw	strlen
	defw	plus
	defw	tail, oneplus

context_link:
	defw	skipstr_link
	defb	"context", 0
	defw	comma

; ( -- a )
context:ld	bc, CONTEXT
	fromBC
	jp	(ix)

current_link:
	defw	context_link
	defb	"current", 0
	defw	comma

; ( -- a )
current:ld	bc, CURRENT
	fromBC
	jp	(ix)

seed_link:
	defw	current_link
	defb	"seed", 0
	defw	comma

seed:	ld	bc, seedv
	ld	(CONTEXT), bc
	jp	(ix)
seedv:	defw	link_final_debug

cons_link:
	defw	seed_link
	defb	"cons", 0
	defw	comma
; ( a -- a )
cons:	vm
	defw	here
	defw	swap
	defw	tail, comma

last_link:
	defw	cons_link
	defb	"last", 0
	defw	comma

last:	vm
	defw	current
	defw	fetch
	defw	tail, fetch

create_link:
	defw	last_link
	defb	"create", 0
	defw	comma

create:	vm
	defw	last
	defw	cons
	defw	current
	defw	fetch
	defw	store
	defw	word
	defw	pad
	defw	scomma
	defw	litN16, comma
	defw	comma
	defw	litN8
	dat
	defw	tail, ccomma

variable_link:
	defw	create_link
	defb	"variable", 0
	defw	comma

variable:
	vm
	defw	create
	defw	tail, comma

redefine_link:
	defw	variable_link
	defb	"redefine", 0
	defw	comma

redefine:
	vm
	defw	last
	defw	cellplus
	defw	skipstr
	defw	cellplus
	defw	dp
	defw	tail, store

constant_link:
	defw	redefine_link
	defb	"constant", 0
	defw	comma

constant:
	vm
	defw	create
	defw	redefine
	defw	litN8
	defb	  1	; ld bc, nn
	defw	ccomma
	defw	comma
	defw	litN8
		fromBC
	defw	ccomma
	defw	litN16
		jp	(ix)
	defw	tail, comma

effect_link:
	defw	constant_link
	defb	"effect", 0
	defw	comma

effect:	vm
	defw	create
	defw	redefine
	defw	litN8
	defb	  0xC3	; jp xx
	defw	ccomma
	defw	tickid
	defw	tail, comma

colon_link:
	defw	effect_link
	defb	"{:", 0
	defw	fail		; TODO: compile-time error

colon:	vm
	defw	create
	defw	redefine
	defw	quotation
	defw	tail, drop

search_link:
	defw	colon_link
	defb	"search", 0
	defw	comma

; ( a -( pad fail )- a )
search:	vm
	defw	traverse
	defw	pad
	defw	streq
	defw	cut
	defw	tail, nip

find_link:
	defw	search_link
	defb	"find", 0
	defw	comma

; ( -( pad fail )- a )
find:	vm
	defw	context
	defw	fetch
	defw	search
	defw	tail, skipstr

immediate_link:
	defw	find_link
	defb	"immediate", 0
	defw	comma

immediate:
	vm
	defw	litN16, exec
	defw	last
	defw	cellplus
	defw	skipstr
	defw	tail, store

link_final_vocabulary:
forget_link:
	defw	immediate_link
	defb	"forget", 0
	defw	comma

; ( -( heap )- )
forget:	vm
	defw	word
	defw	current
	defw	fetch
	defw	context
	defw	fetch
	defw	eq
	defw	search
	defw	dictionary
	defw	ge
	defw	cellminus
	defw	dup
	defw	fetch
	defw	current
	defw	fetch
	defw	store
	defw	dp
	defw	tail, store
