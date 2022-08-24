here_link:
	defw	link_final_execution
	defb	"here", 0
	defw	comma

; ( -( heap )- a )
here:	ld	bc, (DP)
	fromBC
	jp	(ix)

dictionary_link:
	defw	here_link
	defb	"dictionary", 0
	defw	comma

; ( -- a )
dictionary:
	ld	bc, DICTIONARY
	fromBC
	jp	(ix)

dp_link:
	defw	dictionary_link
	defb	"dp", 0
	defw	comma

; ( -( heap )- a )
dp:	ld	bc, DP
	fromBC
	jp	(ix)

comma_link:
	defw	dp_link
	defb	",", 0
	defw	comma

; ( n -( heap )- )
comma:	toBC
	push	hl
	ld	hl, (DP)
	ld	(hl), c
	inc	hl
	ld	(hl), b
commax:	inc	hl
	ld	(DP), hl
	pop	hl
	jp	(ix)

ccomma_link:
	defw	comma_link
	defb	"c,", 0
	defw	comma

; ( c -( heap )- )
ccomma:	toBC
	push	hl
	ld	hl, (DP)
	ld	(hl), c
	jr	commax

scomma_link:
	defw	ccomma_link
	defb	"s,", 0
	defw	comma

; ( a -( heap )- )
scomma:	vm
	defw	litS8
	defb	  scomma1e - scomma1
scomma1:	vm
		defw	dup
		defw	cfetch
		defw	nonzero
		defw	ccomma
		defw	oneplus
		defw	tailself
		defb	  scomma1 - $
scomma1e:
	defw	litS8
	defb	  scomma0e - scomma0
scomma0:	vm
		defw	tail, drop
scomma0e:
	defw	tailor

link_final_dictionary:
allot_link:
	defw	scomma_link
	defb	"allot", 0
	defw	comma

; ( n -( heap )- )
allot:	vm
	defw	dp
	defw	fetch
	defw	plus
	defw	dp
	defw	tail, store
