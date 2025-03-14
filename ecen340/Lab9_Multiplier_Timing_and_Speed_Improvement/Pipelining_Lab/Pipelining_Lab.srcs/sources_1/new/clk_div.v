`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brodric Young & Karl Richards
// 
// Create Date: 02/14/2025 03:16:20 PM
// Design Name: 
// Module Name: clk_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: divide the clock frequency giving a shorter frequency 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// module to divide the clock
module clk_div(
    input clk,  // 100MHz
    input rst,
    output reg clkd // 381Hz
    );
   
   
    // 26-bit counter
    reg [25:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst)
            counter <= 26'b0; // Reset the counter
        else
            counter <= counter + 1'b1; // Increment the counter
    end

    // Output the counter value
    always  @ (posedge clk or posedge rst)
        begin
            if(rst)
                clkd <= 1'b0;
            else
                clkd <= counter [17]; // 381Hz
        end
endmodule

