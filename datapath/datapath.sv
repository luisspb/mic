//datapath.sv
//Datapath
//Alunos: Jorgeluis Guerra
//        Marcelo Aguiar
//        Pedro Cleis


`timescale 1ns/10ps
`include "./modules/definitions.svh"

module datapath(
   input logic clk,
   input logic reset,
   input logic [ALU+C+MEM+B-1:0] microinst,
   output logic n,
   output logic z,
   //MEM
   input logic [WORD-1:0] mem_in,
   output logic [NBITS-1:0] mem_addr,
   output logic [WORD-1:0] mem_out,
   output logic write_enb);

   logic [NBITS-1:0] b_bus, c_bus;
   logic [NBITS-1:0] a, c;

   register_bank rb1(.*, .write_c(micrinst[15:7]), .mem_control(micrinst[6:4]), .enable_b(micrinst[3:0]));
   alu alu1(.*, .alu_control(micrinst[21:16]));
   shifter shifter1(.*, .s_control(micrinst[23:22]));

endmodule
