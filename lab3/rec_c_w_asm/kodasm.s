.data
arg: .long 5
format: .ascii "Silnia liczby %d, wynik: %d \n"
.text
.global main
main:

movq arg, %rdi #calling convention: %rdi, %rsi, %rdx, %rcx itd...
call fact

#wywolanie funkcji printf
movq %rax, %rdx
movq arg, %rsi
movq $format, %rdi
movq $0, %rax
call printf

movq $0, %rax
call exit
