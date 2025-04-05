`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/26/2021 11:14:40 AM
// Design Name: 
// Module Name: shapes
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
// keyboard 4-bit input: 
//      most significant two unused
//      bit[0]: moving = 0, not moving = 1
//      bit[1]: going up = 1, going down = 0
//////////////////////////////////////////////////////////////////////////////////
/**
 * Color Values: Used to specify the color of various objects to be drawn
 */
 `define WHITE  12'hFFF
 `define BLACK  12'h000
 `define RED    12'hF00
 `define GREEN  12'h0F0
 `define BLUE   12'h00F
 
/**
 * Shape Settings: Used to set various settings for a shape
 */
`define HORZ    8'h0
`define VERT    8'h1
`define FILL    8'h0
`define NO_FILL 8'h1

module DRAW_ball #(
    parameter X_BIT_SIZE = 10, // Used to define the size of the screen in the x direction
    parameter Y_BIT_SIZE = 9,  // Used to define the size of the screen in the y direction
    parameter SCREEN_WIDTH = 1080,  // Adjust for actual screen size
    parameter SCREEN_HEIGHT = 960, 
    parameter BALL_SIZE = 10,
    parameter PADDLE_X_POS = 30,   // X position of the paddle
    parameter PADDLE_HEIGHT = 50,  // Paddle height
    parameter PADDLE_WIDTH = 10    // Paddle width
)(
    input clk,
    input rst,  // Reset signal
    input [X_BIT_SIZE-1:0] x,
    input [Y_BIT_SIZE-1:0] y,
    input [Y_BIT_SIZE-1:0] paddle_left_y, // Paddle left Y position
    input [Y_BIT_SIZE-1:0] paddle_right_y, // Paddle right Y position
    output [3:0] R, G, B
);

    reg [X_BIT_SIZE-1:0] x_pos = SCREEN_WIDTH / 2;  // Start at middle of screen
    reg [Y_BIT_SIZE-1:0] y_pos = SCREEN_HEIGHT / 2; 

    reg signed [1:0] x_vel = -1;  // Ball moves left initially
    reg signed [1:0] y_vel = 1;   // Ball moves downward initially

    wire [11:0] colors [0:7];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset the ball to the middle
            x_pos <= SCREEN_WIDTH / 2;
            y_pos <= SCREEN_HEIGHT / 2;
            x_vel <= -1;
            y_vel <= 1;
        end else begin
            // Move ball
            x_pos <= x_pos + x_vel;
            y_pos <= y_pos + y_vel;

            // Bounce off top and bottom walls
            if (y_pos <= 0 || (y_pos + BALL_SIZE) >= SCREEN_HEIGHT) begin
                y_vel <= -y_vel; // Reverse Y velocity
            end

            // Check if ball collides with paddle
            if (x_pos <= PADDLE_X_POS + PADDLE_WIDTH && x_pos >= PADDLE_X_POS) begin
                if (y_pos + BALL_SIZE >= paddle_left_y && y_pos <= paddle_left_y + PADDLE_HEIGHT) begin
                    x_vel <= -x_vel; // Bounce off paddle
                end
                if (y_pos + BALL_SIZE >= paddle_right_y && y_pos <= paddle_right_y + PADDLE_HEIGHT) begin
                    x_vel <= -x_vel; // Bounce off paddle
                end
            end

            // Check if the ball passed the paddle (missed)
            if (x_pos <= 0) begin
                // Reset ball if it goes past paddle
                x_pos <= SCREEN_WIDTH / 2;
                y_pos <= SCREEN_HEIGHT / 2;
                x_vel <= -1;
                y_vel <= 1;
            end
        end
    end

    // Draw the ball
    RECTANGLE #(
        .COLOR(`BLUE),
        .HEIGHT(BALL_SIZE),
        .WIDTH(BALL_SIZE),
        .X_BIT_SIZE(X_BIT_SIZE),
        .Y_BIT_SIZE(Y_BIT_SIZE)
    ) RECTANGLE_0 (
        .X_OFFSET(x_pos),
        .Y_OFFSET(y_pos),
        .draw_en(1'b1),
        .x(x),
        .y(y),
        .draw_flag(),
        .color(colors[5])
    ); 

    assign {R, G, B} = colors[5];

endmodule



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// shapes
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Color Values: Used to specify the color of various objects to be drawn
 */
 `define WHITE  12'hFFF
 `define BLACK  12'h000
 `define RED    12'hF00
 `define GREEN  12'h0F0
 `define BLUE   12'h00F
 
/**
 * Shape Settings: Used to set various settings for a shape
 */
`define HORZ    8'h0
`define VERT    8'h1
`define FILL    8'h0
`define NO_FILL 8'h1


//    ASCII_LETTER #(
//            .COLOR(`WHITE),
//            .X_OFFSET(30),
//            .X_BIT_SIZE(X_BIT_SIZE),
//            .Y_BIT_SIZE(Y_BIT_SIZE)
//        ) LETTER_4 (
//            .Y_OFFSET(y_pos + 40),
//            .draw_en(1'b1),
//            .letter("|"),
//            .clk(clk),
//            .x(x),
//            .y(y),
//            .draw_flag(),
//            .color(colors[4])
//        );
//    RECTANGLE #(
//        .COLOR(`BLUE),
//        .X_OFFSET(200),
//        .Y_OFFSET(100),
//        .HEIGHT(25),
//        .WIDTH(25),
//        .X_BIT_SIZE(X_BIT_SIZE),
//        .Y_BIT_SIZE(Y_BIT_SIZE)
//    ) RECTANGLE_0 (
//        .draw_en(1'b1),
//        .x(x),
//        .y(y),
//        .draw_flag(),
//        .color(colors[5])
//    ); 
    
//    LINE #(
//        .COLOR(`GREEN),
//        .DIR(`HORZ),
//        .X_OFFSET(300),
//        .Y_OFFSET(50),
//        .LENGTH(100),
//        .THICKNESS(1),
//        .X_BIT_SIZE(X_BIT_SIZE),
//        .Y_BIT_SIZE(Y_BIT_SIZE)
//    ) LINE_0 (
//        .draw_en(1'b1),
//        .x(x),
//        .y(y),
//        .draw_flag(),
//        .color(colors[6])
//    ); 
    
//    LINE #(
//        .COLOR(`RED),
//        .DIR(`VERT),
//        .X_OFFSET(300),
//        .Y_OFFSET(50),
//        .LENGTH(100),
//        .THICKNESS(1),
//        .X_BIT_SIZE(X_BIT_SIZE),
//        .Y_BIT_SIZE(Y_BIT_SIZE)
//    ) LINE_1 (
//        .draw_en(1'b1),
//        .x(x),
//        .y(y),
//        .draw_flag(),
//        .color(colors[7])
//    ); 


module ASCII_LETTER #(
    parameter COLOR = `WHITE,  // The color of the letter
    parameter X_OFFSET = 100,  // X location for the top left corner of the letter
//    parameter Y_OFFSET = 100,  // Y location for the top left corner of the letter
    parameter X_BIT_SIZE = 10, // Size of the x counter
    parameter Y_BIT_SIZE = 9   // Size of the Y counter
)(
    input [Y_BIT_SIZE-1:0] Y_OFFSET,
    input draw_en, clk,
    input [6:0] letter,
    input [X_BIT_SIZE-1:0] x,
    input [Y_BIT_SIZE-1:0] y,
    output draw_flag,
    output [11:0] color
);

    wire [127:0] bit_map, rev_bit_map;
    wire [7:0] bit_map_arr [0:15];

    reg draw_letter;
    reg [7:0] pixels_to_draw;
    
    genvar i, j, k;
    
    // The bit map comes out flipped accross the x-axis
    BITMAP_ROM ROM (
          .clka(clk),    // input wire clka
          .addra(letter),  // input wire [6 : 0] addra
          .douta(rev_bit_map)  // output wire [127 : 0] douta
    );
    
    // Since it is flipped, we need to flip it back
    for(k = 0; k < 128; k = k + 1)
    begin
       assign bit_map[k] = rev_bit_map[127-k]; 
    end
    
    for(i = 0; i < 16; i = i + 1)
    begin
        assign bit_map_arr[i] = bit_map[(i*8+7):(i*8)];
    end
    
    always@(x, y)
    begin
        if(
            (x >= X_OFFSET && x < X_OFFSET + 8) && 
            (y >= Y_OFFSET && y < Y_OFFSET + 16)
        ) begin
            draw_letter = 1'b1; 
            pixels_to_draw = bit_map_arr[y-Y_OFFSET];
        end
        else begin
            draw_letter = 1'b0;
        end
    end

    assign draw_flag = draw_en ? draw_letter : 1'b0;
    assign color = COLOR & {12{draw_letter & draw_en & pixels_to_draw[x-X_OFFSET]}};
//    assign color = COLOR & {12{bit_map_arr[y][x]}};

endmodule

/**
 *  Draws a rectangle. Modify parameters to change size, shape, color, ect
 */
module RECTANGLE #(
    parameter WIDTH = 100,
    parameter HEIGHT = WIDTH,
    parameter BORDER_SIZE = 2,
    parameter COLOR = `WHITE,
//    parameter X_OFFSET = 100,
//    parameter Y_OFFSET = X_OFFSET,
    parameter X_BIT_SIZE = 10,
    parameter Y_BIT_SIZE = 9
)(
    input X_OFFSET,
    input Y_OFFSET,
    input draw_en,
    input [X_BIT_SIZE-1:0] x,
    input [Y_BIT_SIZE-1:0] y,
    output draw_flag,
    output [11:0] color
);

    reg draw_shape;
    
    always@(x,y)
    begin
        if( (x >= X_OFFSET && x < X_OFFSET + WIDTH) &&
            (y >= Y_OFFSET && y < Y_OFFSET + HEIGHT)
        ) begin
            draw_shape = 1'b1;
        end
        else begin
            draw_shape = 1'b0;
        end
    end

    assign draw_flag = draw_en ? draw_shape : 1'b0;
    assign color = COLOR & {12{draw_shape & draw_en}};

endmodule


/**
 *  Draws a line. Change parameters to modify the line
 */
module LINE #(
    parameter DIR = `HORZ,
    parameter LENGTH = 100,
    parameter THICKNESS = 2,
    parameter COLOR = `WHITE,
    parameter X_OFFSET = 100,
    parameter Y_OFFSET = X_OFFSET,
    parameter X_BIT_SIZE = 10,
    parameter Y_BIT_SIZE = 9
) (
    input draw_en,
    input [X_BIT_SIZE-1:0] x,
    input [Y_BIT_SIZE-1:0] y,
    output draw_flag,
    output [11:0] color
);
    
    reg draw_shape;
    
    always@(x, y) begin
        if(DIR == `HORZ) begin
            if( (x >= X_OFFSET && x < X_OFFSET + LENGTH) &&
                (y >= Y_OFFSET && y < Y_OFFSET + THICKNESS)
            ) begin
                draw_shape = 1'b1;
            end
            else begin
                draw_shape = 1'b0;
            end
        end
        else begin
            if( (x >= X_OFFSET && x < X_OFFSET + THICKNESS) &&
                (y >= Y_OFFSET && y < Y_OFFSET + LENGTH)
            ) begin
                draw_shape = 1'b1;
            end
            else begin
                draw_shape = 1'b0;
            end
        end
    end
    
    assign draw_flag = draw_en ? draw_shape : 1'b0;
    assign color = COLOR & {12{draw_shape & draw_en}};
    
endmodule