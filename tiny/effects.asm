emit:	equ	src_last
	defb	litE
	defb	  end_emit - do_emit
; ( C8 -( emit fail )- )
do_emit:	dec	de
		ld	a, (de)
		out	(0), a
		ret
end_emit:	equ	$

emitBuf:equ	emit + 1
	defb	zero
	defb	zero

key:	equ	emitBuf + 1
	defb	litE
	defb	  end_key - do_key
; ( -( key fail )- C8 )
do_key:		in	a, (0)
		ld	(de), a
		inc	de
		ret
end_key:	equ	$

keyBuf:	equ	key + 1
	defb	zero
	defb	zero

vocab:	equ	keyBuf + 1
; ( S8 -( pend )- maybe S8;wrds N8;tkn :: S8;wrd N8;cls )
	defb	tick
	defb	  effWords

intro:	equ	vocab + 1
	defb	litE
	defb	  end_intro - do_intro
do_intro:	rst	vm_rst
		defb	litN8
			rst	vm_rst
		defb	tail
		defb	  emit
end_intro:	equ	$

coda:	equ	intro + 1
	defb	tick
	defb	  ok

seeRaw:	equ	coda + 1
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
