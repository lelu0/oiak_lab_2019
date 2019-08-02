.section .data
var:
	.float 3.14
var_int:
	.int 7

.text
.globl _start
_start:

nop
#finit
#fild var_int
fld var

movl $1, %eax
movl $0, %ebx
int $0x80
