`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/14/2025 03:33:56 PM
// Design Name: 
// Module Name: four_digit_7seg_display_tb
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

// Full Test Bench
module four_digit_7seg_display_tb();

    reg [15:0] sw;
    reg btnC;
    wire [6:0] seg;
    wire [3:0] an;
    wire dp;
    reg [4:0] JA;
    reg clk;
   
    wire [3:0] hex_number;
    wire clkd;
   
   clk_div U1(.clk(clk), .rst(btnC), .clkd(clkd));
   
   digit_selector U2(.clkd(clkd), .btnC(btnC), .digit_sel(an), .sw(sw), .hex_number(hex_number));
   
   decoder_7seg W4(.sw4(hex_num), .seg(seg), .dp(dp));
   
   
    always begin
        #5 clk = ~clk;  // Generate clock with period of 10 time units
    end
   
    // Initial block for test stimuli and monitoring
    initial begin
        // Initialize inputs
        clk = 0;
        btnC = 0;
        sw = 16'b0001_0001_0001_0001;  // Example switch pattern
         
       
        // Add delay for initial state
        #10;
       
        // Monitor the values
        $monitor("Time = %0t, btnC = %b, sw = %b, clkd = %b, hex_number = %h, an = %b, seg = %b",
                 $time, btnC, sw, clkd, hex_number, an, seg);
       
        // Stimulus
        // Simulate button press reset
        btnC = 1;  // Simulate pressing button
        #10;
        btnC = 0;  // Button released
       
        // Cycle through different switch patterns
        sw = 16'b1111_0000_1111_0000;
        #20;
       
        sw = 16'b0000_1111_0000_1111;
        #20;
       
        sw = 16'b0101_0101_0101_0101;
        #20;
       
        // Final states (adding delays to simulate clock cycles)
        #50;
       
        $finish;  // End the simulation
    end
endmodule

