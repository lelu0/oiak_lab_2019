#include <stdio.h>

void powerfunc(int digit){
	 digit = digit * digit;
         printf("Potega to: %d \n", digit);
}

void printfunc(int digit, int mult){
	digit = digit * digit;
	int result = mult * digit;
	printf("Potega to: %d \n", digit);
	printf("Mnozenie dalo: %d \n", result);
}
