.text
.globl fact
.type fact, @function
fact:
pushq %rbp
movq %rsp, %rbp

cmp $0, %rdi
je wr1

movq %rdi, %rbx
dec %rdi
call fact
mulq %rdi

jmp esc
wr1: #zwrocenie 1 jezeli n = 0
movq $1, %rax
esc:

#przywrocenie stosu
movq %rbp, %rsp
popq %rbp
ret


#if n = 1 wyjdz zwracajac jeden
#else zworc n * funkcja (n-1)
