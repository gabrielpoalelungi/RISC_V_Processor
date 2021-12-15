`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 03:43:30 PM
// Design Name: 
// Module Name: IF
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IF(input clk, reset,
          input PCSrc, PC_write,
          input [31:0] PC_Branch,
          output wire [31:0] PC_IF, INSTRUCTION_IF);
       
       // mux: ina = pc_branch sel 1, inb = out_adder sel 0,sel = pcsrc
       // adder: ina = PC_IF, inb = valoarea 4 pe clk
       // PC: clk, res, write = PC_WRITE, in = out_mux;
       // instr_mem: address = PC_IF ultimii 10 biti dupa ce s-a facut shiftarea la dreapta cu 2
       
       wire [31:0] out_mux;
       wire [31:0] out_adder;
       wire [31:0] valueOf4 = 4;
       
       mux2_1 mux21(PC_Branch, out_adder, PCSrc, out_mux); // if sel = 1 then ina else inb;
       PC pc(clk, reset, PC_write, out_mux, PC_IF);
       adder adder_mod(PC_IF, valueOf4, out_adder);
       instruction_memory instr_mem(PC_IF[11:2], INSTRUCTION_IF);
endmodule
