`default_nettype none

module blinky(output wire o_led, input wire i_clk);
	parameter WID = 27;
	reg [WID - 1:0] counter;

	initial counter = 0;
	always @(posedge i_clk)
		counter <= counter + 1'b1;

	assign o_led = counter[WID - 1];
endmodule
