#include <stdio.h>

extern int fact();

void main(){
	int n = 3;
	int result = fact(n);
	printf("Silnia liczby %d wynosi %d \n", n, result);
}
