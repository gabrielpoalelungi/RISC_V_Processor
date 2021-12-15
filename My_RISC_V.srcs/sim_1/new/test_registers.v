`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2021 06:07:14 PM
// Design Name: 
// Module Name: test_registers
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


module test_registers;

reg clk, reg_write;
reg [4:0] write_reg, read_reg1, read_reg2;
reg [31:0] write_data;
wire [31:0] read_data1, read_data2;

registers test_registers(clk, reg_write, read_reg1, read_reg2, write_reg, write_data, read_data1, read_data2);

initial begin
    clk = 1;
    // Citesc din registrii x8 si x11 valorile 00000008 si 0000000b
    #20 reg_write = 0;
    read_reg1 = 5'b01000;
    read_reg2 = 5'b01011;
        
    // Scriu la registrul x1 valoarea ffffffff si afisez x1 si x11
    #20 
        reg_write = 1;
        write_reg = 5'b00001;
        write_data = 32'b11111111111111111111111111111111;
        read_reg1 = 5'b00001; // fffff
        read_reg2 = 5'b01011; // 0b
    
    // Scriu la adresa x11 valoarea 88888888 si afisez x1 si x11
    #20 
        reg_write = 1;
        write_reg = 5'b01011;
        write_data = 32'b10001000100010001000100010001000;
        read_reg1 = 5'b00001;
        read_reg2 = 5'b01011;
        
    // Incerc sa scriu la adresa x11 valoarea 99999999, dar nu o sa se inregistreze caci reg_write = 0;
    // Afisez x1 si x11
    #20 
        reg_write = 0;
        write_reg = 5'b01011;
        write_data = 32'b10011001100110011001100110011001;
        read_reg1 = 5'b00001;
        read_reg2 = 5'b01010;  
    #20 
        reg_write = 0;
        write_reg = 5'b01011;
        write_data = 32'b10011001100110011001100110011001;
        read_reg1 = 5'b00001;
        read_reg2 = 5'b01011;
    #20 $finish;
end

always #10 clk = ~clk;
endmodule
