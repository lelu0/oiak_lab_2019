#include <stdio.h>
#include <stdlib.h>
extern int set_control_fct();
void main(){
	const char * masks[] = {
	"0 - Invalid operation exception mask \n",
	"1 - Denormal operand exception mask \n",
	"2 - Zero divide exception mask \n",
	"3 - Overflow exception mask \n",
	"4 - Underflow exception mask \n",
	"5 - Precision exception mask \n"
	};
	int precision, rounding;

	printf("Wybierz precyzje: \n 0- single \n 2- double \n 3- double-extended \n");
	scanf("%d", &precision);
	printf("Wybierz tryp zaokraglania: \n 0- to nearest \n 1- down \n 2- up \n 3-toward zero \n");
        scanf("%d", &rounding);

	set_control_fct(precision, rounding);

}
