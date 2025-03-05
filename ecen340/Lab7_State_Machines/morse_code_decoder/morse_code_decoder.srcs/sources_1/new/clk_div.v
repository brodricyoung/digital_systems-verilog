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
module clk_div #(
    parameter count = 17 // default of 17 is 381.5 Hz
)( 
    input clk,  // 100MHz
    input rst,
    output clkd 
);
   
    // 26-bit counter
    reg [25:0] counter;
    reg clkdiv;

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
                clkdiv <= 1'b0;
            else
                clkdiv <= counter [count];
        end
        
    assign clkd = clkdiv;
endmodule

