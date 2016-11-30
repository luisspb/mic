//Instantiator for ALU submodules

`include "definitions.svh"

module alu_modules (
   input logic [0:1] f,
   input logic [NBITS-1:0] a, b,
   input logic c_in,
   output logic c_out);

   logic [3:0] y_dec;
   logic [NBITS-1:0] y_lu, y_fa;

   decoder decoder_i(.f(f), .y(y_dec));
   logical_unit lu_i(.a(a), .b(b), .ctrl(y_dec[2:0]), .y(y_lu));
   full_adder fa_i(.enable(y_dec[3]), .c_in(c_in), .a(a), .b(b), .y(y_fa), .c_out(c_out));

endmodule
