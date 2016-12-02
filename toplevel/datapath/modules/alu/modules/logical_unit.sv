//Logical Unit, submodule of ALU

`include "../../../../shared/definitions.svh"

module logical_unit (
   input logic [NBITS-1:0] a, b,
   input logic [2:0] ctrl,
   output logic [NBITS-1:0] y);

   localparam AND  = 3'b001;
   localparam OR   = 3'b010;
   localparam NOTB = 3'b100;
   localparam NOP  = 3'b000;

   always_comb
      unique case (ctrl)
         AND:     y <= a & b;
         OR:      y <= a | b;
         NOTB:    y <= ~b;
			NOP:     y <= 'h0;
			default: y <= 'hx;
      endcase

endmodule
