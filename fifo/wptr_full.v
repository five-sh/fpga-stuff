`default_nettype none

module wptr_full #(parameter ASIZE = 4)
		 (output reg wfull,
		  output reg [ASIZE - 1:0] wptr,
		  input afull_n,
		  input winc,
		  input wclk,
		  input wrst_n);
	reg [ASIZE - 1:0] wbin;
	reg wfull2;
	wire [ASIZE - 1:0] wgnext, wbnext;

	always @(posedge wclk or negedge wrst_n) begin
		if (!wrst_n) begin
			wbin <= 0;
			wptr <= 0;
		end else begin
			wbin <= wbnext;
			wptr <= wgnext;
		end
	end

	assign wbnext = !wfull ? wbin + winc : wbin;
	assign wgnext = (wbnext >> 1) ^ wbnext;

	always @(posedge wclk or negedge wrst_n or
		 negedge afull_n) begin
		if (!wrst_n)
			{wfull, wfull2} <= 2'b00;
		else if (!afull_n)
			{wfull, wfull2} <= 2'b11;
		else
			{wfull, wfull2} <= {wfull2, ~afull_n};
	end
endmodule
