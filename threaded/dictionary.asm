here_link:
	defw	link_final_execution
	defb	"here", 0
	defw	comma

; ( -( heap )- a )
here:	ld	bc, (DP)
	fromBC
	jp	(ix)

comma_link:
	defw	here_link
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

link_final_dictionary:
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
