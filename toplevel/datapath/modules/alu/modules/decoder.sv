//F0F1 Decoder, submodule of ALU

module decoder (
   input logic [0:1] f,
   output logic [3:0] y);

   parameter AND  = 4'b0001;
   parameter OR   = 4'b0010;
   parameter NOTB = 4'b0100;
   parameter SUM  = 4'b1000;

   always_comb
      case (f)
         2'b00:  y <= AND;
         2'b01:  y <= OR;
         2'b10:  y <= NOTB;
         2'b11:  y <= SUM;
      endcase

endmodule
