#include <stdio.h>
#include <stdlib.h>
#include "verilated.h"
#include "Vmaskbus.h"

int main(int argc, char **argv)
{
	Verilated::commandArgs(argc, argv);
	Vmaskbus *tb = new Vmaskbus;

	for (int t = 0; t < 20; t++) {
		tb->i_sw = t & 0xff;
		tb->eval();

		printf("t = %2d, ", t);
		printf("sw = %x, ", tb->i_sw);
		printf("led = %x\n", tb->o_led);
	}
	return 0;
}
