`default_nettype none

module led_walker(output reg [7:0] o_led, input wire i_clk);
	reg [3:0] led_index;

//	always @(posedge i_clk) begin
//		if (wait_counter == 0)
//			wait_counter <= CLK_RATE_HZ - 1;
//		else
//			wait_counter <= wait_counter - 1;
//	end

	always @(posedge i_clk) begin
		// if (wait_counter == 0)
		if (led_index >= 4'h8)
			led_index <= 0;
		else
			led_index <= led_index + 1'b1;
	end

	always @(*) begin
		case (led_index)
		4'h0: o_led = 8'h01;
		4'h1: o_led = 8'h02;
		4'h2: o_led = 8'h04;
		4'h3: o_led = 8'h08;
		4'h4: o_led = 8'h10;
		4'h5: o_led = 8'h20;
		4'h6: o_led = 8'h40;
		4'h7: o_led = 8'h80;
		default: o_led = 8'h01;
		endcase
	end

`ifdef FORMAL
	reg f_valid_output;

	always @(*)
		assert(led_index < 4'ha);

	always @(*) begin
		f_valid_output = 0;

		case (o_led)
		8'h01: f_valid_output = 1'b1;
		8'h02: f_valid_output = 1'b1;
		8'h04: f_valid_output = 1'b1;
		8'h08: f_valid_output = 1'b1;
		8'h10: f_valid_output = 1'b1;
		8'h20: f_valid_output = 1'b1;
		8'h40: f_valid_output = 1'b1;
		8'h80: f_valid_output = 1'b1;
		endcase

		assert(f_valid_output);
	end
`endif

endmodule
