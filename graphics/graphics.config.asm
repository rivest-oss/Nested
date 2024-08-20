; CHR ROM data.

; First CHR bank.
; Each segment is 8kb, but we store data in 4kb tilesets.
; Each segment thus contains 2 tilesets. 
.segment	"CHR_00"
	.incbin	"./background.chr"
	.incbin	"./sprite.chr"

; Other chr banks need some data in them...
