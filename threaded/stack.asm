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

dup_link:
	defw	swap_link
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

over_link:
	defw	dup_link
	defb	"over", 0
	defw	comma

; ( a b -- a b a )
over:	push	hl
	ld	hl, -4
	jr	ontop

third_link:
	defw	over_link
	defb	"third", 0
	defw	comma

; ( a b c -- a b c a )
third:	push	hl
	ld	hl, -6
	jr	ontop

drop_link:
	defw	third_link
	defb	"drop", 0
	defw	comma

; ( a -- )
drop:	dec	de
	dec	de
	jp	(ix)

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

toR_link:
	defw	nip_link
	defb	">r", 0
	defw	comma

toR:	toBC
	push	bc
	jp	(ix)

fromR_link:
	defw	toR_link
	defb	"r>", 0
	defw	comma

fromR:	pop	bc
	fromBC
	jp	(ix)

link_final_stack:
fromRdrop_link:
	defw	fromR_link
	defb	"r>drop", 0
	defw	comma

fromRdrop:
	pop	bc
	jp	(ix)
