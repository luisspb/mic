`include "../../shared/definitions.svh"
`timescale 10ns/10ps

module tb();

   logic [NBITS-1:0] y, c;
   logic [S_CONTROL-1:0] ctrl;

   localparam SLL8 = 2'b10;
   localparam SRA1 = 2'b01;

   shifter shifter_i (.y(y), .ctrl(ctrl), .c(c));

   initial begin
      #1ns;
      //Set data input
      y = 'hF0F0CDCD;
      //Test no shift
      ctrl = 'b0;
      #100ns;
      //Test SLL8
      ctrl = SLL8;
      #100ns;
      //Test SRA1
      ctrl = SRA1;
      #100ns;
      y = 'h00F0CDCD;
      #100ns;
      //Test no shift again
      ctrl = 'b11;
      #100ns;
      $finish();
   end

   initial begin
     $dumpfile ("waves.vcd");
     $dumpvars (1, tb);
   end

endmodule
