`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: Brodric Young & Karl Richards
//
// Create Date: 11/14/2024 09:30:00 AM
// Design Name:
// Module Name: Register_File
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
module Register_File(
    input [3:0] Data_In,       // 4-bit input data to be written into the register
    input [2:0] WAddr,         // 3-bit address of the register to write to
    input [2:0] RAddr,         // 3-bit address of the register to read from
    input WE,                  // Write Enable: if 1, data is written to register
    input clk_100MHz,          // 100 MHz clock input
    output [3:0] Data_Out,     // 4-bit output data from the register
    output [6:0] seg,          // 7-segment display segments
    output [3:0] an,           // 4-bit anode control for 7-segment display (multiplexing)
    output dp                  // Decimal point control for 7-segment display
);

    clk_div(clk_100MHz, clk, seg, an, dp);
    
    logic [3:0] RegFile [8];            // Define the register file (8 registers, each 4-bits wide)
    assign Data_Out = RegFile[RAddr];   // Assign the value of the register specified by RAddr to Data_Out
    
    // When Write Enable (WE) is active, Data_In is written to the register at WAddr
    always_ff @ (posedge clk)
        if (WE)
            RegFile [WAddr] <= Data_In;
endmodule