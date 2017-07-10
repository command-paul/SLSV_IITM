
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

//Leaky_Dmi.c
// Function Definitions for the leaky dmi interface 
FILE * Input;
FILE * Output;


char initInterface(){
	char * TO_HOST   = getenv("INPATH");
	char * FROM_HOST = getenv("OUTPATH");
	Output = fopen(TO_HOST ,"w");
	Input = fopen(FROM_HOST , "r");
	if ((Input == NULL) || (Output == NULL)) return 0;
	return 1;
}

unsigned long long int getCommand(){
	uint8_t InFrame = 0;
	unsigned long long int InWord = 0;
	while(fread(&InFrame,sizeof(char),1,Input)!= 1); // wait
	if(InFrame/(1<<7) == 1)while(fread(&InWord,sizeof(unsigned int),1,Input)!=1);
	else InWord = 0;
	InWord += (unsigned long long int) InFrame<<32;
	return (InWord);
}


void sendResponse(uint32_t Word){
	//Word &=  FFFFFFFF;
	//serialise the request
	fwrite(&Word,sizeof(char),4,Output);
	fflush(Output);
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

