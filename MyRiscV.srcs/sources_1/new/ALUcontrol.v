`timescale 1ns / 1ps

module ALUcontrol(input [1:0] ALUop,
                  input [6:0] funct7,
                  input [2:0] funct3,
                  output reg [3:0] ALUinput);
                  
    always@(ALUop,funct7,funct3) begin
        casex({ALUop,funct7,funct3})
            // ld, sd
            12'b00xxxxxxxxxx: ALUinput = 4'b0010;
            // add
            12'b100000000000: ALUinput = 4'b0010;
            // sub 
            12'b100100000000: ALUinput = 4'b0110;
            // and
            12'b100000000111: ALUinput = 4'b0000;
            // or
            12'b100000000110: ALUinput = 4'b0001;
            // xor 
            12'b100000000100: ALUinput = 4'b0011;
            // srl, srli
            12'b1x000000x101: ALUinput = 4'b0101; 
            // sll, slli
            12'b1x000000x001: ALUinput = 4'b0100; 
            // sra, srai
            12'b1x010000x101: ALUinput = 4'b1001; 
            // sltu
            12'b100000000011: ALUinput = 4'b0111; 
            // slt
            12'b100000000010: ALUinput = 4'b1000; 
            // beq, bne
            12'b01xxxxxxx00x: ALUinput = 4'b0110; 
            // blt, bge 
            12'b01xxxxxxx10x: ALUinput = 4'b1000; 
            // bltu, bgeu
            12'b01xxxxxxx11x: ALUinput = 4'b0111;
            // ori
            12'b11xxxxxxx110: ALUinput = 4'b0001; 
            // addi 
            12'b11xxxxxxx000: ALUinput = 4'b0010; 
        endcase 
    end           
endmodule
