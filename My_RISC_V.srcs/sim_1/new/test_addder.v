`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2021 03:25:17 PM
// Design Name: 
// Module Name: test_addder
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


module test_addder;

reg [31:0] ina, inb;
wire [31:0] out;

adder test_adder(ina, inb, out);

initial begin
#0 ina = 0; inb = 0;
#10 ina = 1; inb = 2;
#20 ina = 1; inb = 2;
#30 ina = 1; inb = 1;
#40 $finish;
end
endmodule
