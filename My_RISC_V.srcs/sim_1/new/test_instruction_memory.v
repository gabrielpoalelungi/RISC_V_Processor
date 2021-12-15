`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 02:08:16 PM
// Design Name: 
// Module Name: test_instruction_memory
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


module test_instruction_memory;
    
reg [9:0] address;
wire [31:0] instruction;
instruction_memory ins(
                    address,
                    instruction
                        );
                        
 initial begin 
 address = 10'b00_0000_0001;
#50 
 address = 10'b00_0000_0011;
#10 $finish;
 end
endmodule
