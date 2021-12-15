`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 01:13:09 PM
// Design Name: 
// Module Name: test_multiplexor_21
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


module test_multiplexor_21;

    reg [31:0] ina, inb;
    reg sel;
    wire [31:0] out;
    
    mux2_1 m21(ina, inb, sel, out);
    
    initial begin
    #0 ina = 32'b00000000000000000000000000000000; inb = 32'b00000000000000000000000000000010; sel = 0;
    #10 ina = 32'b00000000000000000000000000000000; inb = 32'b00000000000000000000000000000010; sel = 1;
    #10 $finish;
    end
endmodule
