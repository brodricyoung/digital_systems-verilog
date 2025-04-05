`timescale 1ns / 1ps
// module to divide the clock
module Clk_Gen #(

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
    always  @ (posedge clk or posedge rst) begin
            if(rst)
                clkdiv <= 1'b0;
            else
                clkdiv <= counter [count];
        end
    assign clkd = clkdiv;
endmodule
