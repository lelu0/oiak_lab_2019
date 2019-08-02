
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

dividend: .int 100
divisor: .int 25
quotient: .int 0
remainder: .int 0


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

dziel:
	nop
	movl $0, %edx
	movl $100, %eax
	movl $25, %ecx
	div %ecx

	movl $2, %ecx
	div %ecx

	movl $4, %ecx
	div %ecx

b2:
	nop
	movl $1, %edx
	movl $0, %eax
	movl $10000, %ecx
	div %ecx

sign:
	nop
	movl $20, %edx
	movl $0, %eax
	movl $21, %ecx
	div %ecx
	
	

	#WYPISANIE NA EKRAN
	movl $WRITE, %eax
	movl $STDOUT, %ebx
	movl $BUF, %ecx
	movl TEXT_SIZE, %edx
	int $SYSCALL32

	#WYJSCIE 
	movl $EXIT , %EAX
	int $SYSCALL32
