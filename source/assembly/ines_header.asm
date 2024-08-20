;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ines_header.asm
;; ---------------
;; iNES 2.0 header.
;; .

.segment	"HEADER"
	INES_MAPPER	=	0	; 0 = NROM.
	INES_MIRROR	=	0	; Mirroring: 0 = horizontal, 1 = vertical.
	INES_SRAM	=	0	; 1 = Battery-backed SRAM at $6000...$7fff.
	;
	.byte	"NES", $1a	; Magic number
	.byte	1			; 16 KiB PRG banks.
	.byte	1			; 8 KiB CHR banks.
	.byte	INES_MIRROR | (INES_SRAM << 1) | ((INES_MAPPER & $f) << 4)
	.byte	(INES_MAPPER & %11110000)

	; Padding
	.byte	$0, $0, $0, $0, $0, $0, $0, $0
