`timescale 1ns / 1ps

module EX(input [31:0] IMM_EX,         
          input [31:0] REG_DATA1_EX,
          input [31:0] REG_DATA2_EX,
          input [31:0] PC_EX,
          input [2:0] FUNCT3_EX,
          input [6:0] FUNCT7_EX,
          input [4:0] RD_EX,
          input [4:0] RS1_EX,
          input [4:0] RS2_EX,
          input RegWrite_EX,
          input MemtoReg_EX,
          input MemRead_EX,
          input MemWrite_EX,
          input [1:0] ALUop_EX,
          input ALUSrc_EX,
          input Branch_EX,
          input [1:0] forwardA,forwardB,

          input [31:0] ALU_DATA_WB,
          input [31:0] ALU_OUT_MEM,
          
          output ZERO_EX,
          output [31:0] ALU_OUT_EX,
          output [31:0] PC_Branch_EX,
          output [31:0] REG_DATA2_EX_FINAL
          );
          
    wire [31:0] mux41_out;
    wire [31:0] mux42_out;
    wire [31:0] mux23_out;
    wire [3:0] ALUinput;

    mux4_1 mux41(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, 0,
                forwardA, mux41_out);
                      
    mux4_1 mux42(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, 0,
                forwardB, mux42_out);

    mux2_1 mux23(mux42_out, IMM_EX, ALUSrc_EX, mux23_out);

    ALUcontrol ALUctrl(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALUinput);
    
    ALU alu(ALUinput, mux41_out, mux23_out, ZERO_EX, ALU_OUT_EX);             
                         
    assign PC_Branch_EX = PC_EX + IMM_EX;   
    assign REG_DATA2_EX_FINAL = mux42_out;
endmodule
