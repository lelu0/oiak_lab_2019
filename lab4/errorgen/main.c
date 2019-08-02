#include <stdio.h>
#include <stdlib.h>
extern int check_bit_status();
extern int div_z();
extern void ov();
extern void set_control_fct();
void checkStatus(){
	const char * coms[] = {
	"0 - Invalid operation exception \n",
	"1 - Denormal operand exception \n",
	"2 - Zero divide exception  \n",
	"3 - Overflow exception  \n",
	"4 - Underflow exception  \n",
	"5 - Precision exception  \n",
	"6 - Stack fault  \n",
	"7 - Error summary status  \n",
	"  \n",
	"  \n",
	"  \n",
	"  \n",
	"  \n",
	"  \n",
	"  \n",
	"15 - FPU busy  \n"
	};

	const int codes[] = {1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192,16384,32768};
	int status;


	for(int i = 0; i < 16; i++){
		status = check_bit_status(codes[i]);
		if(status == 1)
			printf("%s", coms[i]);
	}
}

void main(){
	set_control_fct();
	//div_z();
	ov();
	//checkStatus();
}
