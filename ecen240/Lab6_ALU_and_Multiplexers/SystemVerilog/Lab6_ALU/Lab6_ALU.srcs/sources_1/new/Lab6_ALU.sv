`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brodric Young & Karl Richards
//
// Create Date: 10/23/24
// Design Name: 
// Module Name: Lab6_ALU
// Project Name: 
// Target Devices: Basys 3 FPGA
// Tool Versions: 
// Description: A 4-bit Arithmetic Logic Unit (ALU) with multiple operations, 
//              including addition, AND, OR, and XOR, controlled by a 2-bit selector.
//
// Dependencies: Requires ADD4, AND4, OR4, XOR4, and MUX4bit_4to1 modules.
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

// Top-level ALU module
module Lab6_ALU(
    input logic [3:0] A,         // 4-bit input operand A
    input logic [3:0] B,         // 4-bit input operand B
    input logic [1:0] S,         // 2-bit selector to choose operation
    output logic [3:0] ALU_OUT   // 4-bit output of the ALU
);

    // Internal signals for interconnecting submodules
    logic [3:0] ADD_OUT;         // Output of the 4-bit adder
    logic [3:0] AND_OUT;         // Output of the 4-bit AND gate
    logic [3:0] OR_OUT;          // Output of the 4-bit OR gate
    logic [3:0] XOR_OUT;         // Output of the 4-bit XOR gate

    // Instantiate the ADD4 module for addition
    ADD4 U0 (
        .A(A), 
        .B(B), 
        .out(ADD_OUT)
    );

    // Instantiate the AND4 module for bitwise AND
    AND4 U1 (
        .A(A), 
        .B(B), 
        .out(AND_OUT)
    );

    // Instantiate the OR4 module for bitwise OR
    OR4 U2 (
        .A(A), 
        .B(B), 
        .out(OR_OUT)
    );

    // Instantiate the XOR4 module for bitwise XOR
    XOR4 U3 (
        .A(A), 
        .B(B), 
        .out(XOR_OUT)
    );

    // Instantiate the MUX4bit_4to1 module to select the output based on S
    MUX4bit_4to1 U4 (
        .S(S), 
        .in0(XOR_OUT), 
        .in1(AND_OUT), 
        .in2(OR_OUT), 
        .in3(ADD_OUT), 
        .out(ALU_OUT)
    );

endmodule

// 4-bit Adder module
module ADD4(
    input logic [3:0] A,         // 4-bit input operand A
    input logic [3:0] B,         // 4-bit input operand B
    output logic [3:0] out       // 4-bit output (A + B)
);
    // Perform 4-bit addition
    assign out = A + B; 
endmodule

// 4-bit AND gate module
module AND4(
    input logic [3:0] A,         // 4-bit input operand A
    input logic [3:0] B,         // 4-bit input operand B
    output logic [3:0] out       // 4-bit output (A & B)
);
    // Perform bitwise AND
    assign out = A & B; 
endmodule

// 4-bit OR gate module
module OR4(
    input logic [3:0] A,         // 4-bit input operand A
    input logic [3:0] B,         // 4-bit input operand B
    output logic [3:0] out       // 4-bit output (A | B)
);
    // Perform bitwise OR
    assign out = A | B; 
endmodule

// 4-bit XOR gate module
module XOR4(
    input logic [3:0] A,         // 4-bit input operand A
    input logic [3:0] B,         // 4-bit input operand B
    output logic [3:0] out       // 4-bit output (A ^ B)
);
    // Perform bitwise XOR
    assign out = A ^ B; 
endmodule

// 4-to-1 Multiplexer module for 4-bit inputs
module MUX4bit_4to1(
    input logic [1:0] S,         // 2-bit selector
    input logic [3:0] in0,       // Input for S = 00
    input logic [3:0] in1,       // Input for S = 01
    input logic [3:0] in2,       // Input for S = 10
    input logic [3:0] in3,       // Input for S = 11
    output logic [3:0] out       // 4-bit selected output
);

    logic [3:0] wire1;           // Intermediate output for S[1] = 0
    logic [3:0] wire2;           // Intermediate output for S[1] = 1

    // First stage of multiplexing: Choose between in0/in2 and in1/in3
    assign wire1 = S[1] ? in2 : in0; 
    assign wire2 = S[1] ? in3 : in1; 

    // Second stage of multiplexing: Choose between wire1 and wire2
    assign out = S[0] ? wire2 : wire1;

endmodule
