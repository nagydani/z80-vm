swap_link:
	defw	link_final_dictionary
	defb	"swap", 0
	defw	comma

; ( a b -- b a )
swap:	toBC
	push	bc
	toBC
	push	bc
	pop	af
	pop	bc
	push	af
	fromBC
	pop	bc
	fromBC
	jp	(ix)

over_link:
	defw	swap_link
	defb	"over", 0
	defw	comma

; ( a b -- a b a )
over:	push	hl
	ld	hl, -4
	jr	ontop

dup_link:
	defw	over_link
	defb	"dup", 0
	defw	comma

; ( a -- a a )
dup:	push	hl
	ld	hl, -2
ontop:	add	hl, de
	ldi
	ldi
	pop	hl
	jp	(ix)

drop_link:
	defw	dup_link
	defb	"drop", 0
	defw	comma

; ( a -- )
drop:	dec	de
	dec	de
	jp	(ix)

link_final_stack:
nip_link:
	defw	drop_link
	defb	"nip", 0
	defw	comma

; ( a b -- b )
nip:	toBC
	dec	de
	dec	de
	fromBC
	jp	(ix)
