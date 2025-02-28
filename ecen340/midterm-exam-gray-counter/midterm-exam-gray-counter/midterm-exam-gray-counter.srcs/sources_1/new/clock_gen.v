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
module clock_gen(
    input clk,  // 100MHz
    input rst,
    output clkd // 1.49Hz
    );
   
    // 26-bit counter
    reg [25:0] counter;
    reg temp;

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
                temp <= 1'b0;
            else
                temp <= counter [17]; // 1.49Hz  
        end
        
    assign clkd = temp;
endmodule

