`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 02:01:40 PM
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(input [9:0] address,
                          output reg [31:0] instruction);
    reg [31:0] codeMemory [0:1023];
    initial $readmemh("code.mem", codeMemory);
    
    always @(address)
    begin
        instruction = codeMemory[address];
    end
                          
endmodule
