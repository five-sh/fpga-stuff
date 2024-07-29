`default_nettype none

module rptr_empty #(parameter ASIZE = 4)
		  (output reg rempty,
		   output reg [ASIZE - 1:0] rptr,
		   input aempty_n,
		   input rinc,
		   input rclk,
		   input rrst_n);
	reg [ASIZE - 1:0] rbin;
	reg rempty2;
	wire [ASIZE - 1:0] rgnext, rbnext;

	always @(posedge rclk or negedge rrst_n) begin
		if (!rrst_n) begin
			rbin <= 0;
			rptr <= 0;
		end else begin
			rbin <= rbnext;
			rptr <= rgnext;
		end
	end

	assign rbnext = !rempty ? rbin + rinc : rbin;
	assign rgnext = (rbnext >> 1) ^ rbnext;

	always @(posedge rclk or negedge aempty_n) begin
		if (!aempty_n)
			{rempty, rempty2} <= 2'b11;
		else
			{rempty, rempty2} <= {rempty2, ~aempty_n};
	end
endmodule
