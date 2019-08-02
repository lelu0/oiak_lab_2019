.text
.globl pow_and_div_fct
.type pow_and_div_fct, @function
pow_and_div_fct:
pushq %rbp
movq %rsp, %rbp
movq %rdi, %rax
mulq %rdi
movq $0, %rdx #argumenty 0:rax / %rdi
movq $2, %rdi
div %rdi
#przywrocenie stosu
movq %rbp, %rsp
popq %rbp
ret
