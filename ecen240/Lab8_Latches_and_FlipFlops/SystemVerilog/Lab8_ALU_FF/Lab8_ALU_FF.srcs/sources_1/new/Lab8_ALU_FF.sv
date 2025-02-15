`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brodric Young & Karl Richards
// 
// Create Date: 11/06/24
// Design Name: 
// Module Name: Lab8_ALU_FF
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


module Lab8_ALU_FF(
    input [3:0] A,
    input [3:0] B,
    output logic [3:0] ALU_out_FF,
    input [1:0] S,
    input clk_100MHz,
    output [6:0] seg,
    output [3:0] an,
    output dp
    );
    
    logic clk_slow; 
    logic [3:0] ALU_out;
    
    Lab6_ALU IO (A, B, S, ALU_out);
    clk_div I1 (clk_100MHz, clk_slow, seg, an, dp);
    
    always_ff @ (posedge clk_slow)
        begin
            ALU_out_FF <= ALU_out;
        end 
endmodule
