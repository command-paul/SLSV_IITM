#pragma once

//#include "sim.h"
#include <stdbool.h>
#include <cstdlib>
#include <cstdio>
#include <cstdio>
#include <iostream>
#include <stdbool.h>
#include <unistd.h>
#include <fstream>
#include <bitset>
#include <vector>
#include <cstdint>
#include <map>
#include <algorithm>

// this has currently been implemented to handle single core runs of spike only 
// this is work in progress

class var_track{
public:
	var_track();
	bool careM(unsigned long long int addr);
	bool careC(unsigned long long int addr);
	bool careX(unsigned long long int addr);
	bool careF(unsigned long long int addr);
	bool careP(unsigned long long int addr);
	void Clear();
	void initialise_Spike_def();
	void Print_dump(FILE* Destination);
	int Read_list_file(std::string Path );
	bool Add_var(std::string Line);
	int decode_reg_no( std::string name);

private:
	friend class sim_t;
	bool show_PC;
	bool show_Opcode;
	std::bitset <32>   X_reg; // Replace with global Variables
	std::bitset <32>   F_reg; // Replace with global variables
	std::bitset <4096> CS_reg;
	std::vector <unsigned long long int> Memory;
	std::vector <std::pair<char,unsigned long long int>> Signals;
};

// This is a global because (1) :: its not a structural compontnt of the simulator and is merely an interface 
// (2) this is plug and play and will be encapsulated in # define Compile time add remove like the commit log functions but more like an extention on them
extern var_track Single_Core_Track; // UPDATE This to support Spike`s full multicore functionality
