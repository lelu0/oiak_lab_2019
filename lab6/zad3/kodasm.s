OPEN = 5
READ = 3
WRITE = 4
CLOSE = 6

RDONLY = 0
RDWR_TR = 01102
READ_PRIV = 444
ALL_PRIV = 777
.data
filename:
	.asciz "tekst.txt"

output:
	.asciz "xxxxxxxxxxxxxxxxxxxxxxxxxx \n"
nchar:
	.long 23
.section .bss
	.lcomm filehandle, 4
	.lcomm buff, 42
.text
.global main
main:

movq $filename, %rbx 
movq $OPEN, %rax
movq $RDWR_TR, %rcx
movq $ALL_PRIV, %rdx
int $0x80

#bad open protection
test %rax, %rax
js end

#copy filehandle
movq %rax, filehandle

#getcupid
movq $3, %rax
cpuid

movq $output, %rdi
movq %rbx, 0(%rdi)
movq %rdx, 3(%rdi)
movq %rcx, 7(%rdi)

movq $0, %rax
cpuid

movq $output, %rdi
movq %rbx, 11(%rdi)
movq %rdx, 15(%rdi)
movq %rcx, 19(%rdi)

write:
movq $WRITE, %rax
movq filehandle, %rbx
movq $output, %rcx
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
