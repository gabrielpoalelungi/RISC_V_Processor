`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 02:08:23 PM
// Design Name: 
// Module Name: registers
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


module registers(input clk, reg_write,
                input [4:0] read_reg1, read_reg2, write_reg,
                input [31:0] write_data,
                output reg [31:0] read_data1, read_data2);

    reg [31:0] x[31:0];
    initial begin
        for(integer i = 0; i < 32; i = i + 1) begin
            x[i] = i;
        end
    end
    
    // Citirea in read_data1 de la adresa read_reg1
    always@(read_reg1) begin
        read_data1 <= x[read_reg1];
    end
    
    // Citirea in read_data2 de la adresa read_reg2
    always@(read_reg2) begin
        read_data2 <= x[read_reg2];
    end
    
    // Scrierea la adresa write_reg a valorii write_data
    always@(posedge clk) begin
        if(reg_write) begin
            x[write_reg] <= write_data;
        end
    end
    
endmodule
