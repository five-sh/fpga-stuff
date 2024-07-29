`default_nettype none

module dimmer(output wire o_led, input wire i_clk);
	reg [27:0] counter;

	always @(posedge i_clk)
		counter <= counter + 1;
	assign o_led = (counter[7:0] < counter[27:20]);
endmodule
