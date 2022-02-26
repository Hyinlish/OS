;
; loader.asm
;
SECTION LOADER vstart=0x7e00
init:
	; 打印消息，证明加载及跳转成功 
	mov bp,Meg_2
	mov cx,Meg_2_Len
	mov dx,0x0100
	mov bl,0x02
	mov ax,0x1300
	int 0x10
	hlt

Meg_2: db "Start loader..."
Meg_2_Len equ $ - Meg_2
