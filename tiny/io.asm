emit:	equ	core_last
	defb	litE
	defb	  end_emit - do_emit
; ( C8 -( emit fail )- )
do_emit:
	dec	de
	ld	a, (de)
	out	(0), a
	ret
end_emit:	equ	$

key:	equ	emit + 1
	defb	litE
	defb	  end_key - do_key
; ( -( key fail )- C8 )
do_key:
	in	a, (0)
	ld	(de), a
	inc	de
	ret
end_key:	equ	$

io_last:	equ	key + 1
