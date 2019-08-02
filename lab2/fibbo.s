
SYSCALL32 = 0x80 # sysfun: nr funkcji w %eax, parametry: %ebx, %ecx, %edx
EXIT = 1 #nr funkcji restartu (=1) – zwrot sterowania do s.o.
STDIN = 0 # nr wejścia standardowego (klawiatura) do %ebx
READ = 3 # nr funkcji odczytu wejścia (=3)
STDOUT = 1 # nr wyjścia standardowego (ekran tekstowy) do %ebx
WRITE = 4 # nr funkcji wyjścia (=4)
BUF_SIZE = 254 # rozmiar bufora (w bajtach/znakach ASCII) – max 254

.data
msg: .ascii "Hello!\n"
msg_len = . - msg
TEXT_SIZE: .long 0
BUF: .space BUF_SIZE
.text
.globl _start
_start:
	nop #eax - n, ebx  - n-1, ecx - n-2
	movl $1, %eax
	movl $1, %ebx

	movl $3, %edi
loop:
	nop
	call fibo
	dec %edi
	jnz loop

stackF:
	nop
	movl $1, %eax
	movl $1, %ebx
	movl $3, %edi
stack_loop:
	pushq %rax
	pushq %rbx
	call stackFibo
	dec %edi
	jnz stack_loop

recF:
	nop
	movl $1, %eax
	movl $1, %ebx
	movl $3, %edi
	call recFibo
exit:
	nop
	movl $EXIT , %EAX
	int $SYSCALL32

.type fibo, @function
fibo:
	movl %eax, %ecx
	add %ebx, %eax #wynik w eax
	movl %ecx, %ebx
	ret

.type stackFibo, @function
stackFibo:
	pushq %rbp
	movq %rsp, %rbp

	movl 16(%rbp), %edx
	movl 24(%rbp), %ecx
	add %ecx, %edx
	movl 24(%rbp), %ebx
	movl %edx, %eax

	movq %rbp, %rsp
	popq %rbp
	ret

.type recFibo, @function
recFibo:
	movl %eax, %ecx
	add %ebx, %eax
	movl %ecx, %ebx
	dec %edi
	jz nc
	call recFibo
nc:	ret
