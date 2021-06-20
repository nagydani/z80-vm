oneminus_link:
	defw	link_final_stack
	defb	"1-", 0
	defw	comma

; ( n -( carry )- n )
oneminus:
	toBC
	dec	bc
	fromBC
	ld	a, b
	and	c
	add	a, 1
	jp	(ix)

oneplus_link:
	defw	oneminus_link
	defb	"1+", 0
	defw	comma

; ( n -( carry )- n )
oneplus:toBC
	inc	bc
	fromBC
	ld	a, b
	or	c
	sub	a, 1
	jp	(ix)

plus_link:
	defw	oneplus_link
	defb	"+", 0
	defw	comma

; ( n n -( carry )- n )
plus:	toBC
	push	bc
	toBC
	ex	(sp), hl
	add	hl, bc
	ld	c, l
	ld	b, h
	pop	hl
	fromBC
	jp	(ix)

minus_link:
	defw	plus_link
	defb	"-", 0
	defw	comma

; ( n n -( carry )- n )
minus:	toBC
	push	bc
	toBC
	push	bc
	exx
	pop	hl
	pop	bc
	and	a
	sbc	hl, bc
	push	hl
	exx
	pop	bc
	fromBC
	jp	(ix)

ge_link:
	defw	minus_link
	defb	">=", 0
	defw	comma

; ( n n -( fail )- n )
ge:	vm
	defw	over
	defw	swap
	defw	minus
	defw	carry
	defw	tail, drop

le_link:
	defw	ge_link
	defb	"<=", 0
	defw	comma

; ( n n -( fail )- n )
le:	vm
	defw	over
	defw	minus
	defw	carry
	defw	tail, drop

gt_link:
	defw	le_link
	defb	">", 0
	defw	comma

; ( n n -( fail )- n )
gt:	vm
	defw	oneplus
	defw	carry
	defw	tail, ge

lt_link:
	defw	gt_link
	defb	"<", 0
	defw	comma

; ( n n -( fail )- n )
lt:	vm
	defw	oneminus
	defw	carry
	defw	tail, le

band_link:
	defw	lt_link
	defb	"and", 0
	defw	comma

; ( n n -- n )
band:	toBC
	dec	de
	ld	a, (de)
	and	b
	ld	(de), a
	dec	de
	ld	a, (de)
	and	c
bend:	ld	(de), a
	inc	de
	inc	de
	jp	(ix)

bor_link:
	defw	band_link
	defb	"or", 0
	defw	comma

; ( n n -- n )
bor:	toBC
	dec	de
	ld	a, (de)
	or	b
	ld 	(de), a
	dec	de
	ld	a, (de)
	or	c
	jr	bend

bxor_link:
	defw	bor_link
	defb	"xor", 0
	defw	comma

; ( n n -- n )
bxor:	toBC
	dec	de
	ld	a, (de)
	xor	b
	ld 	(de), a
	dec	de
	ld	a, (de)
	xor	c
	jr	bend

cells_link:
	defw	bxor_link
	defb	"cells", 0
	defw	comma

; ( n -- a )
cells:	toBC
	sla	c
	rl	b
	fromBC
	jp	(ix)

cellplus_link:
	defw	cells_link
	defb	"cell+", 0
	defw	comma

; ( a -- a )
cellplus:
	toBC
	inc	bc
	inc	bc
	fromBC
	jp	(ix)

cellminus_link:
	defw	cellplus_link
	defb	"cell-", 0
	defw	comma

; ( a -- a )
cellminus:
	toBC
	dec	bc
	dec	bc
	fromBC
	jp	(ix)

ustar_link:
	defw	cellminus_link
	defb	"u*", 0
	defw	comma

; ( n n -- l h )
ustar:	toBC
	push	bc
	toBC
	push	bc
	exx
	pop	bc
	pop	de
	ld	hl,0
	ld	a, 0x10
mloop:	add	hl, hl
	ex	de, hl
	adc	hl, hl
	ex	de, hl
	jr	nc, mskip
	add	hl, bc
	jr	nc, mskip
	inc	de
mskip:	dec	a
	jr	nz, mloop
	push	de
	push	hl
	exx
	pop	bc
	fromBC
	pop	bc
	fromBC
	jp	(ix)

star_link:
	defw	ustar_link
	defb	"*", 0
	defw	comma

; ( n n -- n )
star:	vm
	defw	ustar
	defw	tail, drop

slashmod_link:
	defw	star_link
	defb	"/mod", 0
	defw	comma

; ( n n -- n n )
slashmod:
	toBC
	push	bc
	toBC
	push	bc
	exx
	pop	bc
	pop	de
	ld	hl, 0
	ld	a, b
	ld	b, 8
divl1:	rla
	adc	hl, hl
	sbc	hl, de
	jr	nc, divna1
	add	hl, de
divna1:	djnz	divl1
	rla
	cpl
	ld	b, a
	ld	a, c
	ld	c, b
	ld	b, 8
divl2:	rla
	adc	hl, hl
	sbc	hl, de
	jr	nc, divna2
	add	hl, de
divna2:	djnz divl2
	rla
	cpl
	ld	b, c
	ld	c, a
	push	bc
	push	hl
	exx
	pop	bc
	fromBC
	pop	bc
	fromBC
	jp	(ix)

slash_link:
	defw	slashmod_link
	defb	"/", 0
	defw	comma

; ( n n -- n )
slash:	vm
	defw	slashmod
	defw	tail, drop

link_final_arithmetics:
mod_link:
	defw	slash_link
	defb	"mod", 0
	defw	comma

; ( n n -- n )
mod:	vm
	defw	slashmod
	defw	swap
	defw	tail, drop
