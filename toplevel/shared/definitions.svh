//definitions.svh
//Constants file
//Alunos: Jorgeluis Guerra
//        Marcelo Aguiar

`ifndef DEFINITIONS_SVH_
`define DEFINITIONS_SVH_

parameter NBITS = 32;       //Size of the buses in bits
parameter WORD = 8;
parameter S_CONTROL = 2;
parameter ALU_CONTROL = 6;  //Number of bits for ALU Control signal
parameter ENABLE_B = 8;
//
parameter ALU = S_CONTROL + ALU_CONTROL;
parameter C = 9;
parameter MEM = 3;
parameter B = 4;

`endif

