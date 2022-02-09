`timescale 1ns / 1ps

module mux2_1(input [31:0] ina, inb,
              input sel,
              output reg [31:0] out);
  
  always@(ina, inb ,sel) begin
    case(sel)
      1'b0: out = ina;
      1'b1: out = inb;
    endcase
  end

endmodule


