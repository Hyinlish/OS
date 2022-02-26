os.img:boot loader
	dd if=boot of=os.img conv=notrunc
	sudo mount os.img /mnt
	sudo cp loader /mnt
	sudo umount /mnt
boot:bootloader/boot.asm
	nasm bootloader/boot.asm -o boot
loader:bootloader/loader.asm
	nasm bootloader/loader.asm -o loader 
