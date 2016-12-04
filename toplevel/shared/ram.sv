`include "definitions.svh"

interface ram_bus ();
	logic we;
	logic [BYTE-1:0] data, q;
	logic [NBITS-1:0] addr;

	modport slave (input we, data, addr, output q);
	modport master (input q, output we, data, addr);
endinterface

module ram (input logic clk, ram_bus.slave bus);

	// Single-port Write, Dual-port Read Memory
	logic [BYTE-1:0] mem [0:WORDS-1];

	always_ff @ (posedge clk) begin
		if(bus.we)
			mem[bus.addr] <= bus.data;
		bus.q <= mem[bus.addr];
	end
endmodule
