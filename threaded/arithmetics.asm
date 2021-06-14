; ( n -( carry )- n )
oneminus:
	toBC
	dec	bc
	fromBC
	ld	a, b
	and	c
	add	a, 1
	jp	(ix)

; ( n -( carry )- n )
oneplus:toBC
	inc	bc
	fromBC
	ld	a, b
	or	c
	sub	a, 1
	jp	(ix)

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

; ( n n -( fail )- n )
ge:	vm
	defw	over
	defw	swap
	defw	minus
	defw	carry
	defw	tail, drop

; ( n n -( fail )- n )
le:	vm
	defw	over
	defw	minus
	defw	carry
	defw	tail, drop

; ( n n -( fail )- n )
gt:	vm
	defw	oneplus
	defw	carry
	defw	tail, ge

; ( n n -( fail )- n )
lt:	vm
	defw	oneminus
	defw	carry
	defw	tail, le

; ( n n -( fail )- n )
eq:	vm
	defw	over
	defw	minus
	defw	iszero
	defw	tail, drop

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

; ( a -- a )
cellplus:
	toBC
	inc	bc
	inc	bc
	fromBC
	jp	(ix)

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

; ( n n -( fail )- n )
star:	vm
	defw	ustar
	defw	iszero
	defw	tail, drop

; ( n n -- n n )
divmod: toBC
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
	push	hl
	push	bc
	exx
	pop	bc
	fromBC
	pop	bc
	fromBC
	jp	(ix)

; ( n n -- n )
div:	vm
	defw	divmod
	defw	tail, drop

; ( n n -- n )
mod:	vm
	defw	divmod
	defw	swap
	defw	tail, drop
