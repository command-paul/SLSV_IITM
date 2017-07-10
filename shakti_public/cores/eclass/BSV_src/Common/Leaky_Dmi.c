//Leaky_Dmi.c
// Function Definitions for the leaky dmi interface 
FILE * Input;
FILE * Output;

char initInterface(){
	char * InPath = secure_getenv("INPATH");
	char * OutPath = secure_getenv("OUTPATH");
	Input = fopen(InPath , "r");
	Output = fopen(OutPath ,"w");
	if ((Input == NULL) || (Output == NULL)) return 0;
	return 1;
}

unsigned long long int getCommand(){
	char InFrame;
	unsigned long long int InWord;
	while(fread(Input,"%c",&InFrame)!=1); // wait
	if((InFrame>>7)&1)while(fread(&InWord,sizeof(char),3,Input)!=3);
	else InWord = 0;
	return (InWord + ((unsigned long long int)InFrame << 32));
}

// void sendResponse(unsigned int Word){
// 	fprintf(Output,"%u",Word);
// 	return;
// }