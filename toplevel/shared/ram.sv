`include "definitions.svh"

module ram
	#(parameter BYTE = WORD,
		         BYTES = 4,
			      WIDTH = NBITS) (
	input logic [WIDTH-1:0] addr,
	input logic [BYTE-1:0] data,
	input logic we, clk,
	output logic [BYTE-1:0] q);

	localparam WORDS = 1 << WIDTH;

	// use a multi-dimensional packed array to model individual bytes within the word
	logic [BYTES-1:0][BYTE-1:0] ram [0:WORDS-1];

	always_ff @ (posedge clk) begin
		if(we)
			ram[addr] <= data;
		q <= ram[addr];
	end
endmodule
