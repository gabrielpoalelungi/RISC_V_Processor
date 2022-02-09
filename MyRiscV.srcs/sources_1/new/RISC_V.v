`timescale 1ns / 1ps

module RISC_V_IF_ID(input clk,
                    input reset,
                    
                    output [31:0] PC_EX_out,
                    output [31:0] ALU_OUT_EX_out,
                    output [31:0] PC_MEM_out,
                    output PCSrc_out,
                    output [31:0] DATA_MEMORY_MEM_out,
                    output [31:0] ALU_DATA_WB_out,
                    output [1:0] forwardA_out, forwardB_out,
                    output pipeline_stall_out);


        wire [31:0] PC_IF, INSTRUCTION_IF, IMM_EX, REG_DATA1_EX, REG_DATA2_EX;       
        wire [31:0] PC_ID, INSTRUCTION_ID, IMM_ID, REG_DATA1_ID, REG_DATA2_ID;  
        wire [2:0] FUNCT3_ID; 
        wire [6:0] FUNCT7_ID;  
        wire [6:0] OPCODE_ID;     
        wire [4:0] RD_ID, RS1_ID, RS2_ID;    

        wire [2:0] FUNCT3_EX;
        wire [6:0] FUNCT7_EX;
        wire [6:0] OPCODE_EX;
        wire [4:0] RD_EX, RS1_EX, RS2_EX;
        wire RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX;
        wire [1:0] ALUop_EX;
        wire ALUSrc_EX;
        wire Branch_EX;
        wire ZERO_EX;
        wire [31:0] PC_Branch_EX;
        wire [31:0] REG_DATA2_EX_FINAL;

        wire ZERO_MEM;
        wire [31:0] ALU_OUT_MEM;
        wire [31:0] REG_DATA2_MEM_FINAL;
        wire [4:0] RD_MEM;
        wire RegWrite_MEM;
        wire MemtoReg_MEM;
        wire MemRead_MEM;
        wire MemWrite_MEM;
        wire [1:0] ALUop_MEM;
        wire ALUSrc_MEM;
        wire Branch_MEM;

        wire [31:0] read_data_WB;
        wire [31:0] address_WB;
        wire [4:0] RD_WB;
        wire RegWrite_WB;
        wire MemtoReg_WB;

        wire RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID;
        wire [1:0] ALUop_ID;
        wire ALUSrc_ID;
        wire Branch_ID;
        wire PC_write, IF_ID_write;
 
        IF instr_fetch(clk, reset, PCSrc_out, PC_write, PC_MEM_out, PC_IF,INSTRUCTION_IF);
  
        IF_ID_reg pipe1(clk,reset, IF_ID_write, PC_IF,INSTRUCTION_IF, PC_ID,INSTRUCTION_ID);
    
        ID instr_decode(clk, PC_ID, INSTRUCTION_ID, RegWrite_WB, ALU_DATA_WB_out, RD_WB,
                       IMM_ID, REG_DATA1_ID, REG_DATA2_ID, FUNCT3_ID, FUNCT7_ID, OPCODE_ID,
                       RD_ID, RS1_ID, RS2_ID
                       );
                      
        ID_EX_reg pipe2(clk, reset, IMM_ID, REG_DATA1_ID, REG_DATA2_ID, PC_ID, FUNCT3_ID,
                FUNCT7_ID, OPCODE_ID, RD_ID, RS1_ID, RS2_ID, RegWrite_ID, MemtoReg_ID,
                MemRead_ID, MemWrite_ID, ALUop_ID, ALUSrc_ID, Branch_ID,

                IMM_EX, REG_DATA1_EX, REG_DATA2_EX, PC_EX_out, FUNCT3_EX, FUNCT7_EX, OPCODE_EX,
                RD_EX, RS1_EX, RS2_EX, RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX,
                ALUop_EX, ALUSrc_EX, Branch_EX
                );

        EX ex(IMM_EX, REG_DATA1_EX, REG_DATA2_EX, PC_EX_out, FUNCT3_EX, FUNCT7_EX,
                RD_EX, RS1_EX, RS2_EX, RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX,
                ALUop_EX, ALUSrc_EX, Branch_EX,

                forwardA_out,forwardB_out,

                ALU_DATA_WB_out, ALU_OUT_MEM, ZERO_EX, ALU_OUT_EX_out, PC_Branch_EX,
                REG_DATA2_EX_FINAL
                );

                
        EX_MEM_reg pipe3(clk, reset,
                
                ZERO_EX, ALU_OUT_EX_out, PC_Branch_EX, REG_DATA2_EX_FINAL, RD_EX,
                RegWrite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUop_EX, ALUSrc_EX, Branch_EX,
                
                ZERO_MEM, ALU_OUT_MEM, PC_MEM_out, REG_DATA2_MEM_FINAL, RD_MEM, RegWrite_MEM,
                MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, ALUop_MEM, ALUSrc_MEM, Branch_MEM
        );


        forwarding forward(RS1_EX, RS2_EX, RD_MEM, RD_WB, RegWrite_MEM, RegWrite_WB, forwardA_out,forwardB_out);      
                        
        data_memory dataMemory(clk, MemRead_MEM, MemWrite_MEM, ALU_OUT_MEM, REG_DATA2_MEM_FINAL, DATA_MEMORY_MEM_out);        

        assign PCSrc_out = ZERO_MEM & Branch_MEM;

        MEM_WB_reg pipe4(clk, reset,
                        
                DATA_MEMORY_MEM_out, ALU_OUT_MEM, RD_MEM, RegWrite_MEM, MemtoReg_MEM,
                        
                read_data_WB, address_WB, RD_WB, RegWrite_WB, MemtoReg_WB
        );
               
        mux2_1 mux_WB(address_WB, read_data_WB, MemtoReg_WB, ALU_DATA_WB_out);
  
        hazard_detection hazard_detector(RD_EX, RS1_ID, RS2_ID, MemRead_EX,
                                PC_write, IF_ID_write, pipeline_stall_out
        );    
                        
        control_path CONTROL_PATH_MODULE(OPCODE_ID, Branch_ID, MemRead_ID, MemtoReg_ID, ALUop_ID,
                                         MemWrite_ID, ALUSrc_ID, RegWrite_ID
        );   
            
endmodule
