`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brodric Young & Karl Richards
// 
// Create Date: 02/14/2025 03:21:45 PM
// Design Name: 
// Module Name: digit_selector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: cycles through the 4 digits on the 7seg display to turn them on and
//              selects which hexadecimal number ot display based on input switch combination
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// module to choose which digit is on of the 7seg display and which number to show
module digit_selector(
    input clkd,
    input btnC,
    input [15:0] sw,
    output  reg [3:0] hex_number, 
    output reg [3:0] digit_sel
);
    reg [3:0] counter = 4'b0001;

    always @(posedge btnC, posedge clkd) begin
        if (btnC)
            counter <= 4'b0001; // Reset the counter
        else
        begin
            counter <= (counter << 1); // activate digit to the left
           
            if (counter == 4'b1000)
            counter <= 4'b0001;
           
        end
        // If counter exceeds 4'b0111, wrap back to 4'b0001
       
    end

    // Always block to assign digit_sel based on counter value
 

    // Always block to assign hex_number based on counter value and
    // which of the 4 digits is on (active low)
    always @(*) begin
        case (counter)
            4'b0001: begin  hex_number = sw[3:0]; // rightmost 4 switches 
                            digit_sel = 4'b1110;  // rightmost digit of display
                     end
            4'b0010: begin  hex_number = sw[7:4]; // right 4 switches of middle 8
                            digit_sel = 4'b1101;  // right digit of display of middle 2
                     end
            4'b0100: begin  hex_number = sw[11:8]; // left 4 switches of middle 8
                            digit_sel = 4'b1011;   // left digit of display of middle 2
                     end
            4'b1000: begin  hex_number = sw[15:12]; // leftmost 4 switches
                            digit_sel = 4'b0111;    // leftmost digit of display
                     end
            default: begin  hex_number = 4'b0000;    // Default value
                            digit_sel = 4'b1111;     // No digits active
                     end
               
        endcase
    end
endmodule

