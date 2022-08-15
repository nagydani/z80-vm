link_final_generators:
traverse_link:
	defw	link_final_arithmetics
	defb	"traverse&", 0
	defw	comma

; ( a -( fail pend )- a )
traverse:
	vm
	defw	fetch
	defw	nonzero
	defw	tickself
	defb	  traverse - $
	defw	pend
	defw	dup
	defw	tail, cellplus

