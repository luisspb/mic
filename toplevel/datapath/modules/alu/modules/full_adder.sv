//Full Adder, submodule of ALU

`include "definitions.svh"

module full_adder (
   input logic enable,
   input logic c_in,
   input logic [NBITS-1:0] a, b,
   output logic [NBITS-1:0] y,
   output logic c_out);

   always_comb
      if (enable)
         {c_out, y} <= a + b + c_in;
		else
			{c_out, y} <= 'h0;

endmodule
