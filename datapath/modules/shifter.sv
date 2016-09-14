//shifter.sv
//Shifter
//Alunos: Jorgeluis Guerra
//        Marcelo Aguiar
//		  Pedro Cleis

//Shifter Control signal

//Signal     Function
//0b10       SLL8 (Shift Left Logical - 8 bits)
//0b01       SRA1 (Shift Right Arithmetic - 1 bit)

`timescale 1ns/10ps
`include "definitions.svh"

module shifter (
   input logic [NBITS-1:0] c,
   input logic [S_CONTROL-1:0] s_control,
   output logic [NBITS-1:0] c_bus);

   enum logic [S_CONTROL-1:0] {SLL8=2'b10, SRA1=2'b01} s_control_;
   
   always_comb
      for (int i = 0; i < S_CONTROL; i++)
         s_control_[i] <= s_control;

   always_comb begin
      case (s_control)
         default:
            c_bus <= c;
         SLL8:
            c_bus <= c << 8;
         SRA1:
            c_bus <= c >>> 1;
      endcase
   end

endmodule
