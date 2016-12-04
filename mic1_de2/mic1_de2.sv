`include "./shared/definitions.svh"

module mic1_de2 (input logic clk, reset);

logic [BYTE-1:0] from_mem;
logic [NBITS-1:0] mem_addr;
logic [BYTE-1:0] for_mem;
logic we;

   //DATAPATH AND CONTROL STORE
   mic1 mic1_i (.clk, .reset, .mem_in .mem_addr, .mem_out, .we);
   ram ram_i (.addr(mem_addr), .data(for_mem), .we(we), .clk(clk), .q(from_mem));

endmodule
