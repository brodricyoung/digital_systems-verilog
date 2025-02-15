`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brodric Young & Karl Richards
// 
// Create Date: 02/14/2025 12:34:27 PM
// Design Name: 
// Module Name: decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Decode input switch combinations to a hexadecimal digit on the 7segment display
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
// decode switch inputs to display on 7 segment display
module decoder(
    input [3:0] sw, // 4-bit input for digit
    output reg [6:0] seg, // 7-segment display output
    output dp, [3:0] an // Decimal point (set to always off) and Anode control
);

    assign dp = 1'b1; // Decimal point off
    assign an = 4'b1110; // Display the first digit (assuming 4 digits, and enabling the first one)
    
    always @ (sw)
        case (sw)
            4'b0000: seg = 7'b1000000; // 0
            4'b0001: seg = 7'b1111001; // 1
            4'b0010: seg = 7'b0100100; // 2
            4'b0011: seg = 7'b0110000; // 3
            4'b0100: seg = 7'b0011001; // 4
            4'b0101: seg = 7'b0010010; // 5
            4'b0110: seg = 7'b0000010; // 6
            4'b0111: seg = 7'b1111000; // 7
            4'b1000: seg = 7'b0000000; // 8
            4'b1001: seg = 7'b0011000; // 9
            4'b1010: seg = 7'b0001000; // A
            4'b1011: seg = 7'b0000011; // b
            4'b1100: seg = 7'b1000110; // C
            4'b1101: seg = 7'b0100001; // d
            4'b1110: seg = 7'b0000110; // E
            4'b1111: seg = 7'b0001110; // F
        endcase
endmodule