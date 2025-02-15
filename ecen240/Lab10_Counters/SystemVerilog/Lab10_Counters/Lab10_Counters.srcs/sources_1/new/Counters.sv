`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Brodric Young & Karl Richards
//
// Create Date:    11/21/2024 09:20:55 AM
// Design Name:
// Module Name:    Counters
// Project Name:
// Target Devices:
// Tool Versions:
// Description:    This module implements three types of counters: Up/Down counter, 
//                 Ring counter, and Grey code counter. It also includes a 7-segment 
//                 display interface.
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module Counters(
    input reset,                 // Reset signal for all counters
    input down,                  // Control signal to decrement Up/Down counter
    output logic [2:0] Grey_Out, // 3-bit output for Grey code counter
    output logic [2:0] Ring_Out, // 3-bit output for Ring counter
    output logic [2:0] Up_Dn_Out, // 3-bit output for Up/Down counter
    output [6:0] seg,            // 7-segment display segments
    output [3:0] an,             // Anode control for 7-segment display
    output dp,                   // Decimal point control for 7-segment display
    input clk_100MHz             // Input clock at 100 MHz
);

    // Instantiate clock divider to generate a slower clock (clk_slow) for the counters
    clk_div(clk_100MHz, clk_slow, seg, an, dp);

    // Up/Down Counter Logic
    always_ff @(posedge clk_slow or posedge reset) begin
        if (reset)
            Up_Dn_Out <= 3'b000;  // Reset Up/Down counter to 0
        else if (down)
            Up_Dn_Out <= Up_Dn_Out - 1;  // Decrement counter when 'down' is 1
        else
            Up_Dn_Out <= Up_Dn_Out + 1;  // Increment counter when 'down' is 0
    end

    // Ring Counter Logic
    logic [2:0] Next_Qq;
    always_ff @(posedge clk_slow or posedge reset) begin
        if (reset)
            Ring_Out <= 3'b001;  // Initialize Ring counter to 001
        else
            Ring_Out <= Next_Qq; // Update Ring counter
    end

    // Next state logic for Ring counter (circular shifting)
    always_comb begin
        Next_Qq = {Ring_Out[1:0], Ring_Out[2]}; // Rotate the Ring counter left by 1 bit
    end

    // Grey Code Counter Logic
    logic [2:0] Next_Q;
    always_ff @(posedge clk_slow) begin
        if (reset)
            Grey_Out <= 3'b111;  // Initialize Grey code counter to 7 (111)
        else
            Grey_Out <= Next_Q;  // Update Grey code counter
    end

    // Next state logic for Grey code counter
    always_comb begin
        case (Grey_Out)  // Grey code state transitions
            3'h0: Next_Q = 3'h1;
            3'h1: Next_Q = 3'h3;
            3'h2: Next_Q = 3'h6;
            3'h3: Next_Q = 3'h2;
            3'h4: Next_Q = 3'h0;
            3'h5: Next_Q = 3'h4;
            3'h6: Next_Q = 3'h7;
            3'h7: Next_Q = 3'h5;
            default: Next_Q = 3'h0;  // Default case to handle unexpected values
        endcase
    end

endmodule
