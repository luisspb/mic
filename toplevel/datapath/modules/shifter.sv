//shifter.sv
//Shifter

//Shifter Control signal

//Signal     Function
//0b10       SLL8 (Shift Left Logical - 8 bits)
//0b01       SRA1 (Shift Right Arithmetic - 1 bit)

`include "../../shared/definitions.svh"

module shifter (
   input logic signed [NBITS-1:0] y,
   input logic [S_CONTROL-1:0] ctrl,
   output logic signed [NBITS-1:0] c);

   localparam SLL8 = 2'b10;
   localparam SRA1 = 2'b01;

   always_comb begin
      unique case (ctrl)
         default:
            c <= y;
         SLL8:
            c <= y << 8;
         SRA1:
            c <= y >>> 1;
      endcase
   end
endmodule
