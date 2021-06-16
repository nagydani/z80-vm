ERR_SP:		equ	$
FAIL:		equ	ERR_SP + 2
DP:		equ	FAIL + 2
BASE:		equ	DP + 2
PAD:		equ	BASE + 1
PAD_LEN:	equ	32
CONTEXT:	equ	PAD + PAD_LEN
CURRENT:	equ	CONTEXT + 2
TIB:		equ	CURRENT + 2

DICTIONARY:	equ	TIB + 2
