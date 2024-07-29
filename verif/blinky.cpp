#include <stdio.h>
#include <stdlib.h>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vblinky.h"

void tick(int tickcount, Vblinky *tb, VerilatedVcdC *tfp)
{
	tb->eval();
	if (tfp)
		tfp->dump(tickcount * 10 - 2); // dump 2ns before tick

	tb->i_clk = 1;
	tb->eval();
	if (tfp)
		tfp->dump(tickcount * 10); // tick every 10ns

	tb->i_clk = 0;
	tb->eval();
	if (tfp) {
		tfp->dump(tickcount * 10 + 5);
		tfp->flush();
	}
}

int main(int argc, char **argv)
{
	Vblinky *tb = new Vblinky;
	VerilatedVcdC *tfp = new VerilatedVcdC;
	int tickcount = 0;
	int last_led;

	Verilated::commandArgs(argc, argv);
	Verilated::traceEverOn(true);

	tb->trace(tfp, 99);
	tfp->open("blinky.vcd");

	last_led = tb->o_led;
	for (int t = 0; t < (1 << 20); t++) {
		tick(++tickcount, tb, tfp);

		if (last_led != tb->o_led) {
			printf("t = %d, ", t);
			printf("led = %d\n", tb->o_led);
		}
		last_led = tb->o_led;
	}

	return 0;
}
