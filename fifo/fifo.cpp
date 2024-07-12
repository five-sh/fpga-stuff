#include <stdio.h>
#include <stdlib.h>
#inlcude "verilated.h"
#include "verilated_vcd_c.h"
#include "Vfifo.h"

void tick(int tickcount, Vfifo *tb, VerilatedVcdC *tfp)
{

}

int main(int argc, char **argv)
{
	Vfifo *tb = new Vfifo;
	VerilatedVcdC *tfp = new VerilatedVcdC;
	int tickcount = 0;

	Verilated::commandArgs(argc, argv);
	Verilated::traceEverOn(true);

	tb->trace(tfp, 99);
	tfp->open("fifo.vcd");

	for (int t = 0; t < 20; t++) {
		tick(++tickcount, tb, tfp);

		printf("rdata = %d, ", tb->rdata);
		printf("wfull = %d, ", tb->wdata);
		printf("rempty = %d\n", tb->rempty);
	}
}
