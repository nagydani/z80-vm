; This is a test running in user space on the ZX Spectrum

vm:	macro
	call	vm_rst
	endm

	org	0x8000
start:	xor	a		; clear A and CF
	vm
	defw	if
	defb	  error - $

; Test IF-THEN-ELSE
	defw		if
	defb		  else1 - $
	defw			hello
	defw			fail
	defw		then
	defw			hello
	defw			skip
	defb		  	  endif1 - $
else1:	vm		; else
	defw			excl
endif1:	equ	$	; endif

; Test literals
	defw		lit8
	defb		  123
	defw		lit16
	defw		  12345
	defw		N_type
	defw		N_type

; Test countdown generator
	defw		if
	defb		  else2 - $
	defw			lit8
	defb			  10
	defw			N_countdown
	defw			N_type
	defw			fail
	defw		then
	defw			hello
	defw			skip
	defb			  endif2 - $
else2:	vm		; else
	defw			excl
endif2:	equ	$	; endif

; Test sequence generator
	defw		if
	defb		  else3 - $
	defw			lit8
	defb			  10
	defw			lit8
	defb			  100
	defw			lit8
	defb			  5
	defw			N_N_N_seq
	defw			N_type
	defw			fail
	defw		then
	defw			hello
	defw			skip
	defb			  endif3 - $
else3:	vm		; else
	defw			excl
endif3:	equ	$	; endif

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

	include	"vmrst.asm"
	include	"threading.asm"
	include	"try.asm"
	include	"then.asm"
	include "literals.asm"
	include "countdown.asm"
	include "seq.asm"
	include	"pick.asm"
	include "N_arithmetic.asm"
	include "swap.asm"
	include	"mut.asm"

VM_PTR:	defw	vm_l
ERR_SP:defw	0
FAIL_EFFECT:
	jp	ignore
