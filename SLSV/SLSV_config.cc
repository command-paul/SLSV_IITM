// SLSV_CONFIG
// thisn file is the configuration utility for the slsv register file definition format


// Methoods for SLSF configurations
	// parse file for register definition and create two bit sets	
	// should be more like parse device tree string and appropriately compute the list
	// compute the union of both the bit sets and provide a template interest list to the user


// SLSV Common Sensitivity list generator
#include <cstdio>
#include <cstdlib>
#include <string>
#include <set>
#include <stdbool.h>

// structure that handles enumeration of 

// csr defs in Variable
// extra regs is Variable
// mem mapped registers is Variable

// Global Variables
FILE* I1;
FILE* I2;
FILE* OF;


bool parse_line(char* str){
	return false;
	}

int main(int argc, char const *argv[]){
	if (argc <3) {
		printf("Insufficient Arguments :: usage format \n ./SLSV_config <path to configuration file1 .dd> <path to configuration file2 .dd> <path to output file .sl>" );
		}
	if((I1 = fopen(argv[1],"r"))==NULL) printf("Path to input 1 Not Valid\n");
	if((I2 = fopen(argv[2],"r"))==NULL) printf("Path to input 2 Not Valid\n");
	if((OF = fopen(argv[3],"w"))==NULL) printf("Error Creating Output file\n");
	char* Line = (char*)malloc(sizeof(char)*256);//[256] = {0};
	size_t len = 256;
	while(!feof(I1)){
		getline((&Line),&len,I1);
		if(!parse_line(Line)){
			fprintf(stderr,"Invalid Statement :: %s",Line);
		}
	}
	while(!feof(I2)){
		getline((&Line),&len,I2);
		if(!parse_line(Line)){
			fprintf(stderr,"Invalid Statement :: %s",Line);
		}
	}
	// take the intersection of the sets


	// generate sensitivity list and elaborate and print 
	return 0;
	}
