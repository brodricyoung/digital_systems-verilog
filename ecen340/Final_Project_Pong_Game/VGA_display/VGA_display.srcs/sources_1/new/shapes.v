`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 06/26/2021 11:14:40 AM
//// Design Name: 
//// Module Name: shapes
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////
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

`define TOP_Y       1
`define BOTTOM_Y    470
`define LEFT_X      1
`define RIGHT_X     629

/**
 *  Add logic to draw different shapes and other desired objects
 */
module DRAW #(
    parameter X_BIT_SIZE = 10, // Used to define the size of the screen in the x direction
    parameter Y_BIT_SIZE = 9   // Used to define the size of the screen in the y direction
)(
    input [1:0] left_direction,
    input [1:0] right_direction,
    input clk,
    input reset,
    input [X_BIT_SIZE-1:0] x,
    input [Y_BIT_SIZE-1:0] y,
    output [3:0] R, G, B,
    output left_paddle_score, right_paddle_score
);

    reg L_paddle_score, R_paddle_score;
    wire [11:0] colors [0:7];
    
    // Parameters for paddle dimensions
    localparam PADDLE_HEIGHT = 75;
    localparam PADDLE_WIDTH = 5;
    localparam PADDLE_SPEED = 5;
    
    // Screen dimensions - ensure compatibility with actual display
    localparam SCREEN_WIDTH = 630;
    localparam SCREEN_HEIGHT = 500;
    
    /////////////////////////////////////////////////////////////////////////
    // left paddle - convert Y_BIT_SIZE to actual Y coordinate
    reg [Y_BIT_SIZE-1:0] y_pos_L;
    // Counter to slow down paddle movement
    reg [19:0] left_move_counter;
    
    // Initialize paddle position (synchronized with reset)
    initial begin
        y_pos_L = 200;
    end
    
    always @(posedge clk) begin
        if (reset) begin
            y_pos_L <= 200;  // Reset position
            left_move_counter <= 0;
        end
        else begin
            left_move_counter <= left_move_counter + 1;
            
            if (ball_move_counter == 0) begin
                // Check if paddle is within screen boundaries
                if (!left_direction[0]) begin  // If movement is enabled (direction[0] = 0)
                    if (!left_direction[1]) begin  // Moving down (direction[1] = 0)
                        if (y_pos_L + PADDLE_HEIGHT + PADDLE_SPEED <= `BOTTOM_Y)
                            y_pos_L <= y_pos_L + PADDLE_SPEED;
                    end
                    else begin  // Moving up (direction[1] = 1)
                        if (y_pos_L - PADDLE_SPEED >= `TOP_Y)
                            y_pos_L <= y_pos_L - PADDLE_SPEED;
                    end
                end
            end
        end
    end
    
    RECTANGLE #(
        .COLOR(`WHITE),
        .HEIGHT(PADDLE_HEIGHT),
        .WIDTH(PADDLE_WIDTH),
        .X_BIT_SIZE(X_BIT_SIZE),
        .Y_BIT_SIZE(Y_BIT_SIZE)
    ) LEFT_PADDLE (
        .X_OFFSET(14),
        .Y_OFFSET(y_pos_L),
        .draw_en(1'b1),
        .x(x),
        .y(y),
        .draw_flag(),
        .color(colors[0])
    ); 
    
    /////////////////////////////////////////////////////////////////////////
    // right paddle
    reg [Y_BIT_SIZE-1:0] y_pos_R;
    // Counter to slow down paddle movement
    reg [19:0] right_move_counter;
    
    // Initialize paddle position (synchronized with reset)
    initial begin
        y_pos_R = 200;
    end
            
    always @(posedge clk) begin
        if (reset) begin
            y_pos_R <= 200;  // Reset position
            right_move_counter <= 0;
        end
        else begin
            right_move_counter <= right_move_counter + 1;
            
            if (ball_move_counter == 0) begin
                // Check if paddle is within screen boundaries
                if (!right_direction[0]) begin  // If movement is enabled (direction[0] = 0)
                    if (!right_direction[1]) begin  // Moving down (direction[1] = 0)
                        if (y_pos_R + PADDLE_HEIGHT + PADDLE_SPEED <= `BOTTOM_Y)
                            y_pos_R <= y_pos_R + PADDLE_SPEED;
                    end
                    else begin  // Moving up (direction[1] = 1)
                        if (y_pos_R - PADDLE_SPEED >= `TOP_Y)
                            y_pos_R <= y_pos_R - PADDLE_SPEED;
                    end
                end
            end
        end
    end
    
    RECTANGLE #(
        .COLOR(`WHITE),
        .HEIGHT(PADDLE_HEIGHT),
        .WIDTH(PADDLE_WIDTH),
        .X_BIT_SIZE(613),
        .Y_BIT_SIZE(Y_BIT_SIZE)
    ) RIGHT_PADDLE (
        .X_OFFSET(613),
        .Y_OFFSET(y_pos_R),
        .draw_en(1'b1),
        .x(x),
        .y(y),
        .draw_flag(),
        .color(colors[1])
    ); 
    
    /////////////////////////////////////////////////////////////////////////
    // Ball with movement logic
    reg [X_BIT_SIZE-1:0] ball_x;
    reg [Y_BIT_SIZE-1:0] ball_y;
    reg ball_x_dir;  // 0: moving right, 1: moving left
    reg ball_y_dir;  // 0: moving down, 1: moving up
    
    // Initialize ball position and direction (synchronized with reset)
    initial begin
        ball_x = SCREEN_WIDTH / 2;
        ball_y = SCREEN_HEIGHT / 2;
        ball_x_dir = 0;
        ball_y_dir = 0;
    end
    
    // Parameters for ball dimensions and speed
    localparam BALL_HEIGHT = 18;
    localparam BALL_WIDTH = 15;
    localparam BALL_SPEED = 2;
    
    // Counter to slow down ball movement
    reg [19:0] ball_move_counter;
    
    // Ball collision detection and movement
    always @(posedge clk) begin
        if (reset) begin
            ball_x <= SCREEN_WIDTH / 2;
            ball_y <= SCREEN_HEIGHT / 2;
            ball_x_dir <= 0;
            ball_y_dir <= 0;
            ball_move_counter <= 0;
        end
        else begin
            // Only update ball position at a slower rate
            ball_move_counter <= ball_move_counter + 1;
            
            if (ball_move_counter == 0) begin
                // Update X position
                if (ball_x_dir == 0) begin  // Moving right
                    if (ball_x + BALL_WIDTH + BALL_SPEED >= SCREEN_WIDTH - 20) begin
                        // Check right paddle collision
                        if (ball_y + BALL_HEIGHT >= y_pos_R && ball_y <= y_pos_R + PADDLE_HEIGHT) begin
                            ball_x_dir <= 1;  // Bounce off paddle
                        end
                        else if (ball_x >= `RIGHT_X) begin // ball_x + BALL_WIDTH
                            // Reset ball to center if it hits right wall (point scored)
                            L_paddle_score = L_paddle_score + 1;
                            ball_x <= SCREEN_WIDTH / 2;
                            ball_y <= SCREEN_HEIGHT / 2;
                            ball_x_dir <= 1;
                        end
                        else begin
                            ball_x <= ball_x + BALL_SPEED;
                        end
                    end
                    else begin
                        ball_x <= ball_x + BALL_SPEED;
                    end
                end
                else begin  // Moving left
                    if (ball_x <= 20) begin
                        // Check left paddle collision
                        if (ball_y + BALL_HEIGHT >= y_pos_L && ball_y <= y_pos_L + PADDLE_HEIGHT) begin
                            ball_x_dir <= 0;  // Bounce off paddle
                        end
                        else if (ball_x <= 2) begin
                            // Reset ball to center if it hits left wall (point scored)
                            R_paddle_score = R_paddle_score + 1;
                            ball_x <= SCREEN_WIDTH / 2;
                            ball_y <= SCREEN_HEIGHT / 2;
                            ball_x_dir <= 0;
                        end
                        else begin
                            ball_x <= ball_x - BALL_SPEED;
                        end
                    end
                    else begin
                        ball_x <= ball_x - BALL_SPEED;
                    end
                end
                
                // Update Y position
                if (ball_y_dir == 0) begin  // Moving down
                    if (ball_y + BALL_HEIGHT + BALL_SPEED >= SCREEN_HEIGHT - 2) begin
                        ball_y_dir <= 1;  // Bounce off bottom
                    end
                    else begin
                        ball_y <= ball_y + BALL_SPEED;
                    end
                end
                else begin  // Moving up
                    if (ball_y <= 2 + BALL_SPEED) begin
                        ball_y_dir <= 0;  // Bounce off top
                    end
                    else begin
                        ball_y <= ball_y - BALL_SPEED;
                    end
                end
            end
        end
    end
    
    assign left_paddle_score = L_paddle_score;
    assign right_paddle_score = R_paddle_score;
    
    RECTANGLE #(
        .COLOR(`BLUE),
        .HEIGHT(BALL_HEIGHT),
        .WIDTH(BALL_WIDTH),
        .X_BIT_SIZE(X_BIT_SIZE),
        .Y_BIT_SIZE(Y_BIT_SIZE)
    ) BALL (
        .X_OFFSET(ball_x),
        .Y_OFFSET(ball_y),
        .draw_en(1'b1),
        .x(x),
        .y(y),
        .draw_flag(),
        .color(colors[2])
    ); 
    
    /////////////////////////////////////////////////////////////////////////
    // borders
    // top
    LINE #(
        .COLOR(`RED),
        .DIR(`HORZ),
        .X_OFFSET(1),
        .Y_OFFSET(`TOP_Y),
        .LENGTH(630),
        .THICKNESS(2),
        .X_BIT_SIZE(X_BIT_SIZE),
        .Y_BIT_SIZE(Y_BIT_SIZE)
    ) TOP_BORDER (
        .draw_en(1'b1),
        .x(x),
        .y(y),
        .draw_flag(),
        .color(colors[3])
    ); 
    
    // bottom
    LINE #(
        .COLOR(`RED),
        .DIR(`HORZ),
        .X_OFFSET(1),
        .Y_OFFSET(`BOTTOM_Y),
        .LENGTH(630),
        .THICKNESS(2),
        .X_BIT_SIZE(X_BIT_SIZE),
        .Y_BIT_SIZE(Y_BIT_SIZE)
    ) BOTTOM_BORDER (
        .draw_en(1'b1),
        .x(x),
        .y(y),
        .draw_flag(),
        .color(colors[4])
    ); 
    
    // left
    LINE #(
        .COLOR(`RED),
        .DIR(`VERT),
        .X_OFFSET(`LEFT_X),
        .Y_OFFSET(1),
        .LENGTH(470),
        .THICKNESS(2),
        .X_BIT_SIZE(X_BIT_SIZE),
        .Y_BIT_SIZE(Y_BIT_SIZE)
    ) LEFT_BORDER (
        .draw_en(1'b1),
        .x(x),
        .y(y),
        .draw_flag(),
        .color(colors[5])
    );
    
    // right
    LINE #(
        .COLOR(`RED),
        .DIR(`VERT),
        .X_OFFSET(`RIGHT_X),
        .Y_OFFSET(1),
        .LENGTH(470),
        .THICKNESS(2),
        .X_BIT_SIZE(X_BIT_SIZE),
        .Y_BIT_SIZE(Y_BIT_SIZE)
    ) RIGHT_BORDER (
        .draw_en(1'b1),
        .x(x),
        .y(y),
        .draw_flag(),
        .color(colors[6])
    );

    assign {R, G, B} = colors[0] | colors[1] | colors[2] | colors[3] | colors[4] | colors[5] | colors[6] | colors[7];

endmodule




/**
 * Module is used to draw a letter on a screen. The letter has a size of 8x16 pixels. 
 * Change the parameters to suit your needs when you instantiate the module.
 */
module ASCII_LETTER #(
    parameter COLOR = `WHITE,  // The color of the letter
    parameter X_OFFSET = 100,  // X location for the top left corner of the letter
    parameter Y_OFFSET = 100,  // Y location for the top left corner of the letter
    parameter X_BIT_SIZE = 10, // Size of the x counter
    parameter Y_BIT_SIZE = 9   // Size of the Y counter
)(
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
    parameter X_BIT_SIZE = 10,
    parameter Y_BIT_SIZE = 9
)(
    input [X_BIT_SIZE-1:0] X_OFFSET,  // Make X_OFFSET an input if needed
    input [Y_BIT_SIZE-1:0] Y_OFFSET,  // Y position is always an input
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