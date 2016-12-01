//alu.sv
//Arithmetic Logic Unit

//Selection of 16 from the 64 ALU operations

//ALU Control             Function
//01.1000 0x18            A
//01.0100 0x14            B
//01.1010 0x1A            ~A
//10.1100 0x2C            ~B
//11.1100 0x3C            A + B
//11.1101 0x3D            A + B + 1
//11.1001 0x39            A + 1
//11.0101 0x35            B + 1
//11.1111 0x3F            B - A
//11.0111 0x37            B - 1
//11.1011 0x3B            -A
//00.1100 0x0C            A AND B
//01.1100 0x1C            A OR B
//01.0000 0x10            0
//01.0001 0x11            1
//01.0010 0x12            -1

`include "../../../shared/definitions.svh"

module alu (
   input logic [NBITS-1:0] a, b,
   input logic [ALU_CONTROL-1:0] ctrl,
   output logic n, z,
   output logic [NBITS-1:0] c);

   logic [1:0] f;
   logic ena, enb, inva, inc;

   always_comb begin
      f <= ctrl[5:4];
      ena <= ctrl[3];
      enb <= ctrl[2];
      inva <= ctrl[1];
      inc <= ctrl[0];
   end

   logic [NBITS-1:0] a_bus, b_bus, y_lu, y_fa;
   logic [3:0] y_dec;

   always_comb begin
      if (inva)
         a_bus <= ~(ena & a);
      else
         a_bus <= ena & a;
      b_bus <= enb & b;
   end

   always_comb
      c <= y_lu | y_fa;

   decoder decoder_i (.f(f), .y(y_dec));
   logical_unit lu_i (.a(a_bus), .b(b_bus), .ctrl(y_dec[2:0]), .y(y_lu));
   full_adder fa_i (.enable(y_dec[3]), .c_in(inc), .a(a_bus), .b(b_bus), .y(y_fa), .c_out());

endmodule
