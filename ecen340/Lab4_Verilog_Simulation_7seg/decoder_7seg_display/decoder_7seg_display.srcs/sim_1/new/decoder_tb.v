`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brodric Young & Karl Richards
// 
// Create Date: 02/14/2025 12:39:43 PM
// Design Name: 
// Module Name: decoder_tb
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


module decoder_tb(
);
    reg [3:0] sw;
    wire [6:0] seg;
    wire [3:0] an = 4'b1110;
    reg clk = 1'b0;
    
    //clock and decoder instantiated
    always #5 clk = ~clk;
    decoder U1 (sw, seg, an);
    
    initial
        begin
            sw = 4'b0000;
            #1000 $finish;
        end
        
    always @ (posedge clk) //Addes 1 to sw every rise of the clock
        begin
            sw = sw + 1;
        end
endmodule