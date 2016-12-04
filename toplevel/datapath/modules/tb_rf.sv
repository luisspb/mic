`include "../../shared/definitions.svh"
`timescale 10ns/10ps

module tb();
   //CLK and RESET
   logic clk, reset;
   //BUSES
   logic [NBITS-1:0] c_bus, b_bus;
   logic [B-1:0] enable_b;
   logic [C-1:0] write_c;
   //MEM
   logic [NBITS-1:0] from_mem, for_mem;
   logic [MEM-1:0] mem_control;
   logic [NBITS-1:0] mem_addr;
   logic we;

   register_file rf_i (
      .clk(clk), .reset(reset), .c_bus(c_bus), .b_bus(b_bus), .enable_b(enable_b),
      .write_c(write_c), .mem_in(from_mem), .mem_control(mem_control), .mem_addr(mem_addr),
      .mem_out(for_mem), .we(we));

   ram ram_i (.addr(mem_addr), .data(for_mem), .we(we), .clk(clk), .q(from_mem));

   // Set reset
   initial begin
      #10ns;
      reset = 1'b0;
      #750ns;
      reset = 1'b1;
   end

   // Set clock
   initial begin
      #10ns;
      forever begin
         clk = 1'b1;
         #250ns;
         clk = 1'b0;
         #750ns;
      end
   end

   // B = 4
   localparam OPC = 4'h0;
   localparam TOS = 4'h1;
   localparam CPP = 4'h2;
   localparam LV  = 4'h3;
   localparam SP  = 4'h4;
   localparam MBR = 4'h5;
   localparam PC  = 4'h6;
   localparam MDR = 4'h7;

   initial begin
      #10ns;
      //Set data input
      c_bus = 'hF0F0F0F0;
      enable_b = OPC;
      write_c = 'h100;
      mem_control = 'b001;
      #1s;
   end

   initial begin
     $dumpfile ("waves.vcd");
     $dumpvars (1, tb);
   end
endmodule
