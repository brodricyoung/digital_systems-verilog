`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2025 02:25:53 PM
// Design Name: 
// Module Name: multiplier_tb
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


module multiplier_tb();

    // Testbench signals
    reg [15:0] sw;  // 16-bit input switch signal
    reg clk;         // Clock input
    wire [15:0] led; // 16-bit output led signal

    // Instantiate the Unit Under Test (UUT)
    // non pipelined test
//    non_pipelined_multiplier uut1 (
//        .y(sw[15:8]),
//        .x(sw[7:0]),
//        .clk(clk),
//        .result(led)
//    );
    
    // pipelined test
    pipelined_multiplier uut2 (
        .y(sw[15:8]),
        .x(sw[7:0]),
        .clk(clk),
        .result(led)
    );
    
    // Clock generation (100 MHz clock)
    always begin
        #5 clk = ~clk; // Toggle clock every 5 time units (100 MHz)
    end

    initial begin
        // Initialize signals
        clk = 0;
        sw = 16'b0;

        // Apply test vectors
        #10 sw = 16'b0000000000000001; // Test case 1: 0 * 1
        #10 sw = 16'b0000000100000010; // Test case 2: 1 * 2
        #10 sw = 16'b0000001100000011; // Test case 3: 3 * 3
        #10 sw = 16'b0000000100010100; // Test case 4: 2 * 20
        #10 sw = 16'b0000001100100100; // Test case 5: 3 * 36
        #10 sw = 16'b1111111100000001; // Test case 6: 255 * 1 (Maximum 8-bit value)
        #10 sw = 16'b1111111101111111; // Test case 7: 255 * 255 (Maximum value multiplication)

        // Wait for a few clock cycles to see the output
        #20;

        // Finish simulation
        $finish;
    end

    // Monitor output (optional, for debugging)
    initial begin
        $monitor("At time %t, sw = %b, led = %b", $time, sw, led);
    end

endmodule
