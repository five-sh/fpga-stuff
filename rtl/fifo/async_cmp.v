`default_nettype none

module async_cmp #(parameter ASIZE = 4)
		 (output reg aempty_n,
		  output reg afull_n,
		  input [ASIZE - 1:0] wptr,
		  input [ASIZE - 1:0] rptr,
		  input wrst_n);
	parameter N = ASIZE - 1;
	reg direction;

	// This kind of design is always bad - it is simply not
	// synthesizable.  Declare wires for these "if" conditions so
	// that we are now checking for the output of the wires.
	//
	//	wire dirset_n = ~(wptr[N] ^ rptr[N - 1]) &
	//			  ~(wptr[N - 1] ^ rptr[N]));
	//	wire dirclr_n = ~((rptr[N] ^ wptr[N - 1]) &
	//			  ~(rptr[N - 1] ^ wptr[N]) & wrst_n);
	//
	always @(wptr or rptr) begin
		if ((wptr[N] ^ rptr[N - 1]) &
		    ~(wptr[N - 1] ^ rptr[N]))
			direction = 1'b1; // going towards full
		else if ((rptr[N] ^ wptr[N - 1]) &
			 ~(rptr[N - 1] ^ wptr[N]) & wrst_n)
			direction = 1'b0; // going towards empty
	end

	assign aempty_n = ~((wptr == rptr) && !direction);
	assign afull_n = ~((wptr == rptr) && direction);
endmodule
