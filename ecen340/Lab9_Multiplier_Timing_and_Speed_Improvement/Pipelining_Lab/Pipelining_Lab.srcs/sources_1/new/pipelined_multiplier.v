`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/13/2025 01:45:37 PM
// Design Name: 
// Module Name: pipelined_multiplier
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

module pipelined_multiplier(
    input [7:0] x,
    input [7:0] y,
    input clk,
    output [15:0] result
);

    wire [7:0] partialProduct [7:0];  // separate wires for each partial product
    reg [15:0] sum1;         // partialProduct[0] + partialProduct[1]
    reg [15:0] sum2;         // partialProduct[2] + partialProduct[3]
    reg [15:0] sum3;         // partialProduct[4] + partialProduct[5]
    reg [15:0] sum4;         // partialProduct[6] + partialProduct[7]
    reg [15:0] sum1_2;       // sum1 + sum2
    reg [15:0] sum3_4;       // sum3 + sum4
    reg [15:0] sum_total;    // sum1_2 + sum3_4

    // Loop through each bit of y doing an 'AND' operastion with each to
    // either copy x or leave 0's depending on the bit in y
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin
            AND8 U1 (
                .a(x),
                .b(y[i]),
                .out(partialProduct[i])  // Assign each AND8 instance to a separate wire
            );   
        end
    endgenerate
       
    // perform shifts to align the partial products properly before summing
    // then calculate sums in 3 stages
    always @(posedge clk) begin
        sum1 <= (partialProduct[0] << 0) + (partialProduct[1] << 1);
        sum2 <= (partialProduct[2] << 2) + (partialProduct[3] << 3);
        sum3 <=(partialProduct[4] << 4) + (partialProduct[5] << 5);
        sum4 <= (partialProduct[6] << 6) + (partialProduct[7] << 7);
        sum1_2 <= sum1 + sum2;
        sum3_4 <= sum3 + sum4;
        sum_total <= sum1_2 + sum3_4;
    end

    assign result = sum_total;  // Output the accumulated sum on the leds
endmodule


// this module performs a bitwise 'AND' between each 
// bit of 'a' and the single bit of 'b'.
// The result of that is returned as 'out'.
module AND8(
    input [7:0] a,
    input b,
    output [7:0] out
);
    wire [7:0] q; // temporary wire
    and (q[0], a[0], b);
    and (q[1], a[1], b);
    and (q[2], a[2], b);
    and (q[3], a[3], b);
    and (q[4], a[4], b);
    and (q[5], a[5], b);
    and (q[6], a[6], b);
    and (q[7], a[7], b);
    assign out = q;
endmodule

