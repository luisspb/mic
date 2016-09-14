//datapath.sv
//Datapath
//Alunos: Jorgeluis Guerra
//        Marcelo Aguiar
//        Pedro Cleis


`timescale 1ns/10ps
`include "./modules/definitions.svh"

module tb;

	//INPUTS
   logic clk;
   logic reset;
   logic [ALU+C+MEM+B-1:0] microinst;
	logic [WORD-1:0] mem_in;
   //OUTPUTS
	logic n;
   logic z;
   logic [NBITS-1:0] mem_addr;
   logic [WORD-1:0] mem_out;
   logic write_enb;

	datapath dp_i(.*);
	
	//CLOCK
   initial
		clk <= 1'b0;
	always
		#500ns clk <= ~clk;
	
   //RESET
	initial begin
		reset <= 1'b1;
		#1500ns;
		reset <= 1'b0;
	end

   //SIMULATION
	initial begin
	
		
	
	end

endmodule
