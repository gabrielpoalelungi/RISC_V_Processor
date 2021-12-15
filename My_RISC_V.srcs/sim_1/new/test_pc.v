`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 01:41:11 PM
// Design Name: 
// Module Name: test_pc
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


module test_pc;
    reg clk, res, write;
    reg [31:0] in;
    wire [31:0] out;
    
    PC test_pc(clk, res, write, in, out);
    
    initial begin
    #0 clk = 1'b0; res = 1'b0; write = 1'b0;
    #10 in = 32'b00000000000000000000000000000000; write = 1'b1;
    #20 in = 32'b00000000000000000000000000001000; write = 1'b0;
    #30 in = 32'b00000000000000000000000000001000; write = 1'b1;
    #40 in = 32'b00000000000000000000000000001000; write = 1'b1; res = 1'b1;
    #50 in = 32'b00000000000000000000000000001111; write = 1'b1; res = 1'b1;
    #60 in = 32'b00000000000000000000000000001111; write = 1'b1; res = 1'b0;
    end
    always #5 clk = ~clk;
endmodule
