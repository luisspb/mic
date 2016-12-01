`include "../../../../shared/definitions.svh"
`timescale 10ns/10ps

module tb();

   //Decoder
   logic [1:0] f;
   logic [3:0] y_dec;

   decoder decoder_i (.f(f), .y(y_dec));

   initial begin
      #1ns;
      //Decode ADD
      f = 2'h0;
      #100ns;
      //Decode OR
      f = 2'h1;
      #100ns;
      //Decode NOTB
      f = 2'h2;
      #100ns;
      //Decode SUM
      f = 2'h3;
      #100ns;
		//Decode ADD again
      f = 2'h0;
      #50ns;
   end

	//Logical Unit
	logic [NBITS-1:0] a, b, y_lu;
	logic [2:0] lu_ctrl;

   logical_unit lu_i(.a(a), .b(b), .ctrl(lu_ctrl), .y(y_lu));

   initial begin
      #1ns;
		a = 'h0000AAAA;
      b = 'hBBBB0000;
      //Do AND
      lu_ctrl = 3'b001;
      #100ns;
		//Do OR
      lu_ctrl = 3'b010;
      #100ns;
      //Do NOTB
		a = 'hAAAAAAAA;
		b = 'hBBBBBBBB;
      lu_ctrl = 3'b100;
      #100ns;
      //Do NOP
      lu_ctrl = 3'b000;
      #100ns;
		//Do OR again
      lu_ctrl = 3'b010;
      #50ns;
   end

   //Full Adder
   logic enable;
   logic c_in;
   logic [NBITS-1:0] y_fa;
   logic c_out;

   full_adder fa_i(.enable(enable), .c_in(c_in), .a(a), .b(b), .y(y_fa), .c_out(c_out));

   initial begin
      #1ns;
      enable = 1'b1;
      c_in = 1'b0;
      #100ns;
      c_in = 1'b1;
      #200ns;
      c_in = 1'b0;
      #100ns;
      enable = 1'b0;
      #50ns;
   end

   initial begin
     $dumpfile ("waves.vcd");
     $dumpvars (1, tb);
   end

endmodule
