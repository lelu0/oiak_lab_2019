
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
MASK: .int 32 #maska 100000
SHIFT: .int 3
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
loop:
	movb BUF(%edi), %al
	movb $'\n', %cl
	cmp %al, %cl #nie zmieniamy konca lini
	je write

	cmp $65, %al
	jb end_cond
	cmp $122, %al
	jg end_cond


	movb MASK, %cl
	orb %cl, %al #zamien na mala litere
	movb SHIFT, %cl
	add %al, %cl #szyfruj


move:
	movb %cl, BUF(%edi)

	#WARUNEK WYJSCIA Z PETLI
end_cond:
	inc %edi
	cmp %edi, TEXT_SIZE
	je write
	jmp loop

write:
	movl $WRITE, %eax
	movl $STDOUT, %ebx
	movl $BUF, %ecx
	movl TEXT_SIZE, %edx
	int $SYSCALL32

out:
	movl $EXIT , %EAX
	int $SYSCALL32
