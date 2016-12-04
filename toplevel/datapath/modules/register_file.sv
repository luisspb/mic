//register_bank.sv
//10 Registers Bank

`include "../../shared/definitions.svh"

module register_file (
   //CLK and RESET
   input logic clk, reset,
   //BUSES
   input  logic [NBITS-1:0] c_bus,
   output logic [NBITS-1:0] b_bus,
   input  logic [B-1:0]     enable_b,
   input  logic [C-1:0]     write_c,
   //MEM
   input logic [MEM-1:0] mem_control,
   ram_bus.master mem_bus);

   logic [NBITS-1:0] mar, mdr, pc, sp, lv, cpp, tos, opc, h;
   logic [BYTE-1:0] mbr;
   logic fetch, rd, wr;
   logic CH, COPC, CTOS, CCPP, CLV, CSP, CPC, CMDR, CMAR;

   // B = 4
   localparam BMDR  = 4'h0;
   localparam BPC   = 4'h1;
   localparam BMBRU = 4'h2;
   localparam BMBRS = 4'h3;
   localparam BSP   = 4'h4;
   localparam BLV   = 4'h5;
   localparam BCPP  = 4'h6;
   localparam BTOS  = 4'h7;
   localparam BOPC  = 4'h8;

   // C = 9
   always_comb begin
      CH   <= write_c[0];
      COPC <= write_c[1];
      CTOS <= write_c[2];
      CCPP <= write_c[3];
      CLV  <= write_c[4];
      CSP  <= write_c[5];
      CPC  <= write_c[6];
      CMDR <= write_c[7];
      CMAR <= write_c[8];
   end

   always_comb begin
	   fetch <= mem_control[0];
	   rd    <= mem_control[1];
	   wr    <= mem_control[2];
   end

   // Write on Registers from C BUS (or Memory)
   always_ff@(posedge clk) begin
      if (reset) begin
         mar <= 'h0;
         mdr <= 'h0;
         pc  <= 'h0;
         mbr <= 'h0;
         sp  <= 'h0;
         lv  <= 'h0;
         cpp <= 'h0;
         tos <= 'h0;
         opc <= 'h0;
         h   <= 'h0;
      end
      else begin
         //MAR
         if (CMAR)
            mar <= c_bus;
         else
            mar <= mar;

         //MDR
         if (CMDR & ~rd)
            mdr <= c_bus;
         else if (~CMDR & rd)
            mdr[7:0] <= mem_bus.q;
         else
            mdr <= mdr;

         //PC
         if (CPC)
            pc <= c_bus;
         else
            pc <= pc + 1;

         //MBR
         if (fetch)
            mbr <= mem_bus.q;
         else
            mbr <= mbr;

         //SP
         if (CSP)
            sp <= c_bus;
         else
            sp <= sp;

         //LV
         if (CLV)
            lv <= c_bus;
         else
            lv <= lv;

         //CPP
         if (CCPP)
            cpp <= c_bus;
         else
            cpp <= cpp;

         //TOS
         if (CTOS)
            tos <= c_bus;
         else
            tos <= tos;

         //OPC
         if (COPC)
            opc <= c_bus;
         else
            opc <= opc;

         //H
         if (CH)
            h <= c_bus;
         else
            h <= h;
      end
   end

   // Read from Registers on B Bus
   always_ff@(negedge clk) begin  //B BUS
      if (reset)
         b_bus <= 'h0;
      else
         case (enable_b)
            BMDR:    b_bus <= mdr;
            BPC:     b_bus <= pc;
            BMBRU:   b_bus <= unsigned'(mbr);
            BMBRS:   b_bus <= signed'(mbr);
            BSP:     b_bus <= sp;
            BLV:     b_bus <= lv;
            BCPP:    b_bus <= cpp;
            BTOS:    b_bus <= tos;
            BOPC:    b_bus <= opc;
            default: b_bus <= 'h0;
         endcase
   end

   //Memory control
   always_comb begin
      mem_bus.addr <= {mar[NBITS-3:0], 2'b00};
      //mem_bus.addr <= pc;
      mem_bus.data <= mdr;
      if (wr)
         if (rd ^ wr)
            mem_bus.we <= 1;
         else
			   mem_bus.we <= 0;
      else
	      mem_bus.we <= 0;
   end
endmodule
