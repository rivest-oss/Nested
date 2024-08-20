.include		"./constants.asm"
.include		"./ines_header.asm"
.include		"../../graphics/graphics.config.asm"

.segment		"OAM"
	OAM:		.res	256

; Include code.
.segment		"CODE"
	.include	"game.asm"
	.include	"reset.asm"

	BACKGROUND:
		.incbin	"../../graphics/example.nam"
	PALETTE:
		; Foreground,
		.incbin	"../../graphics/example.pal"
		; and background.
		.incbin	"../../graphics/example.pal"

; Vectors.
.segment		"VECTORS"
	.word		handle_nmi
	.word		handle_reset
	.word		handle_irq
