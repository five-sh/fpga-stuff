VINC ?= /usr/local/share/verilator/include

.PHONY: all
all: led_walker_sby

obj_dir/Vled_walker.cpp: led_walker.v
	verilator -Wall --cc --trace led_walker.v

obj_dir/Vled_walker__ALL.a: obj_dir/Vled_walker.cpp
	make -C obj_dir -f Vled_walker.mk \

led_walker: led_walker.cpp obj_dir/Vled_walker__ALL.a
	g++ -I $(VINC) \
		-I obj_dir/ \
		$(VINC)/verilated.cpp \
		$(VINC)/verilated_vcd_c.cpp \
		led_walker.cpp obj_dir/Vled_walker__ALL.a \
		-o led_walker.o

led_walker_sby: led_walker
	sby -f led_walker.sby

clean:
	rm -rf obj_dir/ led_walker/ led_walker.o led_walker.vcd
