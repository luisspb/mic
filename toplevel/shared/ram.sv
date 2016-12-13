`include "definitions.svh"

interface ram_bus (input logic clk);
	logic we;
	logic [BYTE-1:0] data, q;
	logic [NBITS-1:0] addr;

	modport slave (input clk, we, data, addr, output q);
	modport master (input clk, q, output we, data, addr);
endinterface

module ram (ram_bus.slave bus);

	// Single-port Write, Dual-port Read Memory
	logic [BYTE-1:0] mem [0:WORDS-1];

	always_ff @ (posedge bus.clk) begin
		if(bus.we)
			mem[bus.addr] <= bus.data;
		bus.q <= mem[bus.addr];
	end
endmodule
