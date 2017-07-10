// Standard library function
#include <cstdio>
#include <stdlib>

#include <pthread.h>
#include <stdbool.h>
#include <stdint.h>
#include <set>
// is a big int required to hanndle the cycle count and the time since execution start ?

// use SSE simd instructions for diff caompariosns over the entire range

// Global Variables
std::string EXIT_CAUSE ;
uint16_t verbosity = 5;

FILE* CFG1 = NULL;
FILE* CFG2 = NULL;

// helper fuction ceclaritions 

// query value

// add update(pool vector)

// user defined Design Rule Check (DRC) 
	// a DRC function pointer 
	// A count of total declared DRC`s
	// a Template DRC // eg a privillage mode violation :P
	// a DRC run Wrapper
	// and failure handling 

int main(int argc, char const *argv[])
{
	if (argc <=2) {
		EXIT_CAUSE = "Not Enough Arguments" ; 
		exit();
		}
	argc = argc -2 ;
	uint16_t parsed =0;
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

	// make this a seperate utility to help the user configure the min list ext :P

	// call a helper function tha t parses the file once and extracts a list of all declared registers and memory resources
	// take a set intersection and intimate the user that this is the list of availabe signals to diff on
	// take the set union and intimate the user that tha tuch s[ace was goint to be alocated to keep track of all the variables

	// allocate space for the everything -- because not cared for locations can be different because they are 
	// create a pool vector for teach of the memory files in the minlist 
	// parse the sensitivvity list and now enable the updaete methods
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
		// trigger barrier sync only after bboth units have sent their end of updates commands
		// maintain a diff vector and update diffs only 
		// barrier sync 

	return 0;
}	


	// handle exits i.e. define the atexit function triggered 
	
	void atexit()