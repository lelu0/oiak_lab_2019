
SYSCALL32 = 0x80 # sysfun: nr funkcji w %eax, parametry: %ebx, %ecx, %edx
EXIT = 1 #nr funkcji restartu (=1) – zwrot sterowania do s.o.
STDIN = 0 # nr wejścia standardowego (klawiatura) do %ebx
READ = 3 # nr funkcji odczytu wejścia (=3)
STDOUT = 1 # nr wyjścia standardowego (ekran tekstowy) do %ebx
WRITE = 4 # nr funkcji wyjścia (=4)
BUF_SIZE = 254 # rozmiar bufora (w bajtach/znakach ASCII) – max 254

.data
n: .int 6
k: .int 3
.text
.globl _start
_start:
	nop
	#licz perm. k
	movl k, %eax
	call perm
	movl %eax, %ecx #permutacja k w ecx
	movl n, %eax
	call perm
	pushq %rax #permutacja n na stos
	movl n, %eax
	sub k, %eax
	call perm #permutacja n-k w eax
	mul %ecx #mianownik w eax
	movl %eax, %ebx
	popq %rax #licznik w eax
	movl $0, %edx
	div %ebx #liczba kombinacji w eax 

	jmp exit #nie rob dalej
stackF:
	nop
	movl $100, %ebx
	movl $24, %ecx
stack_loop:
	pushq %rbx
	pushq %rcx
	call stackNWD
	cmp $0, %edx
	jne stack_loop

recF:
	nop
	movl $100, %ebx
	movl $45, %ecx
	call recNWD
exit:
	nop
	movl $EXIT , %EAX
	int $SYSCALL32

.type perm, @function
perm:
	movl %eax, %edi
	movl %eax, %ebx
loop:
	dec %edi
	jz endf
	mul %edi
	jmp loop 
endf:
	ret

.type stackNWD, @function
stackNWD:
	pushq %rbp
	movq %rsp, %rbp

	movl $0, %edx
	movl 24(%rbp), %eax
	movl 16(%rbp), %ecx
	div %ecx
	cmp $0, %edx
	je rets
	movl %ecx, %ebx
	movl %edx, %ecx

rets:
	movq %rbp, %rsp
	popq %rbp
	ret

.type recNWD, @function
recNWD:
	movl %ebx, %eax
	movl $0, %edx
	div %ecx
	cmp $0, %edx
	jz nc
	movl %ecx, %ebx
	movl %edx, %ecx
	call recNWD
nc:
	ret
