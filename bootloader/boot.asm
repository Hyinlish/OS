;
; boot.asm
;
Boot_Start   	  equ 0x7c00
Loader_Start	equ 0x8000
Loader_Lenth  equ 1
;
; FAT16文件系统
;
jmp start
nop
db "OS_0.0.1"
dw 512 ; 扇区字节数
db 32 ; 每簇扇区数
dw 1 ; 保留扇区数
db 2 ; FAT数
dw 512 ; 根目录项数
dw 0 ; 小扇区数
db 0xf8 ; 表示硬盘
dw 1 ; 每FAT扇区数
dw 16 ; 每道扇区数
dw 2 ; 磁头数
dd 0 ; 隐藏扇区数
dd 2880 ; 总扇区数
db 0x80 ; 硬盘驱动器
db 1 ; 保留
db 0x29 ; 扩展引导标签
dd 0x33391cfe ; 分区序号（随机值，用于区分磁盘）
db "OOOOOOOOOOO" ; 卷标_11B
db "FAT16   " ; 系统ID_8B
;
; 引导程序
;
start:
	; 初始化
	mov ax,cs
	mov ds,ax
	mov es,ax
	mov ss,ax
	mov fs,ax
	mov sp,0x7c00
	mov ax,0x0003	;设置显示模式
	int 0x10
	; 清屏
	mov ax,0x0600
	int 0x10
	; 输出Log
	mov bp,Meg_1
	mov cx,Meg_1_Len
	mov dx,0x0000
	mov bl,0x02
	mov ax,0x1300
	int 0x10
;
; 0x00500 ~ 0x07BFF 自由内存区
; 0x07C00 ~ 0x07DFF 引导程序加载区
; 0x07E00 ~ 0x9FFFF 自由内存区
;
load_root:
	; 加载根目录到内存
	mov ah,0x02
	mov al,Loader_Lenth
	mov cx,0x0003
	mov dx,0x0000
	mov bx,Loader_Start
	int 0x13
;to_loader:
;	jmp Loader_Start

Meg_1: db "Start boot..."
Meg_1_Len equ $ - Meg_1

times 510 - ($ - $$) db 0
dw 0xaa55
