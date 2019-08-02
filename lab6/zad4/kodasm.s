
.data

cs:
	.long 0

.section .bss

.text
.global main
main:

rdtsc
movq %rax, cs
movq $10000, %rsi

funccall:
call calcFibo
dec %rsi
jnz funccall

rdtsc
movq $cs, %rbx
sub %rbx, %rax


movq $0, %rdx
movq $10000, %rcx
div %rcx

#end program
end:
movl $0, %eax
call exit


.type calcFibo, @function
calcFibo:
	#eax - n, ebx  - n-1, ecx - n-2
	movl $1, %eax
	movl $1, %ebx
	movl $100, %edi
loop:
	call fibo
	dec %edi
	jnz loop

.type fibo, @function
fibo:
	movl %eax, %ecx
	add %ebx, %eax #wynik w eax
	movl %ecx, %ebx
	ret

