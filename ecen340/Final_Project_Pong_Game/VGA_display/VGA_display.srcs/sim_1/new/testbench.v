`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2025 02:49:12 PM
// Design Name: 
// Module Name: testbench
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


module testbench();
    // Testbench signals
    reg clk;
    reg rst;
    wire hsync;
    wire vsync;
    wire [3:0] red, green, blue;

    // Instantiate the top module (DUT)
    top uut (
        .clk(clk),
        .rst(rst),
        .hsync(hsync),
        .vsync(vsync),
        .red(red),
        .green(green),
        .blue(blue)
    );

    // Clock generation (assuming input clock is 100MHz)
    always #5 clk = ~clk;  // 10ns period -> 100MHz

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;

        // Apply reset
        #20 rst = 0;

        // Run simulation for some time
        #2000000 $stop; // Simulate long enough to observe behavior
    end

    // Optional signal monitoring
    initial begin
        $monitor("Time=%t | HSYNC=%b VSYNC=%b RGB=(%h, %h, %h)", 
                 $time, hsync, vsync, red, green, blue);
    end

endmodule

