//definitions.svh
//Constants file

`ifndef DEFINITIONS_SVH_
`define DEFINITIONS_SVH_

parameter NBITS = 32;         // Size of the buses in bits
parameter BYTE = 8;
parameter WORDS = 1 << (NBITS-13);
parameter S_CONTROL = 2;      // Size of Shifter control input
parameter ALU_CONTROL = 6;    // Number of bits for ALU control signal
parameter B = 4;
parameter C = 9;
parameter MEM = 3;
parameter DP_CTRL = S_CONTROL + ALU_CONTROL + B + C + MEM;
parameter CS_ADDR = 9;
parameter MICROINSTS = 1 << CS_ADDR;
parameter CS_CTRL = DP_CTRL + CS_ADDR;


`endif
