#include <stdio.h>
int delta(int a, int b, int c){
	int ret = 0;
	asm(
	"movl %1, %%eax \n\t"
	"mul %1 \n\t"
	"movl %%eax, %1\n\t"
	"movl %2, %%eax \n\t"
	"movl $4, %%edx \n\t"
	"mul %%edx \n\t"
	"movl %%eax, %2 \n\t"
	"movl %3, %%eax \n\t"
	"mul %2 \n\t"
	"movl %%eax, %3 \n\t"
	"sub %3, %1 \n\t"
	"movl %1, %0 \n\t"
	:"=r"(ret)
	:"r"(a), "r"(b), "r"(c)
	);
	return ret;
}

int main(){
	int a = 12;
	int b = 4;
	int c;

	asm(
	"addl %%ebx, %%eax \n\t"
	"movl %%eax, %%ecx \n\t"

	: "=c"(c)
	: "b" (b), "a" (a)
	);
	//rcx (c) jako argument write only (zwrotny), b i a jako argumenty funkcji w rbx i rax
	printf("suma liczb: %d\n", c);

	//placeholders
	asm(
	"sub %2, %1 \n\t"
	"movl %1, %0 \n\t"
	: "=r" (c)
	: "r" (a), "r" (b)
	); //0 - wartosc zwrotu, argumenty - 1,2... 

	printf("roznica liczb: %d\n", c);

	printf("delta %d \n", delta(5,1,2));
	return 0;
}
