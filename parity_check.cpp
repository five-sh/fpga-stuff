#include <stdio.h>
#include <stdlib.h>
#include "verilated.h"
#include "Vparity_check.h"

int main(int argc, char **argv)
{
	Verilated::commandArgs(argc, argv);
	Vparity_check *tb = new Vparity_check;

	for (int t = 0; t < 20; t++) {
		tb->i_word = t;
		tb->eval();

		printf("t = %d, ", t);
		printf("i_word = %x, ", tb->i_word);
		printf("o_parity = %x\n", tb->o_parity);
	}
	return 0;
}
