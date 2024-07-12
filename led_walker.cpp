#include <stdio.h>
#include <stdlib.h>
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vled_walker.h"

void tick(int tickcount, Vled_walker *tb, VerilatedVcdC *tfp)
{
	tb->eval();
	if (tfp)
		tfp->dump(tickcount * 10 - 2);

	tb->i_clk = 0;
	tb->eval();
	if (tfp)
		tfp->dump(tickcount * 10);

	tb->i_clk = 1;
	tb->eval();
	if (tfp) {
		tfp->dump(tickcount * 10 + 5);
		tfp->flush();
	}
}

int main(int argc, char **argv)
{
	Vled_walker *tb = new Vled_walker;
	VerilatedVcdC *tfp = new VerilatedVcdC;
	int tickcount = 0;
	int last_led;

	Verilated::commandArgs(argc, argv);
	Verilated::traceEverOn(true);

	tb->trace(tfp, 99);
	tfp->open("led_walker.vcd");

	last_led = tb->o_led;
	for (int t = 0; t < (1 << 10); t++) {
		tick(++tickcount, tb, tfp);

		if (last_led != tb->o_led) {
			printf("t = %d, ", t);
			printf("o_led = %x\n", tb->o_led);
		}
		last_led = tb->o_led;
	}

	return 0;
}
