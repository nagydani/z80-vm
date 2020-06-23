rst0:	di
	ld	sp, 0
	xor	a
	jp	start
	defs	rst0 + 8 - $
	include	"vmrst.asm"


start:	ld	de, WORKSP		; datastack
	exx
	ld	de, vm_tab
	exx
	rst	vm_rst
	defb	litE
	defb	  end_test - test
test:		rst	vm_rst
		defb	litS8
		defb	  end_hello - hello
hello:		defb	  "Hello", 0x0A
end_hello:
		defb	S8emit
		defb	key
		defb	word
		defb	tail
		defb	  fail
end_test:
	defb	litE
	defb	  end_failure - failure
failure:	rst	vm_rst
		defb	litS8
		defb	  end_fmsg - fmsg
fmsg:		defb	  "Failure.", 0x0A
end_fmsg:
		defb	tail
		defb	  S8emit
end_failure:
	defb	or
	defb	cpu
	halt

	include "seed.asm"

	include	"io.asm"

	include	"sysvars.asm"
