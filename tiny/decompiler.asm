; ( S8 E -( emit )- )
do_see:	rst	vm_rst
	defb	use
	defb	  end_see_local - see_local
see_local:	defw	core_tab
see_voc:	defb	0x100 - io_last

see_tab:	equ	$

; ---

; ( -( key emit )- )
; quote:	equ	$ - see_tab + io_last
	defb	do_see_quote - $

; ( -( key emit )- )
; brace:	equ	$ - see_tab + io_last
	defb	do_see_brace - $

; ( -( key emit )- )
; voc:	equ	$ - see_tab + io_last
	defb	do_see_voc - $

; ( -( key emit )- )
; fn:	equ	$ - see_tab + io_last
	defb	do_see_fn - $

; ( -( key emit )- )
; fnRef:	equ	$ - see_tab + io_last
	defb	do_see_fnRef - $

; ( -( key emit )- )
; selfRef:equ	$ - see_tab + io_last
	defb	do_see_selfRef - $

; varRef:equ	$ - see_tab + io_last
	defb	do_see_varRef - $

; ( -( key emit )- )
; raw:	equ	$ - see_tab + io_last
	defb	do_see_raw - $

; ---

do_see_quote:
do_see_brace:
do_see_voc:
do_see_fn:
do_see_fnRef:
do_see_selfRef:
do_see_varRef:
do_see_raw:

; ---

end_see_local:	equ	$
