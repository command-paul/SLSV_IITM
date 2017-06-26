0#include <cstdio.h>
#include <cstdlib.h>
#include <vector>
#include <bitset>
#include <string>
#include <stdbool.h>
#include <pthread.h>


typedef struct Reg_t{
	unsigned long long int type,
	unsigned long long int core,
	unsigned long long int range,
	std::vector<bool> Register_file;
}Reg_t;

class SLSV_Instance{
// This is a collection of interface variables to the main SLSV module
public:
	bool initialise(unsigned long long int coires,
					unsigned long long int memory,
					unsigned long long int start_pc,
					 );
	bool read_reg(unsigned long long int type,
				  unsigned long long int core,
				  unsigned long long int address,
				  );
	bool write_reg(unsigned long long int type,
				   unsigned long long int core,
				   unsigned long long int address,
				   unsigned long long int value);
	bool list_reg();
	bool step(unsigned long long int steps);
	bool step_instructions(/*opcode,*/,unsigned long long int steps);
	bool exit();
	bool cpuid();
	bool checkpoint(FILE* CKPT);
	bool restore(FILE* CKPT);

private:
	FILE* Input_DUT;
	FILE* Input_ISA_SIM;
	FILE* RPC_DUT;
	FILE* RPC_ISA_SIM;
	FILE* CHECKPOINT;
	pthread_barrierattr_t attr;
	pthread_barrier_t barrier;
	// Container for Variable interest
	std::vector<Reg_t> File_cabinet;
	std::string CPUID ;
	};
