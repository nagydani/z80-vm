RECORD:	equ	0xFF
UNION:	equ	0xFE

EmptyType:
	defb	0

Byte:
PrimitiveType:
	defb	1	; one byte length

R:			; return address
E:			; execution token
T:			; type reference
Addr:			; A
N:	defb	2	; two bytes length

PairT:	defb	RECORD
	defw	T
	defw	T

Record:	defb	RECORD
	defw	Byte
	defw	PairT

Union:	defb	RECORD
	defw	Byte
	defw	E	; A RETURNS T

Type:	defb	UNION
	defw	getType

; Get the current type
; A
; RETURNS T
getType:ld	a, (hl)
	push	hl
	cp	UNION
	jr	c, typeP
	jr	z, typeUnion
	ld	hl, Record
	jp	(ix)
typeUnion:
	ld	hl, Union
	jp	(ix)
typeP:	ld	hl, PrimitiveType
	jp	(ix)

; Get the current heap address type
; Returns T
typeA:	push	hl
	ld	hl, Addr
	jp	(ix)

; Size of an instance in memory
; T A:a
; RETURNS N
size:	pop	bc
	ld	a, (bc)
	cp	UNION
	jr	c, size_p
	inc	bc
	push	bc		; x
	ex	af, af'		; save ZF
	vm
	defw	argN
	defb	  4		; x
	defw	lit8
	defb	  4
	defw	StoV
	defw	Ndrop
	defw	cpu
	ex	af, af'
	jr	z, size_u
size_r:	vm
	defw	argA
	defb	  6		; a
	defw	size
	defw	Ndup
	defw	argA
	defb	  8
	;defw	NAswap		; unnecessary in this arch
	defw	ANadv
	defw	argA
	defb	  4
	defw	AAswap
	defw	size
	defw	add
	defw	cpu
tail_t:	ex	de, hl
	pop	de
	pop	bc
	pop	bc
	jp	(ix)

size_u:	vm
	defw	argA
	defb	  6		; a
	defw	AAswap
	defw	call
	defw	AAswap
	defw	size
	defw	cpu
	JR tail_t		; TODO: implement proper tail call

size_p:	ld	l, a
	xor	a
	ld	h, a
	jp	(ix)
