#include "var_track.h"
#include "sim.h"
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

// int Read_list_file(std::string Path);
// bool Add_var(std::string Line);
// void Print_In_Order();

var_track Single_Core_Track;

bool var_track::careM(unsigned long long int addr){
	if(Memory.size()==0) return true;
	else if(std::find(Memory.begin(), Memory.end(), addr) != Memory.end()) return true;
	return false;
}

bool var_track::careC(unsigned long long int addr){
	if((addr<4096) && (CS_reg[addr]==1)) return true;
	return false;
}

bool var_track::careX(unsigned long long int addr){
	if((addr<32) && (X_reg[addr]==1)) return true;
	return false;
}

bool var_track::careF(unsigned long long int addr){
	if((addr<32) && (F_reg[addr]==1)) return true;
	return false;
}

bool var_track::careP(unsigned long long int addr){
	return (addr) ? show_Opcode : show_PC ;
}

var_track::var_track(){

}

void var_track::Clear(){
	show_PC = false;
	show_Opcode = false;
	X_reg.reset();
	F_reg.reset();
	CS_reg.reset();
	Memory.clear();
	return;
	}

void var_track::initialise_Spike_def(){ // please ensure the spike_trace.cfg file is in your $RISCV folder
	// redefine this to read the default config file since the user do what he wants
	Clear();
	char * RISCV = getenv("RISCV");
	if(RISCV == NULL) {
		fprintf(stderr , " ENV Variable $RISCV not defined , please ensure spike_trace.cfg is at $RISCV\n");
		fprintf(stderr , " Variable list empty \n");
		return;		
	}
	std::string defPath (RISCV);
	defPath+= "/spike_trace.cfg" ;
	Read_list_file(defPath);
	Print_dump(stderr);
	return;
	}



void var_track::Print_dump(FILE* Destination){
	for(unsigned int i =0 ; i < Signals.size(); i++){
		switch(Signals[i].first){
			case('P'):{
				fprintf(Destination,"> %c,%llu\n",Signals[i].first,Signals[i].second);
				break;
				}
			case('X'):{
				fprintf(Destination,"> %c,%llu\n",Signals[i].first,Signals[i].second);
				break;
				}
			case('F'):{
				fprintf(Destination,"> %c,%llu\n",Signals[i].first,Signals[i].second);
				break;
				}
			case('C'):{
				fprintf(Destination,"> %c,%llu\n",Signals[i].first,Signals[i].second);
				break;
				}
			case('M'):{
				fprintf(Destination,"> %c,%llu\n",Signals[i].first,Signals[i].second);
				break;
				}
			}
		}
	}

// int main(int argc, char const *argv[]){
// 	/* code */
// 	std::string lop ("sublist");
// 	Clear();
// 	//Read_list_file(lop);
// 	initialise_Spike_def();
// 	Print_dump(stdout);
// 	return 0;
// 	}

int var_track::Read_list_file(std::string Path ){
	//fstream  INPUT;
	//INPUT.open(Path.c_str(), ios::in )
	FILE * INPUT ;

	INPUT = fopen(Path.c_str(),"r");
	//INPUT = fopen("$RISCV/spike_trace.cfg","r");
	//INPUT = fopen("/home/local_install/RISCV_Tools/riscv-tools/riscv/spike_trace.cfg","r");
	//system("cat $RISCV/spike_trace.cfg");
	
	if(INPUT==NULL) return -1;
	std::string line;
	while(!feof(INPUT)){
	  	char ch = '0';
	  	line.clear();
	  	while ((ch != '\n') && (line.length() < 200)) {
	  		ch = getc(INPUT);
	    	if (ch == -1 )break;
	    	if (ch != '\n') line += ch;
  			}
		Add_var(line);
		}
	return 0;
	}

bool var_track::Add_var(std::string Line){
	switch(Line[0]){
		case('P'):{
			if(Line.compare(0,2,"PC")==0){ 
				show_PC = 1;			//change this to match some convention
				if(std::find(Signals.begin(), Signals.end(), std::make_pair('P',(unsigned long long int)0)) == Signals.end()) Signals.push_back(std::make_pair('P',0));
				}
			else if(Line.compare(0,7,"POPCODE")==0){
				show_Opcode = 1;	//Hack
				if(std::find(Signals.begin(), Signals.end(), std::make_pair('P',(unsigned long long int)1)) == Signals.end()) Signals.push_back(std::make_pair('P',1));	
			}
			else goto MISMATCH ; 
			break;
			}
		case('X'):{
			unsigned long long int reg_no = 0;
			if (Line[1]=='*'){ // a simple hack to add all registers
				X_reg = 0xFFFFFFFF;
				for(unsigned long long int ctr =0 ; ctr <32 ; ctr ++){
					if(std::find(Signals.begin(), Signals.end(), std::make_pair('X',ctr)) == Signals.end()) Signals.push_back(std::make_pair('X',ctr));
					}
				}
			else if((sscanf(Line.c_str(),"X%llu",&reg_no))&&(reg_no < 32)) {
				X_reg[reg_no] = 1;
				if(std::find(Signals.begin(), Signals.end(), std::make_pair('X',reg_no)) == Signals.end()) Signals.push_back(std::make_pair('X',reg_no));	
				}
			else goto MISMATCH ; 
			break;
			}
		case('F'):{
			unsigned long long int reg_no = 0;
			if (Line[1]=='*'){ // a simple hack to add all registers
				F_reg = 0xFFFFFFFF;
				for(unsigned long long int ctr =0 ; ctr <32 ; ctr ++){
					if(std::find(Signals.begin(), Signals.end(), std::make_pair('F',ctr)) == Signals.end()) Signals.push_back(std::make_pair('F',ctr));
					}
				}
			else if((sscanf(Line.c_str(),"F%llu",&reg_no))&&(reg_no < 32)) {
				F_reg[reg_no] = 1;
				if(std::find(Signals.begin(), Signals.end(), std::make_pair('F',reg_no)) == Signals.end()) Signals.push_back(std::make_pair('F',reg_no));	
				}
			else goto MISMATCH ; 
			break;
			}
		case('C'):{
			//Check Mapping and resolve if fail go by reg addr
			unsigned long long int reg_no = decode_reg_no(Line);
			if (reg_no){
				CS_reg[reg_no] = 1;
				if(std::find(Signals.begin(), Signals.end(), std::make_pair('C',reg_no)) == Signals.end()) Signals.push_back(std::make_pair('C',reg_no));	
				//printf("ok\n");
				}
			else if((sscanf(Line.c_str(),"CSR%llu",&reg_no)==1) && (reg_no < 4096)){
				CS_reg[reg_no] = 1;
				if(std::find(Signals.begin(), Signals.end(), std::make_pair('C',reg_no)) == Signals.end()) Signals.push_back(std::make_pair('C',reg_no));	
				}
			else goto MISMATCH ; 
			break;
			}
		case('M'):{
			unsigned long long int addr = 0;
			if((sscanf(Line.c_str(),"M0x%llx",&addr)==1)&&(addr < ((unsigned long long int)2048<<20))) {
				//FIXME In the range limiting statement please update to the runtime memory val and not the default value
				Memory.push_back(addr);
				if(std::find(Signals.begin(), Signals.end(), std::make_pair('M',addr)) == Signals.end()) Signals.push_back(std::make_pair('M',addr));	
				}
			else goto MISMATCH; 
			//printf("ADDR == %llx\n",addr); //Debug 
			break;
			}
		default:{ // nosyntax match skip line
		MISMATCH:// I apologized to all the worlds gods before I added this goto end point.
			fprintf(stderr,"SKP Line :: %s NOT Recognized or Index beyond range\n",Line.c_str() );
			break;
			}
		}
	return true;
	}

int var_track::decode_reg_no( std::string name){
	std::map <std::string , int > decode;
		decode["CSR_FFLAGS"] = 0x1;
		decode["CSR_FRM"] = 0x2;
		decode["CSR_FCSR"] = 0x3;
		decode["CSR_CYCLE"] = 0xc00;
		decode["CSR_TIME"] = 0xc01;
		decode["CSR_INSTRET"] = 0xc02;
		decode["CSR_HPMCOUNTER3"] = 0xc03;
		decode["CSR_HPMCOUNTER4"] = 0xc04;
		decode["CSR_HPMCOUNTER5"] = 0xc05;
		decode["CSR_HPMCOUNTER6"] = 0xc06;
		decode["CSR_HPMCOUNTER7"] = 0xc07;
		decode["CSR_HPMCOUNTER8"] = 0xc08;
		decode["CSR_HPMCOUNTER9"] = 0xc09;
		decode["CSR_HPMCOUNTER10"] = 0xc0a;
		decode["CSR_HPMCOUNTER11"] = 0xc0b;
		decode["CSR_HPMCOUNTER12"] = 0xc0c;
		decode["CSR_HPMCOUNTER13"] = 0xc0d;
		decode["CSR_HPMCOUNTER14"] = 0xc0e;
		decode["CSR_HPMCOUNTER15"] = 0xc0f;
		decode["CSR_HPMCOUNTER16"] = 0xc10;
		decode["CSR_HPMCOUNTER17"] = 0xc11;
		decode["CSR_HPMCOUNTER18"] = 0xc12;
		decode["CSR_HPMCOUNTER19"] = 0xc13;
		decode["CSR_HPMCOUNTER20"] = 0xc14;
		decode["CSR_HPMCOUNTER21"] = 0xc15;
		decode["CSR_HPMCOUNTER22"] = 0xc16;
		decode["CSR_HPMCOUNTER23"] = 0xc17;
		decode["CSR_HPMCOUNTER24"] = 0xc18;
		decode["CSR_HPMCOUNTER25"] = 0xc19;
		decode["CSR_HPMCOUNTER26"] = 0xc1a;
		decode["CSR_HPMCOUNTER27"] = 0xc1b;
		decode["CSR_HPMCOUNTER28"] = 0xc1c;
		decode["CSR_HPMCOUNTER29"] = 0xc1d;
		decode["CSR_HPMCOUNTER30"] = 0xc1e;
		decode["CSR_HPMCOUNTER31"] = 0xc1f;
		decode["CSR_SSTATUS"] = 0x100;
		decode["CSR_SIE"] = 0x104;
		decode["CSR_STVEC"] = 0x105;
		decode["CSR_SCOUNTEREN"] = 0x106;
		decode["CSR_SSCRATCH"] = 0x140;
		decode["CSR_SEPC"] = 0x141;
		decode["CSR_SCAUSE"] = 0x142;
		decode["CSR_SBADADDR"] = 0x143;
		decode["CSR_SIP"] = 0x144;
		decode["CSR_SPTBR"] = 0x180;
		decode["CSR_MSTATUS"] = 0x300;
		decode["CSR_MISA"] = 0x301;
		decode["CSR_MEDELEG"] = 0x302;
		decode["CSR_MIDELEG"] = 0x303;
		decode["CSR_MIE"] = 0x304;
		decode["CSR_MTVEC"] = 0x305;
		decode["CSR_MCOUNTEREN"] = 0x306;
		decode["CSR_MSCRATCH"] = 0x340;
		decode["CSR_MEPC"] = 0x341;
		decode["CSR_MCAUSE"] = 0x342;
		decode["CSR_MBADADDR"] = 0x343;
		decode["CSR_MIP"] = 0x344;
		decode["CSR_PMPCFG0"] = 0x3a0;
		decode["CSR_PMPCFG1"] = 0x3a1;
		decode["CSR_PMPCFG2"] = 0x3a2;
		decode["CSR_PMPCFG3"] = 0x3a3;
		decode["CSR_PMPADDR0"] = 0x3b0;
		decode["CSR_PMPADDR1"] = 0x3b1;
		decode["CSR_PMPADDR2"] = 0x3b2;
		decode["CSR_PMPADDR3"] = 0x3b3;
		decode["CSR_PMPADDR4"] = 0x3b4;
		decode["CSR_PMPADDR5"] = 0x3b5;
		decode["CSR_PMPADDR6"] = 0x3b6;
		decode["CSR_PMPADDR7"] = 0x3b7;
		decode["CSR_PMPADDR8"] = 0x3b8;
		decode["CSR_PMPADDR9"] = 0x3b9;
		decode["CSR_PMPADDR10"] = 0x3ba;
		decode["CSR_PMPADDR11"] = 0x3bb;
		decode["CSR_PMPADDR12"] = 0x3bc;
		decode["CSR_PMPADDR13"] = 0x3bd;
		decode["CSR_PMPADDR14"] = 0x3be;
		decode["CSR_PMPADDR15"] = 0x3bf;
		decode["CSR_TSELECT"] = 0x7a0;
		decode["CSR_TDATA1"] = 0x7a1;
		decode["CSR_TDATA2"] = 0x7a2;
		decode["CSR_TDATA3"] = 0x7a3;
		decode["CSR_DCSR"] = 0x7b0;
		decode["CSR_DPC"] = 0x7b1;
		decode["CSR_DSCRATCH"] = 0x7b2;
		decode["CSR_MCYCLE"] = 0xb00;
		decode["CSR_MINSTRET"] = 0xb02;
		decode["CSR_MHPMCOUNTER3"] = 0xb03;
		decode["CSR_MHPMCOUNTER4"] = 0xb04;
		decode["CSR_MHPMCOUNTER5"] = 0xb05;
		decode["CSR_MHPMCOUNTER6"] = 0xb06;
		decode["CSR_MHPMCOUNTER7"] = 0xb07;
		decode["CSR_MHPMCOUNTER8"] = 0xb08;
		decode["CSR_MHPMCOUNTER9"] = 0xb09;
		decode["CSR_MHPMCOUNTER10"] = 0xb0a;
		decode["CSR_MHPMCOUNTER11"] = 0xb0b;
		decode["CSR_MHPMCOUNTER12"] = 0xb0c;
		decode["CSR_MHPMCOUNTER13"] = 0xb0d;
		decode["CSR_MHPMCOUNTER14"] = 0xb0e;
		decode["CSR_MHPMCOUNTER15"] = 0xb0f;
		decode["CSR_MHPMCOUNTER16"] = 0xb10;
		decode["CSR_MHPMCOUNTER17"] = 0xb11;
		decode["CSR_MHPMCOUNTER18"] = 0xb12;
		decode["CSR_MHPMCOUNTER19"] = 0xb13;
		decode["CSR_MHPMCOUNTER20"] = 0xb14;
		decode["CSR_MHPMCOUNTER21"] = 0xb15;
		decode["CSR_MHPMCOUNTER22"] = 0xb16;
		decode["CSR_MHPMCOUNTER23"] = 0xb17;
		decode["CSR_MHPMCOUNTER24"] = 0xb18;
		decode["CSR_MHPMCOUNTER25"] = 0xb19;
		decode["CSR_MHPMCOUNTER26"] = 0xb1a;
		decode["CSR_MHPMCOUNTER27"] = 0xb1b;
		decode["CSR_MHPMCOUNTER28"] = 0xb1c;
		decode["CSR_MHPMCOUNTER29"] = 0xb1d;
		decode["CSR_MHPMCOUNTER30"] = 0xb1e;
		decode["CSR_MHPMCOUNTER31"] = 0xb1f;
		decode["CSR_MHPMEVENT3"] = 0x323;
		decode["CSR_MHPMEVENT4"] = 0x324;
		decode["CSR_MHPMEVENT5"] = 0x325;
		decode["CSR_MHPMEVENT6"] = 0x326;
		decode["CSR_MHPMEVENT7"] = 0x327;
		decode["CSR_MHPMEVENT8"] = 0x328;
		decode["CSR_MHPMEVENT9"] = 0x329;
		decode["CSR_MHPMEVENT10"] = 0x32a;
		decode["CSR_MHPMEVENT11"] = 0x32b;
		decode["CSR_MHPMEVENT12"] = 0x32c;
		decode["CSR_MHPMEVENT13"] = 0x32d;
		decode["CSR_MHPMEVENT14"] = 0x32e;
		decode["CSR_MHPMEVENT15"] = 0x32f;
		decode["CSR_MHPMEVENT16"] = 0x330;
		decode["CSR_MHPMEVENT17"] = 0x331;
		decode["CSR_MHPMEVENT18"] = 0x332;
		decode["CSR_MHPMEVENT19"] = 0x333;
		decode["CSR_MHPMEVENT20"] = 0x334;
		decode["CSR_MHPMEVENT21"] = 0x335;
		decode["CSR_MHPMEVENT22"] = 0x336;
		decode["CSR_MHPMEVENT23"] = 0x337;
		decode["CSR_MHPMEVENT24"] = 0x338;
		decode["CSR_MHPMEVENT25"] = 0x339;
		decode["CSR_MHPMEVENT26"] = 0x33a;
		decode["CSR_MHPMEVENT27"] = 0x33b;
		decode["CSR_MHPMEVENT28"] = 0x33c;
		decode["CSR_MHPMEVENT29"] = 0x33d;
		decode["CSR_MHPMEVENT30"] = 0x33e;
		decode["CSR_MHPMEVENT31"] = 0x33f;
		decode["CSR_MVENDORID"] = 0xf11;
		decode["CSR_MARCHID"] = 0xf12;
		decode["CSR_MIMPID"] = 0xf13;
		decode["CSR_MHARTID"] = 0xf14;
		decode["CSR_CYCLEH"] = 0xc80;
		decode["CSR_TIMEH"] = 0xc81;
		decode["CSR_INSTRETH"] = 0xc82;
		decode["CSR_HPMCOUNTER3H"] = 0xc83;
		decode["CSR_HPMCOUNTER4H"] = 0xc84;
		decode["CSR_HPMCOUNTER5H"] = 0xc85;
		decode["CSR_HPMCOUNTER6H"] = 0xc86;
		decode["CSR_HPMCOUNTER7H"] = 0xc87;
		decode["CSR_HPMCOUNTER8H"] = 0xc88;
		decode["CSR_HPMCOUNTER9H"] = 0xc89;
		decode["CSR_HPMCOUNTER10H"] = 0xc8a;
		decode["CSR_HPMCOUNTER11H"] = 0xc8b;
		decode["CSR_HPMCOUNTER12H"] = 0xc8c;
		decode["CSR_HPMCOUNTER13H"] = 0xc8d;
		decode["CSR_HPMCOUNTER14H"] = 0xc8e;
		decode["CSR_HPMCOUNTER15H"] = 0xc8f;
		decode["CSR_HPMCOUNTER16H"] = 0xc90;
		decode["CSR_HPMCOUNTER17H"] = 0xc91;
		decode["CSR_HPMCOUNTER18H"] = 0xc92;
		decode["CSR_HPMCOUNTER19H"] = 0xc93;
		decode["CSR_HPMCOUNTER20H"] = 0xc94;
		decode["CSR_HPMCOUNTER21H"] = 0xc95;
		decode["CSR_HPMCOUNTER22H"] = 0xc96;
		decode["CSR_HPMCOUNTER23H"] = 0xc97;
		decode["CSR_HPMCOUNTER24H"] = 0xc98;
		decode["CSR_HPMCOUNTER25H"] = 0xc99;
		decode["CSR_HPMCOUNTER26H"] = 0xc9a;
		decode["CSR_HPMCOUNTER27H"] = 0xc9b;
		decode["CSR_HPMCOUNTER28H"] = 0xc9c;
		decode["CSR_HPMCOUNTER29H"] = 0xc9d;
		decode["CSR_HPMCOUNTER30H"] = 0xc9e;
		decode["CSR_HPMCOUNTER31H"] = 0xc9f;
		decode["CSR_MCYCLEH"] = 0xb80;
		decode["CSR_MINSTRETH"] = 0xb82;
		decode["CSR_MHPMCOUNTER3H"] = 0xb83;
		decode["CSR_MHPMCOUNTER4H"] = 0xb84;
		decode["CSR_MHPMCOUNTER5H"] = 0xb85;
		decode["CSR_MHPMCOUNTER6H"] = 0xb86;
		decode["CSR_MHPMCOUNTER7H"] = 0xb87;
		decode["CSR_MHPMCOUNTER8H"] = 0xb88;
		decode["CSR_MHPMCOUNTER9H"] = 0xb89;
		decode["CSR_MHPMCOUNTER10H"] = 0xb8a;
		decode["CSR_MHPMCOUNTER11H"] = 0xb8b;
		decode["CSR_MHPMCOUNTER12H"] = 0xb8c;
		decode["CSR_MHPMCOUNTER13H"] = 0xb8d;
		decode["CSR_MHPMCOUNTER14H"] = 0xb8e;
		decode["CSR_MHPMCOUNTER15H"] = 0xb8f;
		decode["CSR_MHPMCOUNTER16H"] = 0xb90;
		decode["CSR_MHPMCOUNTER17H"] = 0xb91;
		decode["CSR_MHPMCOUNTER18H"] = 0xb92;
		decode["CSR_MHPMCOUNTER19H"] = 0xb93;
		decode["CSR_MHPMCOUNTER20H"] = 0xb94;
		decode["CSR_MHPMCOUNTER21H"] = 0xb95;
		decode["CSR_MHPMCOUNTER22H"] = 0xb96;
		decode["CSR_MHPMCOUNTER23H"] = 0xb97;
		decode["CSR_MHPMCOUNTER24H"] = 0xb98;
		decode["CSR_MHPMCOUNTER25H"] = 0xb99;
		decode["CSR_MHPMCOUNTER26H"] = 0xb9a;
		decode["CSR_MHPMCOUNTER27H"] = 0xb9b;
		decode["CSR_MHPMCOUNTER28H"] = 0xb9c;
		decode["CSR_MHPMCOUNTER29H"] = 0xb9d;
		decode["CSR_MHPMCOUNTER30H"] = 0xb9e;
		decode["CSR_MHPMCOUNTER31H"] = 0xb9f;
		//printf("%s,%d",name.c_str(),decode[name]); //debug :P
	return decode[name];
}