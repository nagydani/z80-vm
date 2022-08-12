cpu_link:
	defw	link_final_literal
	defb	"cpu", 0
	defw	comma

cpu:	ex	(sp), hl
	ret

;id_link:
;	defw	cpu_link
;	defb	"id", 0
;	defw	comma
;
;id:	jp	(ix)

tickid_link:
	defw	cpu_link
;	defw	id_link
	defb	"'id", 0
	defw	comma

tickid:	ld	bc, id
	fromBC
id:	jp	(ix)

tail_link:
	defw	tickid_link
	defb	"}~", 0
	defw	endtail

tail:	ld	a, (hl)
	inc	hl
	ld	h, (hl)
	ld	l, a
	ex	(sp), hl
	ret

tail2_link:
	defw	tail_link
	defb	"}", 0
	defw	endcomp

tail2:	pop	hl
	jp	(ix)

tickself_link:
	defw	tail2_link
	defb	"'self", 0
	defw	selfref

tickself:
	ld	c, (hl)
	ld	b, 0xFF
	push	hl
	add	hl, bc
	ld	c, l
	ld	b, h
	pop	hl
	inc	hl
	fromBC
	jp	(ix)

selfref:vm
	defw	comma
	defw	dup
	defw	dup
	defw	here
	defw	minus
	defw	tail, ccomma

tailself_link:
	defw	tickself_link
	defb	"}~self", 0
	defw	tailselfref

tailself:
	ld	c, (hl)
	ld	b, 0xFF
	add	hl, bc
	ex	(sp), hl
	ret

tailselfref:
	vm
	defw	selfref
	defw	fail

even_link:
	defw	tailself_link
	defb	"even", 0
	defw	comma

; ( n -( fail )- n )
even:	ld	c, e
	ld	b, d
	dec	bc
	dec	bc
	ld	a, (bc)
	and	1
	jr	nz, failnz
	jp	(ix)

odd_link:
	defw	even_link
	defb	"odd", 0
	defw	comma

; ( n -( fail )- n )
odd:	ld	c, e
	ld	b, d
	dec	bc
	dec	bc
	ld	a, (bc)
	and	1
	jr	z, fail
	jp	(ix)

eq_link:
	defw	odd_link
	defb	"=", 0
	defw	comma

; ( n n -( fail )- n )
eq:	toBC
	push	bc
	toBC
	ex	(sp), hl
	and	a
	sbc	hl, bc
	pop	hl
failnz:	jr	nz, fail
eq2:	inc	de
	inc	de
	jp	(ix)

neq_link:
	defw	eq_link
	defb	"<>", 0
	defw	comma

; ( n n -( fail )- n )
neq:	toBC
	push	bc
	toBC
	ex	(sp), hl
	and	a
	sbc	hl, bc
	pop	hl
	jr	z, fail
	jr	eq2

iszero_link:
	defw	neq_link
	defb	"0=", 0
	defw	comma

; ( n -( fail )- n )
iszero:	ex	de, hl
	dec	hl
	ld	a, (hl)
	dec	hl
	or	(hl)
	inc	hl
	inc	hl
	ex	de, hl
	jr	nz, fail
	jp	(ix)

nonzero_link:
	defw	iszero_link
	defb	"0<>", 0
	defw	comma

; ( n -( fail )- n )
nonzero:ex	de, hl
	dec	hl
	ld	a, (hl)
	dec	hl
	or	(hl)
	inc	hl
	inc	hl
	ex	de, hl
	jr	z, fail
	jp	(ix)

carry_link:
	defw	nonzero_link
	defb	"carry?", 0
	defw	comma

; ( -( fail )- )
carry:	jr	c, fail
	jp	(ix)

fail_link:
	defw	carry_link
	defb	"}~fail", 0
	defw	endcomp

; ( -( fail )- )
fail:	ld	bc, FAIL

; BC = exception pointer
; Handler frame:
;	handler pointer, previous handler address, previous ERR_SP, previous data stack pointer
catch:	ld	sp, (ERR_SP)
	pop	hl		; handler pointer
	and	a
	sbc	hl, bc
	add	hl, bc		; ZF = 1, if found
	pop	de		; previous handler address
	ld	a, (hl)
	ld	(hl), e
	ld	e, a
	inc	hl
	ld	a, (hl)
	ld	(hl), d		; restore previous handler address
	ld	d, a		; DE = current handler address
	pop	hl		; previous ERR_SP
	ld	(ERR_SP), hl
	jr	nz, catch	; next handler, if not found
	ex	de, hl		; HL = current handler address
	pop	de		; restore data stack pointer
	ex	(sp), hl	; HL = continue here after handler
	ret			; continue with handler

pend_link:
	defw	fail_link
	defb	"&", 0
	defw	comma

; 
pend:	toBC			; handler address in BC
	push	de		; data stack pointer on call stack
	exx
	ld	hl, (ERR_SP)
	push	hl
	ld	hl, (FAIL)
	push	hl
	ld	hl, FAIL
	push	hl
	ld	(ERR_SP), sp
	exx
	ld	(FAIL), bc
	ld	bc, 6
	push	bc
	ld	bc, upend
	push	bc
	jp	(ix)

upend:	defw	cpu
	inc	hl
	inc	hl
	push	hl
	exx
	pop	hl
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	exx
	ex	(sp), hl
	ld	bc, upend
	push	bc
	jp	(ix)

handle_link:
	defw	pend_link
	defb	"handle", 0
	defw	comma

; ( arg ( arg -( effect )- val ) 'handler 'effect -- val )
handle:	push	hl		; outer function on call stack
	toBC
	inc	bc		; BC = handler pointer
	push	bc
	toBC			; BC = new handler address
	push	bc
	exx
	pop	bc		; BC = new handler address
	pop	hl		; HL = handler pointer
	ld	a, (hl)
	ld	(hl), c
	ld	c, a
	inc	hl
	ld	a, (hl)
	ld	(hl), b
	ld	b, a		; BC = old handler address
	dec	hl
	exx
	dec	de
	dec	de
	push	de		; data stack pointer on call stack
	inc	de
	inc	de
	ld	bc, (ERR_SP)
	push	bc		; old ERR_SP on call stack
	exx
	push	bc		; old handler address on call stack
	push	hl		; handler pointer on call stack
	ld	(ERR_SP), sp	; ERR_SP updated
	exx
	ld	hl, hcut
	push	hl		; placeholder
	toBC
	push	bc
	ret

hcut:	defw	cpu
	ld	hl, (ERR_SP)
	and	a
	sbc	hl, sp
	jr	nz, hcut2
	exx
	pop	hl		; handler pointer
	pop	de		; previous handler address
	ld	(hl), e
	inc	hl
	ld	(hl), d		; restore previous handler
	pop	hl		; previous ERR_SP
	ld	(ERR_SP), hl	; restore previous ERR_SP
	pop	de		; discard data stack pointer
	exx
	pop	hl
	jp	(ix)

	; TODO: ugly hack
hcut2:	add	hl, sp
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	c, (hl)
	inc	hl
	ld	b, (hl)		; BC = next frame
	ld	hl, 6
	add	hl, bc
	sbc	hl, sp
	ex	(sp), hl	; new offset
	ld	hl, upend
	jp	(ix)

exec_link:
	defw	handle_link
	defb	"execute", 0
	defw	comma

; ( a ( a -( e )- b ) -( e )-  b )
exec:	toBC
	push	bc
	ret

cut_link:
	defw	exec_link
	defb	"cut", 0
	defw	comma

; ( -( \handler )- )
cut:	exx
	ld	hl, (ERR_SP)
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	inc	hl		; DE = handler pointer
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	inc	hl		; BC = previous handler address
	ex	de, hl
	ld	(hl), c
	inc	hl
	ld	(hl), b		; restore previous handler
	ex	de, hl
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	inc	hl
	ex	de, hl		; HL = previous ERR_SP
	ld	(ERR_SP), hl	; restore previous ERR_SP
	inc	de
	ld	hl, -12
	add	hl, de		; HL points below the handler frame
	push	hl
	scf
	sbc	hl, sp
	ld	c, l
	ld	b, h		; BC is the length of the stack below the handler frame
	pop	hl
	jr	z, cutbot
	lddr			; move stack up
cutbot:	ex	de, hl
	inc	hl
	ld	sp, hl
	pop	bc		; discard threading
	exx
	jp	(ix)

or_link:
	defw	cut_link
	defb	"|", 0
	defw	comma

; ( ( -( e )- val ) ( -( f )- val ) -( e f )- val )
or:	vm
	defw	litN16, FAIL - 1
	defw	tail, handle

tailor_link:
	defw	or_link
	defb	"}~|", 0
	defw	endcomp

tailor:	vm
	defw	or, tail, tail2

tickidor_link:
	defw	tailor_link
	defb	"'id|", 0
	defw	comma

tickidor:
	vm
	defw	tickid
	defw	tailor

tickidtailor_link:
	defw	tickidor_link
	defb	"'id}~|", 0
	defw	endcomp

tickidtailor:
	vm
	defw	tickidor
	defw	tail, tail2

fetch_link:
	defw	tickidtailor_link
	defb	"@", 0
	defw	comma

; ( a -- n )
fetch:	toBC
	ld	a, (bc)
	inc	bc
	ld 	(de), a
	ld	a, (bc)
fetchx:	inc	de
	ld	(de), a
	inc	de
	jp	(ix)

cfetch_link:
	defw	fetch_link
	defb	"c@", 0
	defw	comma

; ( a -- c )
cfetch:	toBC
	ld	a, (bc)
	ld	(de), a
	xor	a
	jr	fetchx

cstore_link:
	defw	cfetch_link
	defb	"c!", 0
	defw	comma

; ( c a -- )
cstore:	toBC
	dec	de
xstore:	dec	de
	ld	a, (de)
	ld	(bc), a
	jp	(ix)

link_final_execution:
store_link:
	defw	cstore_link
	defb	"!", 0
	defw	comma

; ( n a -- )
store:	toBC
	dec	de
	inc	bc
	ld	a, (de)
	ld	(bc), a
	dec	bc
	jr	xstore
