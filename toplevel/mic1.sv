`include "./shared/definitions.svh"

module mic1 (
   input logic clk, reset,
   input logic [BYTE-1:0] mem_in,
   output logic [NBITS-1:0] mem_addr,
   output logic [BYTE-1:0] mem_out,
   output logic we);

   //ADDITIONAL LOGIC
   MPC and decision logic
   HIGH Bit

   //DATAPATH AND CONTROL STORE
   datapath datapath_i (.clk, .reset, .microinst, .n, .z, .mem_in, .mem_addr, .mem_out, .we);
   control_store control_store_i (.addr, .q);

endmodule
