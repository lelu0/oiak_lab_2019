.section .data
a: 
	.float 378234781238127812738124821756.012412313213
h: 
	.float 0.000123123
v1:
	.float 0.5
.section .bss
	.lcomm status, 2
	.lcomm result, 2
	.lcomm control, 2
.text
.globl calc_field
.type calc_field, @function
calc_field:
pushq %rbp
movq %rsp, %rbp

finit
flds a
flds v1
fmul %st(1), %st(0)
flds h
fmul %st(1), %st(0)

movq %rbp, %rsp
popq %rbp
ret

