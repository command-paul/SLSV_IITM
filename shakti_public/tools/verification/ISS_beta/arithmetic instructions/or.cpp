//Program for OR opcode
//AND, OR, and XOR perform bitwise logical operations.
#include <stdio.h>

void Or(int rd, int rs1, int rs2)
{
	int i = 0;
	if(rd!=0)
	{
	for(i=0; i<64; i++)
	{
		Rreg[rd][i] = bit_or(Rreg[rs2][i],Rreg[rs1][i]);
	}
	}
	std::cout << "OR TAKEN\n";
	/*printf("Or\n");
	printreg(rs1);
	printreg(rs2);
	printreg(rd);*/
}
