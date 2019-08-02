.data
texts: .long 5

.text
.global main
main:

movq texts, %rdi #calling convention: %rdi, %rsi, %rdx, %rcx itd...
call powerfunc

movq $4, %rdi
movq $6, %rsi

call printfunc

movl $0, %eax
call exit
