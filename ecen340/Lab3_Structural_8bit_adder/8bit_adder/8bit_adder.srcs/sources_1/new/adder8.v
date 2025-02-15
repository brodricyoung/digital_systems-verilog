`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brodric Young & Karl Richards
//
// Create Date: 01/21/2025 01:55:07 PM
// Design Name: 8-bit Adder
// Module Name: adder8
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: This module implements an 8-bit adder using full adders. The inputs 
//              are split into two 8-bit values, and the result is displayed as a 
//              combined 9-bit output (including carry-out).
//
// Dependencies: fullAdder, half_Adder
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module adder8(
    input [15:0] sw,           // 16-bit switch input: 8 bits for x and 8 bits for y
    output [8:0] led           // 9-bit LED output: 8 bits for sum and 1 bit for carry-out
);


wire [7:0] x;                 // First 8-bit input (right half of switches)
wire [7:0] y;                 // Second 8-bit input (left half of switches)
wire [7:0] sum;               // Sum output (8 bits)
wire [7:0] carry;             // Carry signals for each bit
wire cout;                    // Final carry-out signal

// Assign inputs to x and y from the switch array
assign x = sw[7:0];           // Lower 8 switches as x
assign y = sw[15:8];          // Upper 8 switches as y
assign carry[0] = 0;          // Initial carry-in is set to 0

// Generate block to instantiate 8 full adders
genvar i;
generate
    for (i = 0; i <= 7; i = i + 1) begin
        fullAdder FA_i (
            .A(x[i]),         
            .B(y[i]),         
            .Cin(carry[i]),   
            .sum(sum[i]),     
            .Cout(carry[i+1]) 
        );
    end
endgenerate

// Assign the final carry-out
assign cout = carry[8];

// Combine the carry-out and sum into a single output for LEDs
assign led = {cout, sum};

endmodule

//////////////////////////////////////////////////////////////////////////////////
// Half Adder Module
// Performs addition of two 1-bit inputs and outputs the sum and carry.
//////////////////////////////////////////////////////////////////////////////////
module half_Adder(
    input A, B,                // 1-bit inputs
    output S1, S0              // Outputs: S1 = sum, S0 = carry
);
    xor (S1, A, B);            // Sum = A XOR B
    and (S0, A, B);            // Carry = A AND B
endmodule

//////////////////////////////////////////////////////////////////////////////////
// Full Adder Module
// Combines two 1-bit inputs and a carry-in to produce a sum and carry-out.
//////////////////////////////////////////////////////////////////////////////////
module fullAdder(
    input A, B, Cin,           // 1-bit inputs: A, B, and carry-in
    output sum, Cout           // Outputs: sum and carry-out
);
    wire sum1, carry1, carry2; // Intermediate wires

    // First half adder
    half_Adder HA1(
        .A(A),
        .B(B),
        .S1(sum1),
        .S0(carry1)
    );

    // Second half adder
    half_Adder HA2(
        .A(sum1),
        .B(Cin),
        .S1(sum),
        .S0(carry2)
    );

    // Combine carry outputs
    or (Cout, carry1, carry2); // Final carry-out = carry1 OR carry2
endmodule
