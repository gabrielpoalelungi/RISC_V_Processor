`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 09:03:21 PM
// Design Name: 
// Module Name: test_imm_gen
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


module test_imm_gen;
    reg [31:0] in; 
    wire [31:0] out;
 
    imm_gen test_imm_gen(in,out);
    initial begin 
        // sw x4, 4(x5) == 0042A223
        #0 in = 32'b0000_0000_0100_0010_1010_0010_0010_0011;
        //lw x12,8(x0) == 00802603
        #10 in = 32'b0000_0000_1000_0000_0010_0110_0000_0011;
        //ori x4,x1,1 == 0010E213
        #10 in = 32'b0000_0000_0001_0000_1110_0010_0001_0011;
        //beq x18,x0,5c 04090E63
        #10 in = 32'b0000_0100_0000_1001_0000_1110_0110_0011;
        //addi x1, x1, 1 == 00108093
        #10 in = 32'b0000_0000_0001_0000_1000_0000_1001_0011;
        #10 $finish;
    end
endmodule
