pad_link:
	defw	link_final_chars
	defb	"pad", 0
	defw	comma

; ( -- a )
pad:	vm
	defw	litN16, PAD
	defw	tail2

tib_link:
	defw	pad_link
	defb	"tib", 0
	defw	comma

; ( -- a )
tib:	vm
	defw	litN16, TIB
	defw	tail2


skipws_link:
	defw	tib_link
	defb	"skipws", 0
	defw	comma

; ( a -- a )
skipws:	vm
	defw	litS8
	defb	  skws1e - skws1
skws1:		vm
		defw	dup
		defw	cfetch
		defw	nonzero
		defw	whitespace
		defw	drop
		defw	oneplus
		defw	tailself
		defb	  skws1 - $
skws1e:	defw	litN16, ok
	defw	tail, or

link_final_input:
word_link:
	defw	skipws_link
	defb	"word", 0
	defw	comma

; ( -( tib fail )- )
word:	vm
	defw	tib
	defw	fetch
	defw	skipws
	defw	pad
	defw	litS8
	defb	  word1e - word1
word1:		vm
		defw	over		; a pad a
		defw	cfetch		; a pad c
		defw	printable
		defw	over		; a pad c pad
		defw	cstore		; a pad
		defw	pad
		defw	litN8
		defb	  PAD_LEN
		defw	plus
		defw	lt
		defw	oneplus
		defw	swap
		defw	oneplus
		defw	swap
		defw	tailself
		defb	  word1 - $
word1e:	defw	litS8
	defb	  word2e - word2
word2:		vm
		defw	litN8
		defb	  0
		defw	swap
		defw	cstore
		defw	dup
		defw	cfetch
		defw	whitespace
		defw	drop
		defw	tib
		defw	tail, store
word2e:	defw	tail, or
