`default_nettype none

module parity_check(output wire o_parity, input wire [7:0] i_word);
	assign o_parity = ^ i_word;
endmodule
