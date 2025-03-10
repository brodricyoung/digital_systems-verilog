`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brodric Young & Karl Richards
// 
// Create Date: 02/13/2025 03:13:02 PM
// Design Name: 
// Module Name: four_digit_7seg_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: display all 4 digits of the 7segment display based on input switch combination
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// main module
module sseg_x4_top(
    input [15:0] sw,
    input btnC,
    input clk,
    output [6:0] seg,
    output [3:0] an,
    output dp,
    output reg [4:0] JA
    );
   
    wire clkd;
    wire [3:0] hex_number;
   
    clk_div U1(.clk(clk), .rst(btnC), .clkd(clkd));
   
    digit_selector R2(.clkd(clkd), .btnC(btnC), .digit_sel(an), .sw(sw), .hex_number(hex_number));
   
    decoder_7seg W4(.sw4(hex_number), .seg(seg), .dp(dp));
   
    always @(posedge clk)
        begin
            JA[4] = clkd;
            JA[3:0] = an;
        end
endmodule

