`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 07:47:23 PM
// Design Name: 
// Module Name: imm_gen
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


module imm_gen(input [31:0] in,
               output reg [31:0] out);

    integer i;
    always@(in) begin
        case (in[6:0])
            // I types for: LW
            7'b0000011:begin
                            for(i = 31; i >= 11; i = i - 1) begin
                                out[i] = in[31];
                            end
                            out[10:5] = in[30:25];
                            out[4:1] = in[24:21];
                            out[0] = in[20];
                       end 
            // S type:SW
            7'b0100011:begin
                            for(i = 31; i >= 11; i = i - 1) begin
                                out[i] = in[31];
                            end
                            out[10:5] = in[30:25];
                            out[4:1] = in[11:8];
                            out[0] = in[7];
                       end 
            // B type: BEQ, BNE, BLT, BGE, BLTU, BGEU
            7'b1100011:begin
                            for(i = 31; i >= 12; i = i - 1) begin
                                out[i] = in[31];
                            end
                            out[11] = in[7];
                            out[10:5] = in[30:25];
                            out[4:1] = in[11:8];
                            out[0] = 0;
                       end 
            // I types for: SLTI, SLTIU, SRLI, SRAI, SLAI,
            // ADDI, ANDI, ORI, XORI
            // TODO: Ask if those with shamt are okay!!
            7'b0010011:begin
                            case(in[14:12])
                                // SRLI, SRAI
                                3'b101:begin
                                            out[4:0] = in[24:20];
                                            for(i = 31; i >= 5; i = i - 1) begin
                                                out[i] = 0;
                                            end
                                       end 
                                // SLLI
                                3'b001:begin
                                            out[4:0] = in[24:20];
                                            for(i = 31; i >= 5; i = i - 1) begin
                                                out[i] = 0;
                                            end
                                       end 
                                // ADDI, ANDI, ORI, XORI, SLTI, SLTIU
                                default: begin
                                            for(i = 31; i >= 11; i = i - 1) begin
                                                out[i] = in[31];
                                            end
                                            out[10:5] = in[30:25];
                                            out[4:1] = in[24:21];
                                            out[0] = in[20];
                                         end
                            endcase
                       end 
            default: out = 0;
        endcase
    end
endmodule
