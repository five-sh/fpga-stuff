`default_nettype none

module maskbus(output wire [7:0] o_led, input wire [7:0] i_sw);
	wire [7:0] w_internal;

	assign w_internal = 8'h87;
	assign o_led = i_sw ^ w_internal;
endmodule
