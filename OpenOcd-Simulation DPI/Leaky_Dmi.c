
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

//Leaky_Dmi.c
// Function Definitions for the leaky dmi interface 
FILE * Input;
FILE * Output;

int Module_enable =0;

void initInterface(){
	char * TO_HOST   = getenv("INPATH");
	char * FROM_HOST = getenv("OUTPATH");
	if((TO_HOST==NULL) ||(FROM_HOST==NULL)){
		printf(">>>> \x1B[31m DTM NOT Enabled ! Please set $INPATH & $OUTPATH \x1B[0m \n");
		return;
	}
	Module_enable = 1;
	Output = fopen(TO_HOST ,"w");
	Input = fopen(FROM_HOST , "r");
	if ((Input == NULL) || (Output == NULL)) printf("BAD Pipes :( \n");
	return;
}

unsigned long long int getCommand(){
	uint8_t InFrame = 0;
	unsigned long long int InWord = 0;
	if(Module_enable == 0){
		printf(">>>> \x1B[31m DTM NOT Enabled ! Please set $INPATH & $OUTPATH \x1B[0m \n");
		InFrame = 1<<7;
		InWord = 0;
		InWord += (unsigned long long int) InFrame<<32;
		return (InWord);
	}
	// printf("JELLO WORLD \n");
	if(fread(&InFrame,sizeof(char),1,Input)==1){
		if(InFrame/(1<<7) == 1)while(fread(&InWord,sizeof(unsigned int),1,Input)!=1);
		else InWord = 0;
		InWord += (unsigned long long int) InFrame<<32;
		}
	else{
		InFrame = 1<<7;
		InWord = 0;
		InWord += (unsigned long long int) InFrame<<32;
	}
	// printf("Command : %llu\n",InWord );
	return (InWord);
}


void sendResponse(uint32_t Word){
	//Word &=  FFFFFFFF;
	//serialise the request
	fwrite(&Word,sizeof(char),4,Output);
	fflush(Output);
	// printf("Response :: >>>>>>>>>>>>>>>>>>>>>>>>>>%u\n",Word);
	return;
}

// char main(){
// 	while(1){
// 		uint64_t FRAME = getCommand(); 
// 		printf("%lx\n", FRAME);
// 		if((FRAME/0x0000008000000000) == 0) sendResponse(0xF0F0FFFE);
// 		}
// 	return 1;
// }

