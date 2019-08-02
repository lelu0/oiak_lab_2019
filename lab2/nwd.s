
SYSCALL32 = 0x80 # sysfun: nr funkcji w %eax, parametry: %ebx, %ecx, %edx
EXIT = 1 #nr funkcji restartu (=1) – zwrot sterowania do s.o.
STDIN = 0 # nr wejścia standardowego (klawiatura) do %ebx
READ = 3 # nr funkcji odczytu wejścia (=3)
STDOUT = 1 # nr wyjścia standardowego (ekran tekstowy) do %ebx
WRITE = 4 # nr funkcji wyjścia (=4)
BUF_SIZE = 254 # rozmiar bufora (w bajtach/znakach ASCII) – max 254

.data

.text
.globl _start
_start:
	nop #liczba a w ebx, b w ecx
	movl $100, %ebx
	movl $16, %ecx
loop:
	call nwd
	cmp $0,  %edx
	jne loop


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

.type nwd, @function
nwd:
	movl %ebx, %eax
	movl $0, %edx
	div %ecx
	cmp $0, %edx
	je retf #obliczone
	movl %ecx, %ebx #przypisujemy liczbie a liczbe b
	movl %edx, %ecx #reszte przypisujemy liczbie b
retf:
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
