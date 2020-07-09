emit:	equ	core_last
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

write:	equ	key + 1
	defb	litE
	defb	  end_write - do_write
; ( S8 -( emit )- )
do_write:	rst	vm_rst
		defb	tick
		defb	  bite
		defb	tick
		defb	  emit
		defb	tail
		defb	  while
end_write:	equ	$

writeln:equ	write + 1
	defb	litE
	defb	  end_writeln - do_writeln
; ( S8 -( emit )- )
do_writeln:	rst	vm_rst
		defb	write
		defb	litN8
		defb	  0x0A
		defb	tail
		defb	  emit
end_writeln:	equ	$

readln:	equ	writeln + 1
	defb	litE
	defb	  end_readln - do_readln
; ( -( key )- S8 )
do_readln:	rst	vm_rst
		defb	zero
		defb	litE
		defb	  readln_end - start_readln
start_readln:		rst	vm_rst
			defb	key
			defb	litN8
			defb	  0x0A
			defb	neq
			defb	append
			defb	  0
			defb	tailself
			defb	  start_readln - $
readln_end:	defb	tick
		defb	  string
		defb	tail
		defb	  or
end_readln:	equ	$

seeRaw:	equ	readln + 1
	defb	litE
	defb	  end_seeRaw - do_seeRaw
; ( E -( emit )- )
do_seeRaw:	rst	vm_rst
		defb	litS8
		defb	  end_seeRawName - seeRawName
seeRawName:		defb	"~raw"
end_seeRawName:	defb	writeln
		defb	fail
end_seeRaw:	equ	$

effects_last:	equ	key + 1
