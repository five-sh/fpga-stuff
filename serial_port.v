`default_nettype none

module serial_port(output wire rx, input wire tx);
	assign rx = tx;
endmodule
