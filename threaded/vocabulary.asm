context_link:
	defw	link_final_output
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
	ld	(context), bc
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

create_link:
	defw	cons_link
	defb	"create", 0
	defw	comma

create:	vm
	defw	current
	defw	fetch
	defw	fetch
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

constant_link:
	defw	variable_link
	defb	"constant", 0
	defw	comma

constant:
	vm
	defw	create
	defw	litN8
	defb	  1	; ld bc, nn
	defw	here
	defw	oneminus
	defw	cstore
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
	defw	litN8
	defb	  0xC3	; jp xx
	defw	here
	defw	oneminus
	defw	cstore
	defw	litN16, ok
	defw	tail, comma

colon_link:
	defw	effect_link
	defb	":", 0
	defw	fail		; TODO: compile-time error

colon:	vm
	defw	create
	defw	litN8
		vm
	defw	here
	defw	oneminus
	defw	cstore
	defw	litN16, compile
	defw	litN16, ok
	defw	tail, or

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

link_final_vocabulary:
forget_link:
	defw	find_link
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
