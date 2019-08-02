#include <stdio.h>

extern int pow_and_div_fct();
void main(){
	int arg = 4;
	int result = pow_and_div_fct(arg);
	printf("wynik: %d \n", result);
}
