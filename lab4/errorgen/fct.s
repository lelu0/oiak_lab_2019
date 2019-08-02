.section .data
v1: 
	.float 0.0000000000000000000000000001
v2: 
	.float 45.23
v3:
	.float 340028230000000000000000000000000000000.123
.section .bss
	.lcomm status, 2
	.lcomm result, 2
	.lcomm control, 2
.text
.globl check_bit_status
.type check_bit_status, @function
.globl div_z
.type div_z, @function
.globl ov
.type ov, @function
.globl set_control_fct
.type set_control_fct, @function
set_control_fct:
pushq %rbp
movq %rsp, %rbp

finit #inicjalizacja FPU

#ustawianie rejestru
fstcw control
movq control, %rax
#movq $0b0000000000111111, %rbx
movq $0b1111111111000000, %rbx
and %rbx, %rax
movq %rax, control
fldcw control

#przywrocenie stosu
movq %rbp, %rsp
popq %rbp
ret

div_z:

ret

ov:
pushq %rbp
movq %rsp, %rbp

#flds v1
flds v3
#fdiv %st(1)
flds v3
fmul %st(1),%st(0)
#fmul %st(1), %st(0)
flds v1
fmul %st(1), %st(0)

movq %rbp, %rsp
popq %rbp
ret


check_bit_status:
pushq %rbp
movq %rsp, %rbp



#pobranie rejestru stanu do rax
fstsw %ax

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
