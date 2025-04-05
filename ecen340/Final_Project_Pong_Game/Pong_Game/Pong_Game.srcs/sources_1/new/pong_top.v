`timescale 1ns / 1ps
module Pong(
    input clk,
    input btnC,
    input PS2Data,
    input PS2Clk,
    input [15:0] sw,
    output [3:0] led,
    output [3:0] vgaRed,
    output [3:0] vgaBlue,
    output [3:0] vgaGreen,
    output Hsync,
    output Vsync,
    output [6:0] seg,
    output [3:0] an,
    output dp
    );
   
    wire [3:0] keycode;
    reg p1 , p2; // temporary registers to hold values for the inputs of the game for the scoreboard
    wire gamestate;
    wire [7:0] score;

    sseg_x4_top Scoreboard(.btnC(btnC), .scoreboard(score), .clk(clk), .seg(seg), .an(an), .dp(dp));
    
    keyboard sal(.clk(clk), .PS2Data(PS2Data), .PS2Clk(PS2Clk), .led(keycode));
    
    display_top Display(.btnC(btnC), .clk(clk), .direction(keycode), .Vsync(Vsync), .Hsync(Hsync), .vgaRed(vgaRed), .vgaGreen(vgaGreen), .vgaBlue(vgaBlue), .scorekeeper(score)); //score is the scorebaord variable
    
    assign led = keycode;
endmodule

