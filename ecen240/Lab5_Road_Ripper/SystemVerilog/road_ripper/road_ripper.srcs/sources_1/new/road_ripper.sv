`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Brodric Young & Karl Richards
//
// Create Date: 10/15/24
// Design Name: 
// Module Name: road_ripper
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Implements a car indicator system with a left and right signal,
//              displaying the car state on a 7-segment display.
//
// Dependencies: None
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module road_ripper_top(
    input logic S,                   // Stop signal input
    input logic L,                   // Left signal input
    input logic R,                   // Right signal input
    input logic clk100MHz,           // 100 MHz clock input
    output logic [3:0] an,           // Anode control for 7-segment displays
    output logic segA, segB, segC,   // 7-segment display segments
    output logic segD, segE, segF,
    output logic segG,
    output logic dp                  // Decimal point control
);

    // Internal signals
    logic clk;                       // Slower clock for driving other modules
    logic LF, LB, RF, RB;            // Signals for left front, left back, right front, and right back lights
    
    // Instantiate the car control logic (Lab5_RR)
    road_ripper U0 (
        .Stop(S), 
        .Left(L), 
        .Right(R), 
        .Clock(clk), 
        .L_Front(LF), 
        .L_Back(LB), 
        .R_Front(RF), 
        .R_Back(RB)
    );

    // Instantiate the clock divider (clk_gen) to generate a slower clock
    clk_gen U1 (
        .clk100MHz(clk100MHz), 
        .clk(clk)
    );

    // Configure the 7-segment display output
    assign an = 4'b1110;  // Enable only the rightmost 7-segment display (active low)
    assign dp = 1'b1;     // Turn off the decimal point (active low)
    assign segA = 1'b1;   // Turn off segment A
    assign segB = !RF;    // Segment B represents the right front light
    assign segC = !RB;    // Segment C represents the right back light
    assign segD = 1'b1;   // Turn off segment D
    assign segE = !LB;    // Segment E represents the left back light
    assign segF = !LF;    // Segment F represents the left front light
    assign segG = 1'b0;   // Turn on the middle segment to indicate the "car" symbol
endmodule

module road_ripper(
    input logic Stop,                // Stop signal input
    input logic Left,                // Left signal input
    input logic Right,               // Right signal input
    input logic Clock,               // Clock input
    output logic L_Front,            // Left front light output
    output logic L_Back,             // Left back light output
    output logic R_Front,            // Right front light output
    output logic R_Back              // Right back light output
);
    // Internal signals for processing inputs and controlling light behavior
    logic in_Left, in_Right;         
    logic Stop_Left, Stop_Right;     
    logic Stop_inRight, Stop_inLeft; 

    // Invert the Left and Right signals
    not (in_Left, Left);
    not (in_Right, Right);

    // Generate intermediate signals based on Stop and inverted inputs
    and (Stop_inLeft, in_Left, Stop);
    and (Stop_Left, Stop, Left);
    and (Stop_Right, Stop, Right);
    and (Stop_inRight, Stop, in_Right);

    // Control the front lights (pulsating with the clock signal)
    and (L_Front, Left, Clock);
    and (R_Front, Clock, Right);

    // Control the back lights based on the combination of inputs
    or (L_Back, L_Front, Stop_inLeft, Stop_Right);
    or (R_Back, R_Front, Stop_inRight, Stop_Left);
endmodule

module clk_gen(
    input logic clk100MHz,           // 100 MHz clock input
    output logic clk                 // Slower clock output
);
    // 26-bit counter to divide the 100 MHz clock
    logic [25:0] count;

    // Output the 26th bit of the counter as the slower clock
    assign clk = count[25];

    // Increment the counter on every rising edge of the 100 MHz clock
    always_ff @(posedge clk100MHz)
        count <= count + 1;
endmodule
