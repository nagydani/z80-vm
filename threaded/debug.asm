link_final_debug:
dots_link:
	defw	link_final
	defb	".s", 0
	defw	comma

dots:	push	hl
	ld	hl, STK_BOT
dotsl:	and	a
	sbc	hl, de
	add	hl, de
	jr	nz, dotslc
	pop	hl
	vm
	defw	tail, cr
dotslc:	ldi
	ldi
	vm
	defw	dot
	defw	cpu
	jr	dotsl
