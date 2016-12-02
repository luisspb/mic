//register_bank.sv
//10 Registers Bank

`include "../../shared/definitions.svh"

module register_file (

   //CLK and RESET
   input logic clk, reset,

   //BUSES
   input logic [NBITS-1:0] c_bus,
   output logic [NBITS-1:0] b_bus,
   input logic [B-1:0] enable_b,
   input logic [C-1:0] write_c,

   //MEM
   input logic [WORD-1:0] mem_in,
   input logic [MEM-1:0] mem_control,
   output logic [NBITS-1:0] mem_addr,
   output logic [WORD-1:0] mem_out,
   output logic we);

   logic [NBITS-1:0] mar, mdr, pc, mbr, sp, lv, cpp, tos, opc, h;
   logic fetch, rd, wr;

   // B = 4
   localparam OPC = 4'h0;
   localparam TOS = 4'h1;
   localparam CPP = 4'h2;
   localparam LV  = 4'h3;
   localparam SP  = 4'h4;
   localparam MBR = 4'h5;
   localparam PC  = 4'h6;
   localparam MDR = 4'h7;

   // C = 9
   //localparam

   always_comb begin
	   fetch <= mem_control[0];
	   rd    <= mem_control[1];
	   wr    <= mem_control[2];
   end

   always_ff@(posedge clk) begin
      if (reset) begin
         mar <= 32'h0;
         mdr <= 32'h0;
         pc  <= 32'h0;
         mbr <= 32'h0;
         sp  <= 32'h0;
         lv  <= 32'h0;
         cpp <= 32'h0;
         tos <= 32'h0;
         opc <= 32'h0;
         h   <= 32'h0;
      end
      else begin
         //MAR
         if (write_c[0])
            mar <= c_bus;
         else
            mar <= mar;

         //MDR
         if (write_c[C-8] & ~rd)
            mdr <= c_bus;
         else if (~write_c[C-8] & rd) begin
            case(mar[1:0])
               default: mdr[7:0]   <= mem_in;
               1:       mdr[15:8]  <= mem_in;
               2:       mdr[23:16] <= mem_in;
               3:       mdr[31:24] <= mem_in;
            endcase
         end
         else
            mdr <= mdr;

         //PC
         if (write_c[C-7])
            pc <= c_bus;
         else
            pc <= pc;

         //MBR -- Todo: FALTA SIGNED E UNSIGNED
         if (fetch)
            mbr[7:0] <= mem_in;
         else
            mbr <= mbr;

         //SP
         if (write_c[C-6])
            sp <= c_bus;
         else
            sp <= sp;

         //LV
         if (write_c[C-5])
            lv <= c_bus;
         else
            lv <= lv;

         //CPP
         if (write_c[C-4])
            cpp <= c_bus;
         else
            cpp <= cpp;

         //TOS
         if (write_c[C-3])
            tos <= c_bus;
         else
            tos <= tos;

         //OPC
         if (write_c[C-2])
            opc <= c_bus;
         else
            opc <= opc;

         //H
         if (write_c[C-1])
            h <= c_bus;
         else
            h <= h;
      end
   end

   always_ff@(negedge clk) begin  //B BUS
      if (reset)
         b_bus <= 'h0;
      else
         case (enable_b)
            default: b_bus <= opc;  //OPC
            TOS:     b_bus <= tos;
            CPP:     b_bus <= cpp;
            LV:      b_bus <= lv;
            SP:      b_bus <= sp;
            MBR:     b_bus <= mbr;
            PC:      b_bus <= pc;
            MDR:     b_bus <= mdr;
         endcase
   end

   always_comb begin
      if (rd ^ wr) begin
         mem_addr <= {2'b00, mar[NBITS-1:2]};
         if (wr)
            we <= 1;
         else
			we <= 0;
      end
      else begin
         mem_addr <= pc;
         we <= 0;
      end
   end

   always_comb begin
      mem_out <= mdr[7:0];
   end
endmodule
