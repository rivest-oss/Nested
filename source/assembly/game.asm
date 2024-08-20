;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; game.asm
;; --------
;; Game code.
;; .

; Reserve zero-page,
.segment	"ZEROPAGE"
	frame_count:	.res	1

; and RAM.
.segment	"BSS"

.segment	"CODE"
	main:
		:
		jmp	:-

	sub_nmi:
		inc	frame_count
		rts

	sub_irq:
		rts
