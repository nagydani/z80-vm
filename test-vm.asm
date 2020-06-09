; This is a test running in user space on the ZX Spectrum

vm:	macro
	call	vm_rst
	endm

exception: macro
	call	ex_rst
	endm

	org	0x8000
start:	ld	ix, vm_l	; success handler
	xor	a		; clear A and CF (success state)
	vm
	defw	if
	defb	  error - $
; test embedded IF_THEN_ELSE (else branch)
	defw		if
	defb		  else1b - $
	defw			hello
	defw			fail
	defw		then
	defw			hello
	defw			skip
	defb		  	  endif1b - $
else1b:	exception
	vm		; else
	defw			excl
endif1b:equ	$	; endif

	defw	test_IF_THEN
	defw	test_IF_ELSE
	defw	test_literals
	defw	test_countdown
	defw	test_seq

	defw	then
	defw	cpu
	rst	8
	defb	0xFF

error:	rst	8
	defb	0x0B

fail:	vm
	defw	setcf
	defw	end

setcf:	scf
	jp	(ix)

excl:	ld	a,"!"
	jr	print
hello:	ld	a,"H"
print:	rst	16
cr:	ld	a,13
	rst	16
	and	a
	jp	(ix)

Ntype:	ld	c, l
	ld	b, h
	push	de
	call	0x2D2B			; stack_bc
	call	0x2DE3			; print_fp
	pop	de
	pop	hl
	jr	cr

test_IF_THEN:
	vm
	defw	if
	defb	  else0 - $
	defw		hello
	defw	then
	defw		hello
	defw		skip
	defb	  	  endif0 - $
else0:	exception
	vm	; else
	defw		excl
endif0:	defw	end ; endif

test_IF_ELSE:
	vm
	defw	if
	defb	  else1 - $
	defw		hello
	defw		fail
	defw	then
	defw		hello
	defw		skip
	defb	  	  endif1 - $
else1:	exception
	vm	; else
	defw		excl
endif1:	defw	end ;endif

test_literals:
	vm
	defw	lit8
	defb	  123
	defw	lit16
	defw	  12345
	defw	Ntype
	defw	Ntype
	defw	end

test_countdown:
	vm
	defw	if
	defb	  else2 - $
	defw		lit8
	defb		  10
	defw		countdown
	defw		Ntype
	defw		fail
	defw	then
	defw		hello
	defw		skip
	defb		  endif2 - $
else2:	exception
	vm	; else
	defw		excl
endif2:	defw	end ; endif

test_seq:
	vm
	defw	if
	defb	  else3 - $
	defw		lit8
	defb		  10
	defw		lit8
	defb		  100
	defw		lit8
	defb		  5
	defw		seq
	defw		Ntype
	defw		fail
	defw	then
	defw		hello
	defw		skip
	defb		  endif3 - $
else3:	exception
	vm	; else
	defw		excl
endif3:	defw	end ; endif

	include	"exrst.asm"
	include	"vmrst.asm"
	include	"threading.asm"
	include	"try.asm"
	include	"then.asm"
	include "literals.asm"
	include "generators.asm"
	include	"pick.asm"
	include "arithmetic.asm"
	include "stack.asm"
	include	"mut.asm"

ERR_SP:defw	0
FAIL_EFFECT:
	jp	ignore
