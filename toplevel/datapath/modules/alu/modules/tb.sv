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
   end

   initial begin
     $dumpfile ("waves.vcd");
     $dumpvars (1, tb);
   end

endmodule
