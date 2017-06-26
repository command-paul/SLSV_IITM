// Standard library function
#include <cstdio>
#include <stdlib>

#include <pthread.h>
#include <stdbool.h>
#include <stdint.h>

// is a big int required to hanndle the cycle count and the time since execution start ?

// Global Variables
std::string EXIT_CAUSE ;
uint16_t verbosity = 5;

FILE* CFG1 = NULL;
FILE* CFG2 = NULL;

// helper fuction ceclaritions 



int main(int argc, char const *argv[])
{
	if (argc <=2) {
		EXIT_CAUSE = "Not Enough Arguments" ; 
		exit();
		}
	argc = argc -2 ;
	uint16_t parsed =0 ;
	while(argc >=1){
		/// parse instruction
		// options come in with option flags 
		// -a <path to self configuration file>
		// -b <Path to Bin 1> <Path to Bin 2>
		// -bc <path to sim1 conf> <path to sim 2 conf>
		// -c <Number of cores>
		// -m <memory in MB>
		// -spc <RAM Start Address in HEX>
		// -h <prints this help message>
		// -v <Verbosity in range 1-5>
		// -d // open the system up like the spike debug working like how spike worked 
			  // this additionally shows all values for an appropriately set up core 
			  // interfaced on the other end . only allows value queries 
			  // supported instructions run // run toll return ( some function return 
			  // statement occured in the opcode) // run n steps // or run till n returns
			  // run until some data reached some value of interest -- the value must be 
			  // in the must be in the configuration list of the processors
		}
	if (verbosity == 5) printf("input parsed :: %d options parsed ", parsed);
	// configutation stage before staring the modules



	// find the min list of the signals and malloc the area required for 
		//storing all the signals

	// start both modules

	// pass configuration instructions to the isntantiated child processes

	// start the pool 

	// Barrier sync 1

	// LOOP :: 
		// send appropriate command
		// parse inputs and appropriately put into the update pool
		// exceptions are printed since we are in min dev mode
		// if error break and notify user
		// compute appropriate command		
		// barrier sync 

	return 0;
}	

	// handle exits i.e. define the atexit function triggered 

	void atexit()