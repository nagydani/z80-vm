; This is a test running in user space on the ZX Spectrum

vm:	macro
	call	vm_rst
	endm

	org	0x8000
start:	xor	a		; clear A and CF
	vm
	defw	try
	defw	  FAIL_EFFECT
	defw	  error

; Test IF-THEN-ELSE
	defw		try
	defw		  FAIL_EFFECT
	defw		  else
	defw			hello
	defw			fail
	defw			then
	defw			hello
	defw			skip
	defb			  endif - $
else:	vm
	defw			excl
endif:	equ	$

; Test literals
	defw	lit8
	defb	  123
	defw	lit16
	defw	  12345
	defw	N_type
	defw	N_type

	defw	then
	defw	cpu
	rst	8
	defb	0xFF

fail:	vm
	defw	setcf
	defw	end

setcf:	scf
ignore:	jp	(ix)

excl:	ld	a,"!"
	jr	print
hello:	ld	a,"H"
print:	rst	16
cr:	ld	a,13
	rst	16
	and	a
	jp	(ix)

N_type:	ld	c, l
	ld	b, h
	push	de
	call	0x2D2B			; stack_bc
	call	0x2DE3			; print_fp
	pop	de
	pop	hl
	jr	cr

error:	rst	8
	defb	0x0B

	include	"vmrst.asm"
	include	"threading.asm"
	include	"try.asm"
	include	"then.asm"
	include "literals.asm"

VM_PTR:	defw	vm_l
ERR_SP:defw	0
FAIL_EFFECT:
	jp	ignore
