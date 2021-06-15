countdown_link:
	defw	link_final_arithmetics
	defb	"countdown&", 0
	defw	comma

; ( n -( fail pend )- n )
countdown:
	vm
	defw	oneminus
	defw	carry
	defw	litN16, countdown
	defw	pend
	defw	tail, dup

scanstr_link:
	defw	countdown_link
	defb	"scan&", 0
	defw	comma

; ( a -( fail pend )- c )
scanstr:vm
	defw	dup
	defw	cfetch
	defw	nonzero
	defw	drop
	defw	litS8
	defb	  scstr1e - scstr1
scstr1:		vm
		defw	oneplus
		defw	tail, scanstr
scstr1e:defw	pend
	defw	dup
	defw	tail, cfetch

link_final_generators:
traverse_link:
	defw	scanstr_link
	defb	"traverse&", 0
	defw	comma

; ( a -( fail pend )- a )
traverse:
	vm
	defw	fetch
	defw	nonzero
	defw	litN16, traverse
	defw	pend
	defw	dup
	defw	tail, cellplus

