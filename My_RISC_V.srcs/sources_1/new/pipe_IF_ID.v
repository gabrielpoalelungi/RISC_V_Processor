`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2021 07:59:03 PM
// Design Name: 
// Module Name: pipe_IF_ID
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


module pipe_IF_ID(input [32:0] PC_IF, INSTRUCTRION_IF,
                  input RESET, clk, IF_ID_WRITE,
                  output reg [32:0] PC_ID, INSTRUCTRION_ID);
    
    always@(posedge clk) begin
        if (RESET) 
            begin
                PC_ID = 0;
                INSTRUCTRION_ID = 0;
            end
        else if(IF_ID_WRITE)
                begin
                    PC_ID = PC_IF;
                    INSTRUCTRION_ID = INSTRUCTRION_IF;
                end
    end
endmodule
