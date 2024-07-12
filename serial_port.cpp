#include <stdio.h>
#include <stdlib.h>
#include "verilated.h"
#include "Vserial_port.h"

int main(int argc, char **argv)
{
	Verilated::commandArgs(argc, argv);
	Vserial_port *tb = new Vserial_port;

	for (int t = 0; t < 20; t++) {
		scanf("%hhx", &tb->tx);
		tb->eval();
		printf("rx: %x", tb->rx);
	}
	return 0;
}
