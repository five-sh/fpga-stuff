`default_nettype none

module fifomem #(parameter DSIZE = 8, parameter ASIZE = 4)
	       (output [DSIZE - 1:0] rdata,
	        input [DSIZE - 1:0] wdata,
		input [ASIZE - 1:0] waddr,
		input [ASIZE - 1:0] raddr,
		input wclken,
		input wclk);
	parameter DEPTH = 1 << ASIZE;
	reg [DSIZE - 1:0] MEM [0:DEPTH - 1];

	assign rdata = MEM[raddr];

	always @(posedge wclk) begin
		if (wclken)
			MEM[waddr] <= wdata;
	end
endmodule
