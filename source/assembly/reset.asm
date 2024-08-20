;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; reset.asm
;; ---------
;; Handles boot-up, reset, and IRQs/NMIs.
;; Clears and initializes memory, stack, et cetera.
;; .

handle_irq:
	; Store all registers.
	pha
	txa
	pha
	tya
	pha

	; Call the IRQs sub-routine.
	jsr	sub_irq

	; Restore all registers.
	pla
	tay
	pla
	tax
	pla

	; Return to the original code.
	rti

handle_nmi:
	; Store all registers.
	pha
	txa
	pha
	tya
	pha

	; Call the NMIs sub-routine.
	jsr	sub_nmi

	; Restore all registers.
	pla
	tay
	pla
	tax
	pla

	; Return to the original code.
	rti

handle_reset:
	sei	; Disable IRQs.
	cld	; Disable decimal mode.
	clc
	clv
	
	; Clear registers.
	lda	#$00
	tax
	tay
	txs

	; Clear NES' RAM.
	:
		; Intended underflow :P
		dex

		sta	$0000,	x
		sta	$0100,	x
		sta	$0200,	x
		sta	$0300,	x
		sta	$0400,	x
		sta	$0500,	x
		sta	$0600,	x
		sta	$0700,	x

		bne	:-
	
	sta	PPU_CTRL	; Disable NMI.
	sta	PPU_MASK	; Disable rendering.
	sta	APU_STATUS	; Disable APU sound.
	sta	APU_DMC_IRQ	; Disable DMC IRQ.

	lda	#$40
	sta	APU_FRAME_COUNTER	; Disable APU IRQ.

	; Wait for the first VBlank.
	:
		bit	PPU_STATUS
		bpl	:-
	
	; Place all sprites off-screen.
	lda	#$ff
	:
		sta	OAM,	x
		inx
		inx
		inx
		inx
		bne	:-
	
	; Wait for the second VBlank.
	:
		bit	PPU_STATUS
		bpl	:-
	
	; Enable the NMI.
	lda	#%10001000
	sta	PPU_CTRL

	; Clear A.
	lda	#$00

	jmp	main
