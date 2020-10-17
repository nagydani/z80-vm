emit:	equ	src_last
	defb	litE
	defb	  end_emit - do_emit
; ( C8 -( emit fail )- )
do_emit:	dec	de
		ld	a, (de)
		out	(0), a
		ret
end_emit:	equ	$

key:	equ	emit + 1
	defb	litE
	defb	  end_key - do_key
; ( -( key fail )- C8 )
do_key:		in	a, (0)
		ld	(de), a
		inc	de
		ret
end_key:	equ	$

seeRaw:	equ	key + 1
	defb	litE
	defb	  end_seeRaw - do_seeRaw
; ( E -( !! emit )- )
do_seeRaw:	rst	vm_rst
		defb	unpend
		defb	litS8
		defb	  end_seeRawName - seeRawName
seeRawName:		defb	"~raw"
end_seeRawName:	defb	tail
		defb	  writeln
end_seeRaw:	equ	$

effects_last:	equ	seeRaw + 1
