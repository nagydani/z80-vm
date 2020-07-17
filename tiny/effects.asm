emit:	equ	src_last
	defb	litE
	defb	  end_emit - do_emit
	defb	  t_emit - do_emit
; ( C8 -( emit fail )- )
do_emit:	dec	de
		ld	a, (de)
		out	(0), a
		ret
t_emit:	defb	1, C8
	defb	2, emit, fail
	defb	0
end_emit:	equ	$

key:	equ	emit + 1
	defb	litE
	defb	  end_key - do_key
	defb	  t_key - do_key
; ( -( key fail )- C8 )
do_key:		in	a, (0)
		ld	(de), a
		inc	de
		ret
t_key:	defb	0
	defb	2, key, fail
	defb	1, C8
end_key:	equ	$

seeRaw:	equ	key + 1
	defb	litE
	defb	  end_seeRaw - do_seeRaw
	defb	  t_seeRaw - do_seeRaw
; ( E -( emit )- )
do_seeRaw:	rst	vm_rst
		defb	litS8
		defb	  end_seeRawName - seeRawName
seeRawName:		defb	"~raw"
end_seeRawName:	defb	writeln
		defb	tail
		defb	  pass
t_seeRaw:defb	1, addr
	defb	1, emit
	defb	0
end_seeRaw:	equ	$

effects_last:	equ	seeRaw + 1
