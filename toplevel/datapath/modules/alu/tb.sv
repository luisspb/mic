`include "../../../shared/definitions.svh"
`timescale 10ns/10ps

module tb();

   logic [NBITS-1:0] a, b;
   logic n, z;
   logic [NBITS-1:0] y;

   enum logic [ALU_CONTROL-1:0] {
      A         = 'h18,
      B         = 'h14,
      NOTA      = 'h1A,
      NOTB      = 'h2C,
      APLUSB    = 'h3C,
      APLUSBINC = 'h3D,
      INCA      = 'h39,
      INCB      = 'h35,
      BMINUSA   = 'h3F,
      DECB      = 'h36,
      MINUSA    = 'h3B,
      AANDB     = 'h0C,
      AORB      = 'h1C,
      ZERO      = 'h10,
      ONE       = 'h31,
      MINUSONE  = 'h32} ctrl;

   alu alu_i (.a(a), .b(b), .ctrl(ctrl), .n(n), .z(z), .y(y));

   initial begin
      #1ns;
      //Set data input
      a = 'hCDCD;
      b = 'hABAB;
      // Test of the selected 16 operations
      // A
      ctrl = A;
      #100ns;
      // B
      ctrl = B;
      #100ns;
      // ~A
      ctrl = NOTA;
      #100ns;
      // ~B
      ctrl = NOTB;
      #100ns;
      // A + B
      ctrl = APLUSB;
      #100ns;
      // A + B + 1
      ctrl = APLUSBINC;
      #100ns;
      // A + 1
      ctrl = INCA;
      #100ns;
      // B + 1
      ctrl = INCB;
      #100ns;
      // B - A
      ctrl = BMINUSA;
      #100ns;
      // B - 1
      ctrl = DECB;
      #100ns;
      // -A
      ctrl = MINUSA;
      #100ns;
      // A AND B
      ctrl = AANDB;
      #100ns;
      // A OR B
      ctrl = AORB;
      #100ns;
      // 0
      ctrl = ZERO;
      #100ns;
      // 1
      ctrl = ONE;
      #100ns;
      // -1
      ctrl = MINUSONE;
      #100ns;
      $finish();
   end

   initial begin
     $dumpfile ("waves.vcd");
     $dumpvars (1, tb);
   end

endmodule
