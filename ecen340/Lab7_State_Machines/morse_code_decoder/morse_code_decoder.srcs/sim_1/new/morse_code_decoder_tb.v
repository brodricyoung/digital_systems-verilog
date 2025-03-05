`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2025 08:39:51 PM
// Design Name: 
// Module Name: morse_code_decoder_tb
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

module morse_code_decoder_tb();
    
    // Inputs
    reg clk;
    reg [5:0] sw;
    reg btnD;
    
    // Outputs
    wire [6:0] seg;
    wire [4:0] led;
    wire dp;
    wire [3:0] an;
    
    // Instantiate the Unit Under Test (UUT)
    morse_code_decoder uut (
        .clk(clk),
        .sw(sw),
        .btnD(btnD),
        .seg(seg),
        .led(led),
        .dp(dp),
        .an(an)
    );
    
    // Clock generation
    always #5 clk = ~clk; // 10ns period (100MHz clock)
    
    initial begin
        // Initialize Inputs
        clk = 0;
        sw = 6'b000000;
        btnD = 1;
        
        // Reset the system
        #20 btnD = 0;
        
        // Test switch-based input (manual Morse code selection)
        sw = 6'b10000; #20; // Should select '-....' (6)
        sw = 6'b11000; #20; // Should select '--...' (7)
        sw = 6'b11100; #20; // Should select '---..' (8)
        sw = 6'b11110; #20; // Should select '----.' (9)
        sw = 6'b11111; #20; // Should select '-----' (0)
        
        // Test state machine-based progression
        sw = 6'b000000; #20; // Should progress to 5
        #50; // Allow progression through states
        
        // Apply reset again
        btnD = 1; #20;
        btnD = 0; #20;
        
        // Finish simulation
        $finish;
    end
    
endmodule

