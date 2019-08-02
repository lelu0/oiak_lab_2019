.section .bss
	.lcomm control, 2
	.lcomm result, 2
.text
.globl set_control_fct
.type set_control_fct, @function
set_control_fct:
pushq %rbp
movq %rsp, %rbp

finit #inicjalizacja FPU
#przesun rejestr o 8 
shlq $8, %rdi
#przesun precyzje
shlq $10, %rsi

#ustawianie rejestru
movq $0, %rax
fstcw control
movq control, %rax
and $0b000011111111, %rax #wyzerowanie bitow sterowania 
or %rdi, %rax
or %rsi, %rax
movq %rax, control
fldcw control 
fstcw result

#przywrocenie stosu
movq %rbp, %rsp
popq %rbp
ret
