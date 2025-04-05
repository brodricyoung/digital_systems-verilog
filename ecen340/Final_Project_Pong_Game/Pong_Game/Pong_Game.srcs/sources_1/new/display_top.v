`timescale 1ns / 1ps

/**
 * Top module connecting the VGA controller and DRAW module
 */
module display_top(
    input btnC,
    input clk,
    input [3:0] direction,
    output Vsync, Hsync,
    output [3:0] vgaRed, vgaGreen, vgaBlue,
    output [7:0] scorekeeper
    );
   
    wire [1:0] left_direction, right_direction;
    assign right_direction = direction[3:2];
    assign left_direction = direction[1:0];
   
    wire [9:0] x;
    wire [8:0] y;
   
    // VGA display controller
    VGA_DISPLAY U0(
        .clk(clk),
        .reset(btnC),
        .v_sync(Vsync),
        .h_sync(Hsync),
        .x(x),
        .y(y)
    );
   
    // Draw module for game graphics
    DRAW #(
        .X_BIT_SIZE(10),  // Match the actual size from VGA controller
        .Y_BIT_SIZE(9)    // Match the actual size from VGA controller
    ) DRAW_0 (
        .left_direction(left_direction),
        .right_direction(right_direction),
        .clk(clk),
        .reset(btnC),
        .x(x),
        .y(y),
        .R(vgaRed),
        .G(vgaGreen),
        .B(vgaBlue),
        .left_paddle_score(scorekeeper[7:4]),
        .right_paddle_score(scorekeeper[3:0])
    );
endmodule
