`timescale 1ns / 1ps

module ALU(input [3:0] ALUop,
           input [31:0] ina, inb,
           output reg zero,
           output reg [31:0] out);

    always@(*)
    begin 
        case(ALUop)
            // and
            4'b0000: out <= ina & inb; 
            // or
            4'b0001: out <= ina | inb; 
            // ld, sd, add
            4'b0010: out <= ina + inb;
            // xor
            4'b0011: out <= ina ^ inb;
            // sll, slli
            4'b0100: out <= ina << inb[4:0];
            // srl, srli
            4'b0101: out <= ina >> inb[4:0];
            // beq, bne, sub
            4'b0110: out <= ina - inb;
            // sltu, bltu, bgeu
            4'b0111: begin
                        if (ina < inb)
                            out <= 32'b1;
                        else
                            out <= 32'b0;
                     end
            // slt, blt, bge
            4'b1000: begin
                        if ($signed(ina) < $signed(inb))
                            out <= 32'b1;
                        else
                            out <= 32'b0;
                     end
            // sra, srai
            4'b1001: out <= ina >>> inb[4:0];
            default: out <= 32'b0;
        endcase
        // Check here again
        zero <= (out == 32'b0); 
    end        
endmodule
