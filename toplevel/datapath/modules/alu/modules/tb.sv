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
   end

	//Logical Unit
	logic [NBITS-1:0] a, b, y_lu;
	logic [2:0] lu_ctrl;
	
   logical_unit lu_i(.a(a), .b(b), .ctrl(lu_ctrl), .y(y_lu));

   initial begin
      #1ns;
		a = 'hAAAAAAAA;
		b = 'hBBBBBBBB;
      //Do AND
      lu_ctrl = 3'b001;
      #100ns;
		//Do OR
      lu_ctrl = 3'b010;
      #100ns;
      //Do NOTB
      lu_ctrl = 3'b100;
      #100ns;
      //Do NOP
      lu_ctrl = 3'b000;
      #100ns;
		//Do OR again
      lu_ctrl = 3'b010;
   end
	
   initial begin
     $dumpfile ("waves.vcd");
     $dumpvars (1, tb);
   end

endmodule
