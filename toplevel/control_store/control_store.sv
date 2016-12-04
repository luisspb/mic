`include "../shared/definitions.svh"

module control_store (
	input logic [CS_ADDR-1:0] addr,
	output logic [CS_CTRL-1:0] q);

	// Single-port Read Only Memory
	logic [CS_CTRL-1:0] rom [0:MICROINSTS-1];

	always_comb
		q <= rom[addr];

endmodule
