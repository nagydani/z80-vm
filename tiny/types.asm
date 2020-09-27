	defb	0	; not accessible
; ( -- E )
do_typ:	pop	hl	; return address
	ex	de, hl
	inc	de	; skip type
	ld	(hl), e
	inc	hl
	ld	(hl), d
	inc	hl
	ex	de, hl
	pop	hl	; threading
	ret

;t_type:	defb	0
;		defb	0
;		defb	1, func


	defb	t_type - do_type
; ( -- ( -- N8 ) )
do_type:rst	token_rst
	defb	typ
	defb	t_refSize - do_refSize
do_refSize:
	ld	a, 2
pushA:	ld	(de), a
	inc	de
	ret

	defb	t_N8 - do_N8
; ( -- ( -- N8 ) )
do_N8:	rst	token_rst
	defb	typ
	defb	t_natSize - do_natSize
do_natSize:
	ld	a, 1
	jr	pushA

	defb	t_C8 - do_C8
; ( -- ( -- N8 ) )
do_C8:	rst	token_rst
	defb	typ
	defb	t_charSize - do_charSize
do_charSize:
	jr	do_natSize

	defb	t_rec - do_rec
; ( ( -- N8 ) ( -- N8 ) -( failOver )- ( -- N8 ) |maybe ( -- N8+ ) )
do_rec:	rst	token_rst
	defb	typ
	defb	t_recSize - do_recSize
do_recSize:
	rst	pop_rst
	call	do_call
	


t_C8:
t_N8:
t_type:	defb	0
	defb	0
	defb	1, type

t_refSize:
t_natSize:
t_charSize:
	defb	0
	defb	0
	defb	1, N8
