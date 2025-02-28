`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2025 02:27:24 PM
// Design Name: 
// Module Name: gray_counter_top_tb
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


module gray_counter_top_tb();
    reg clkd;
    wire clkd;
    reg btnC;
    wire [2:0] led;
        
   gray_counter_top U3 (
        .clk(clk),
        .btnC(btnC),
        .led(led)
        );
        
   initial clkd = 0;
     
   always #5 clkd = ~clkd; // 100MHz
    
    initial begin 
        btnC = 1;
        $monitor("At time %t, btnC = %b, led = %b", $time, btnC, led);
        
        #20;
        btnC = 0;
        $monitor("At time %t, btnC = %b, led = %b", $time, btnC, led);
        
        #60 
        btnC = 1;
        $monitor("At time %t, btnC = %b, led = %b", $time, btnC, led);
        
        #20; 
        btnC = 0;
        $monitor("At time %t, btnC = %b, led = %b", $time, btnC, led);
        
        #200;
        btnC = 1;
        $monitor("At time %t, btnC = %b, led = %b", $time, btnC, led);
        
        #20; 
        btnC = 0;
        $monitor("At time %t, btnC = %b, led = %b", $time, btnC, led);
    end
    
    initial #10000 $finish;
endmodule
