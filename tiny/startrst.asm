	org	0
rst0:	di
	ld	sp, 0
	xor	a
	jp	start

	defs	rst0 + 8 - $
	include	"vmrst.asm"
