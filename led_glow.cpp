#include <stdio.h>
#include <stdlib.h>
#include "verilated.h"
#include "Vled_glow.h"

int main(int argc, char **argv)
{
	Verilated::commandArgs(argc, argv);
	Vled_glow *tb = new Vled_glow;

	for (int t = 0; t < 20; t++) {
		tb->i_sw = t & 1; /* sw input is set to lsb of t */
		tb->eval();

		printf("t = %2d, ", t);
		printf("sw = %d, ", tb->i_sw);
		printf("led = %d\n", tb->o_led);
	}

	return 0;
}
