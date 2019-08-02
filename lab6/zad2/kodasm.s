OPEN = 5
READ = 3
WRITE = 4
CLOSE = 6

RDONLY = 0
RDWR_APP = 02102
READ_PRIV = 444
ALL_PRIV = 777
.data
filename:
	.asciz "tekst.txt"
nchar:
	.long 0
MASK:
	.int 32 #maska 100000
.section .bss
	.lcomm filehandle, 4
	.lcomm buff, 42
.text
.global main
main:

movq $filename, %rbx 
movq $OPEN, %rax
movq $RDWR_APP, %rcx
movq $ALL_PRIV, %rdx
int $0x80

#bad open protection
test %rax, %rax
js end

#copy filehandle
movq %rax, filehandle

#read
movq $READ, %rax
movq filehandle, %rbx
movq $buff, %rcx
movq $42, %rdx
int $0x80

movq %rax, nchar
movq $0, %rcx
#process
outer_loop:
	movl $0, %edi
loop:
	movb buff(%edi), %al
	movb $'\n', %cl
	cmp %al, %cl #nie zmieniamy konca lini
	je write
	movb $32, %cl
	xor %al, %cl #zmiana wielkosci litery
	movb %cl, buff(%edi)
	#WARUNEK WYJSCIA Z PETLI
	inc %edi
	cmp %edi, nchar
	je write
	jmp loop

write:
movq $WRITE, %rax
movq filehandle, %rbx
movq $buff, %rcx
movq nchar, %rdx
int $0x80

test %rax, %rax
js end


#close file
movq $CLOSE, %rax
movq filehandle, %rbx
int $0x80

#end program
end:
movl $0, %eax
call exit
