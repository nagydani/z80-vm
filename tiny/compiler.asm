; ( ( -( e )- ) -( e monad )- )
do_tryBuf:
	exx
	ld	hl, -0x100
	add	hl, sp
	ld	sp, hl
	xor	a
	ld	(hl), a
	push	hl
	exx
	pop	bc
	call	pushBC
	call	do_tryTo
	exx
	ld	hl, 0x100
	add	hl, sp
	ld	sp, hl
	exx
	ret

; ( N8 -( ??? )- )
do_buf:	call	vm_tick
	ex	de, hl
	inc	(hl)		; TODO: error handling
	ld	e, (hl)
	ld	d, 0
	add	hl, de
	push	hl
	exx
	pop	bc
	dec	de
	ld	a, (de)
	ld	(bc), a
	ret

; ( ( -( emit e )- ) -( emit e )- )
do_tryEmitBuf:
	rst	vm_rst
	defb	litE
	defb	  e_doEmit - s_doEmit
s_doEmit:	rst	vm_rst
		defb	buf
		defb	  emitBuf
		defb	tail
		defb	  ok
e_doEmit:	equ	$
	defb	litE
	defb	  e_tryEmit - s_tryEmit
s_tryEmit:	rst	vm_rst
		defb	tryTo
		defb	  emit
		defb	tick
		defb	  emitBuf
		defb	fetchN8
		defb	  emit
		defb	tick
		defb	  emitBuf
		defb	op
		defb	tail
		defb	  write
e_tryEmit:	equ	$
	defb	tryBuf
	defb	  emitBuf
	defb	tail
	defb	  ok

; ( -( key )- V8 )
do_word:rst	vm_rst
	defb	zero
	defb	input
	defb	stroke
	defb	unpend
	defb	ascii
	defb	  "\""
	defb	tick
	defb	  neq
	defb	litE
	defb	  e_quotword - s_quotword
s_quotword:	rst	vm_rst
		defb	ascii
		defb	  "\""
		defb	append
		defb	  0
		defb	tail
		defb	  tail2
e_quotword:	equ	$
	defb	or
	defb	append
	defb	  0		; cannot fail here
	defb	litE
	defb	  e_word - s_word
s_word:		rst	vm_rst
		defb	key
		defb	stroke
		defb	append
		defb	  0
		defb	tailself
		defb	  s_word - $
e_word:		equ	$
	defb	emptyE
	defb	tail
	defb	  or

; ( E -( key emit )- )
do_comp:rst	vm_rst
	defb	use
	defb	  comp_voc - $

; ---

	defw	do_synWords
	defw	effects_tab
comp_voc:defb	0x80

; ---

; ( -( key emit )- )
; number
	defw	do_number

; ( -( key emit )- )
; printable
	defw	do_printable

; ( -( key emit )- )
; quote
	defw	do_quote

; ( -( key emit )- )
; brace
	defw	do_brace

; ( -( key emit )- )
; voc
	defw	do_voc

; ( -( key emit )- )
; fn
	defw	do_fn

; ( -( key emit )- )
; failOver
	defw	do_failOverFn

; ( -( key emit )- )
; selfRef
	defw	do_selfRef

; ( -( key emit )- )
; fnRef
	defw	do_fnRef

; ( -( key emit )- )
; varRef
	defw	do_varRef

; ( -( key emit )- )
; makeRef
	defw	do_makeRef

; ( -( key emit )- )
; raw
	defw	do_raw

; ---

do_number:
do_printable:
do_quote:
do_brace:
do_voc:
do_fn:
do_failOverFn:
do_fnRef:
do_selfRef:
do_varRef:
do_makeRef:
do_raw:

; ---

