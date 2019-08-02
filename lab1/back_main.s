
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
texttemp: .space BUF_SIZE
TEXT_SIZE: .long 0
BUF: .space BUF_SIZE

.text
.globl _start
_start:
	nop
	#CZYTAJ Z KLAWIATURY	
	movl $BUF_SIZE, %edx
	movl $BUF, %ecx
	movl $STDIN, %ebx
	movl $READ, %eax
	int $SYSCALL32
	movl %eax, TEXT_SIZE

	movl $0, %edi
	movl BUF(,%edi,1), %eax
	movl %eax, texttemp

	movl TEXT_SIZE, %edi
	dec %edi
loop:
	movl $WRITE, %eax
	movl $STDOUT, %ebx
	movl $texttemp, %ecx
	movl $1, %edx
	int $SYSCALL32
	dec %edi
	jz out
	jmp loop 
out:
	movl $EXIT , %EAX
	int $SYSCALL32
