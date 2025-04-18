`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2025 01:46:02 PM
// Design Name: 
// Module Name: gray_counter_top
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


module gray_counter_top (
    input clk,
    input btnC,
    output wire [2:0] led
    );
    
    wire clkd;
    
    clock_gen U1 (
        .clk(clk),
        .rst(btnC),
        .clkd(clkd)
        );
        
    gray_counter U2 (
        .clk(clkd),
        .rst(btnC),
        .led(led)
        );
        
        
endmodule

