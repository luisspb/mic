`include "../../shared/definitions.svh"

module rf_test (
    //CLK and RESET
   input logic clk, reset,
   //BUSES
   input logic [NBITS-1:0] c_bus,
   output logic [NBITS-1:0] b_bus,
   input logic [B-1:0] enable_b,
   input logic [C-1:0] write_c,
   //MEM
   input logic [MEM-1:0] mem_control);

   logic [NBITS-1:0] from_mem32, from_mem8, for_mem32, mem_addr32, mem_addr8;
   logic we;

   /*register_file rf_i (
      .clk(clk), .reset(reset), .c_bus(c_bus), .b_bus(b_bus), .enable_b(enable_b),
      .write_c(write_c), .mem_in(from_mem), .mem_control(mem_control), .mem_addr(mem_addr),
      .mem_out(for_mem), .we(we));

   ram ram_i (.addr(mem_addr), .data(for_mem), .we(we), .clk(clk), .q(from_mem));*/

endmodule
