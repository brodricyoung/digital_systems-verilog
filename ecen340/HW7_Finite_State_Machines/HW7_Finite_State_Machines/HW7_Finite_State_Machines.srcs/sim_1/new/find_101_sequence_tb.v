`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2025 09:41:03 PM
// Design Name: 
// Module Name: find_101_sequence_tb
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

module moore_find_101_sequence_tb();
     // Testbench signals
    reg clk;
    reg data;
    wire found;

    // Instantiate the Unit Under Test (UUT)
    moore_find_101_sequence uut (
        .clk(clk),
        .data(data),
        .found(found)
    );

    // Clock generation: 10ns period (100MHz)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        data = 0;
        
        // Apply test cases
        $display("Starting test...");

        #10 data = 1;  // Input '1'
        #10 data = 0;  // Input '0'
        #10 data = 1;  // Input '1' -> should detect "101"
        #10 data = 1;  // Input '1'
        #10 data = 0;  // Input '0'
        #10 data = 1;  // Input '1' -> should detect "101" again
        #10 data = 0;  // Input '0'
        #10 data = 0;  // Input '0' (invalid sequence)
        #10 data = 1;  // Input '1'
        #10 data = 0;  // Input '0'
        #10 data = 1;  // Input '1' -> should detect "101"
        
        // Finish simulation
        #20;
        $display("Test completed.");
        $stop;
    end
endmodule

