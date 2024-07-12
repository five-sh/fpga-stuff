VINC ?= /usr/local/share/verilator/include

.PHONY: all
all: fifo_sby

obj_dir/Vfifo.cpp: fifo.v
	verilator --cc --trace fifo.v

obj_dir/Vfifo__ALL.a: obj_dir/Vfifo.cpp
	make -C obj_dir -f Vfifo.mk \

fifo: fifo.cpp obj_dir/Vfifo__ALL.a
	g++ -I $(VINC) \
		-I obj_dir/ \
		$(VINC)/verilated.cpp \
		$(VINC)/verilated_vcd_c.cpp \
		fifo.cpp obj_dir/Vfifo__ALL.a \
		-o fifo.o

fifo_sby: fifo
	sby -f fifo.sby

clean:
	rm -rf obj_dir/ fifo/ fifo.o fifo.vcd
