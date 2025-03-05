`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 03/04/2025 05:43:07 PM
// Design Name:
// Module Name: morse_code_decoder
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


module morse_code_decoder(
    input clk,
    input [5:0] sw,
    input btnD, //Reset
    output [6:0] seg,
    output [4:0] led,
    output dp,
    output [3:0]an
    );
   
    assign an = 4'b1110;        // only the right-most digit display
    
    wire clkdiv;
    reg [4:0] digit_code;       // morse code for the digit to display
    wire [4:0] digit_code_mux;  // Mux between switch value and state machine
    reg [3:0] decoded_digit;    // digit of the morse code
    reg [4:0] next_state;       // counts up from 0-9
   
    //modules
    clk_div #(.count(25)) T1 (.clk(clk), .rst(btnD), .clkd(clkdiv)); 
    decoder_7seg D1 (.sw(decoded_digit), .seg(seg), .dp(dp));
   
    // Instantly take switch value when sw[5] is on, otherwise go 
    // with the digit_code updated at the clk
    assign digit_code_mux = sw[5] ? sw[4:0] : digit_code; 
   
    always @(posedge clkdiv or posedge btnD) begin
        if (btnD) digit_code <= 5'b11111;           // Reset the digit to '0'
        else if (!sw[5]) digit_code <= next_state;  // if switch 5 is down, go to the next state
        else if (sw[5]) digit_code <= sw[4:0];      // if switch 5 is up, next state is value of the input switches
    end 
    
    // decode the morse code into the digit to display and
    // update the next state based on current state of digit_code
    always @* begin
        case (digit_code_mux)
            5'b11111: begin             // '-----' -> 0
                decoded_digit <= 0; 
                if (!sw[5]) next_state = 5'b01111;
                end  
                
            5'b01111: begin             // '.----' -> 1
                decoded_digit <= 1;  
                if (!sw[5]) next_state = 5'b00111;
                end
                
            5'b00111: begin             // '..---' -> 2
                decoded_digit <= 2;
                if (!sw[5]) next_state = 5'b00011;
                end
                
            5'b00011: begin             // '...--' -> 3
                decoded_digit <= 3;
                if (!sw[5]) next_state = 5'b00001;
                end
                
            5'b00001: begin             // '....-' -> 4
                decoded_digit <= 4;
                if (!sw[5]) next_state = 5'b00000;
                end
                
            5'b00000: begin             // '.....' -> 5
                decoded_digit <= 5;
                if (!sw[5]) next_state = 5'b10000;
                end
                
            5'b10000: begin             // '-....' -> 6
                decoded_digit <= 6;
                if (!sw[5]) next_state = 5'b11000;
                end
                
            5'b11000: begin             // '--...' -> 7
                decoded_digit <= 7;
                if (!sw[5]) next_state = 5'b11100;
                end
                
            5'b11100: begin             // '---..' -> 8
                decoded_digit <= 8;
                if (!sw[5]) next_state = 5'b11110;
                end
                
            5'b11110: begin             // '----.' -> 9
                decoded_digit <= 9;
                if (!sw[5]) next_state = 5'b11111;
                end
           
            default: decoded_digit <= 0; // Default to 0 if invalid sequence
        endcase
    end
    
    assign led = digit_code_mux; // display the morse code on the leds (on for dash, off for dot)
endmodule

