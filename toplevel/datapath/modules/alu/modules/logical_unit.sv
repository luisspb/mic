//Logical Unit, submodule of ALU

`include "definitions.svh"

module logical_unit (
   input logic [NBITS-1:0] a, b,
   input logic [2:0] ctrl,
   output logic [NBITS-1:0] y);

   parameter AND  = 3'b001;
   parameter OR   = 3'b010;
   parameter NOTB = 3'b100;
   parameter NOP  = 3'b000;

   always_comb
      unique case (ctrl)
         AND:     y <= a & b;
         OR:      y <= a | b;
         NOTB:    y <= ~b;
			NOP:     y <= 'h0;
			default: y <= 'hx;
      endcase

endmodule
