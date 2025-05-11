`resetall
`timescale 1ns / 1ps
`default_nettype none

module arbiter(output logic [3:0] o_gnt,
	       input logic [3:0] i_req,
	       input bit i_clk,
	       input i_nrst);
//	       input i_lock,
//	       input i_wait,
//	       input i_pause);
	parameter [3:0] TIC = 4'b0001,
			ONE = 4'b0010,
			TWO = 4'b0100,
			ARM = 4'b1000;
	bit [3:0] req, next_req;

	always_ff @(negedge i_clk or negedge i_nrst) begin
		if (!i_nrst)
			o_gnt <= 4'b0000; // no bus controller is given access
		else
			o_gnt <= req;
	end

	always_comb begin
		if (i_req == TIC)
			req = TIC;
		else if (i_req == ONE && req > ONE)
			req = ONE;
		else if (i_req == TWO && req > TWO)
			req = TWO;
		else if (i_req == ARM && req > ARM)
			req = ARM;
	end
endmodule
