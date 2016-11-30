//alu.sv
//Arithmetic Logic Unit
//Alunos: Jorgeluis Guerra
//        Marcelo Aguiar
//		  Pedro Cleis

//ALU operations

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

`timescale 1ns/10ps
`include "definitions.svh"	

module alu (
   input logic [NBITS-1:0] a,
   input logic [NBITS-1:0] b_bus,
   input logic [ALU_CONTROL-1:0] alu_control,
   output logic n,
   output logic z,
   output logic [NBITS-1:0] c);

   enum logic [ALU_CONTROL-1:0] {A=6'h18,
                                 B=6'h14,
                                 NOTA=6'h1A,
                                 NOTB=6'h2C,
                                 APLUSB=6'h3C,
                                 APLUSB1=6'h3D,
                                 APLUS1=6'h39,
                                 BPLUS1=6'h35,
                                 BMINUSA=6'h3F,
                                 BMINUS1=6'h37,
                                 MINUSA=6'h3B,
                                 AANDB=6'h0C,
                                 AORB=6'h1C,
                                 ZERO=6'h10,
                                 ONE=6'h11,
                                 MINUS1=6'h12} control;  //ALU mnemonic for operations

   always_comb
	   for (int i = 0; i < ALU_CONTROL; i++)
	      control[i] <= alu_control;

   always_comb begin
      case(control)
         default: c <= a;
         A:       c <= a;
         B:       c <= b_bus;
         NOTA:    c <= ~a;
         NOTB:    c <= ~b_bus;
         APLUSB:  c <= a + b_bus;
         APLUSB1: c <= a + b_bus + 1;
         APLUS1:  c <= a + 1;
         BPLUS1:  c <= b_bus + 1;
         BMINUSA: c <= b_bus - a;
         BMINUS1: c <= b_bus - 1;
         MINUSA:  c <= -a;
         AANDB:   c <= a & b_bus;
         AORB:    c <= a | b_bus;
         ZERO:    c <= 0;
         ONE:     c <= 1;
         MINUS1:  c <= -1;
      endcase

      z <= !c;

      n <= c[NBITS-1];

   end

endmodule
