//datapath.sv
//Datapath

`include "../shared/definitions.svh"

module datapath (
   input logic clk,
   input logic reset,
   input logic [DP_CTRL-1:0] microinst,
   output logic n,
   output logic z,
   //MEM
   input logic [BYTE-1:0] mem_in,
   output logic [NBITS-1:0] mem_addr,
   output logic [BYTE-1:0] mem_out,
   output logic we);

   logic [NBITS-1:0] b_bus, c_bus;

   alu alu_i (a, b, ctrl, n, z, y);
   shifter shifter_i (.y, ctrl, c);
   register_file rf_i (.clk, reset, .c_bus, .b_bus, .enable_b, .write_c, .mem_control, .mem_in,
                       .mem_addr, .mem_out,  .we);

endmodule
