`timescale 1ns / 1ps

module tb_arbiter();
	bit i_clk, i_nrst;
	logic [3:0] i_req;
	logic [3:0] o_gnt;


	arbiter uut(.o_gnt(o_gnt), .i_req(i_req),
		    .i_clk(i_clk), .i_nrst(i_nrst));

	always #5 i_clk = ~i_clk;

	initial begin
		i_clk = 0;
		i_nrst = 0;

		#10 i_nrst = 1;
		#10 i_req = 4'b1000;
		#10 i_req = 4'b0100;
		#10 i_req = 4'b0001;
		#10 i_req = 4'b0010;
		#50 $finish;
	end

	initial begin
		$dumpfile("arbiter.vcd");
		$dumpvars(1);
	end
endmodule
