`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brodric Young
// 
// Create Date: 02/6/2025 01:00:43 PM
// Design Name: 
// Module Name: signed_multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: multiplier of signed integer inputs based on switch combinations
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// multiplies two 8 bit numbers input for 16 switches
// displays result on the 16 leds
module signed_multiplier(
    input [15:0] sw,
    output reg [15:0] led
);
    reg[7:0] x;
    reg[7:0] y;
    reg[7:0] productPart[15:0]; // products to be summed together
    reg[15:0] productFinal; // final product
    integer i;
    
    always @(*) begin
        x = sw[7:0]; // x = first half of switches
        y = sw[15:8]; // y = second half of switches
        productFinal <= 16'b0;
        
        // loop through indexes 0 to 7, 8 bits of number
        for(i=0; i<8; i=i+1) begin 
            if (y[i]) // if y[i] is a 1
                productPart[i] = ((x << 8) >> (8-i); // copy x with sign extended to MSB
            else
                productPart[i] = 16'b0; // x is 0
        end
        
        // loop through indexes 0 to 7, 8 product parts
        for(i=0; i<8; i=i+1) begin 
            if(productPart[i][15]) // if product part i has a sign bit of 1
            productPart[i] = ~productPart[i] + 1; // twos compliment
            productFinal = productFinal + productPart[i]; // sum all product parts
        end
        
        led = productFinal; //display final product
    end
endmodule
