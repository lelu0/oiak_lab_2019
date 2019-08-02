.section .bss
	.lcomm status, 2
	.lcomm result, 2
.text
.globl check_bit_status
.type check_bit_status, @function
check_bit_status:
pushq %rbp
movq %rsp, %rbp



finit #inicjalizacja FPU
#pobranie rejestru stanu do rax
fstsw %ax
#testowe nadpisanie wartosci
movq $0b01001010, %rax

#test, maska przekazana do funkcji w postaci dziesietnej
test %rdi, %rax
#jezeli test zwroci flage ZF, to znaczy, ze zadany bit byl 0.

jz ret_no_e
movq $1, %rax #zwroc ustawiony bit
jmp end


ret_no_e:
movq $0, %rax
jmp end


#przywrocenie stosu
end:
movq %rbp, %rsp
popq %rbp
ret
