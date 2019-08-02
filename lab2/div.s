
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
	nop
	movl $0, %edx
	movl $100, %eax
	movl $25, %ecx
	div %ecx #4 w eax

m1:
	nop
	movl $4, %ebx
	mul %ebx #16 w eax

d2:
	nop
	movl $2, %ecx
	idiv %ecx #8
	div %ecx #4
m2:
	nop
	mov $-4, %bx
	movsx %bx, %ecx
	imul %ecx #-16

d3:
	nop
	mov $-2, %bx
	movsx %bx, %ecx
	idiv %ecx #8 przy movsx, 0 movzx

zakres:
	nop
	movl $2, %eax
	movl $-2, %ecx
	mul %ecx
	mul %ecx

	imul %ecx
	imul %ecx #wynik 32 w eax

	movl $9999999, %ecx
	mul %ecx
	mul %ecx
	mul %ecx
	movq %rax, %rcx
	imul %rcx

exit: 
	movl $EXIT , %EAX
	int $SYSCALL32


