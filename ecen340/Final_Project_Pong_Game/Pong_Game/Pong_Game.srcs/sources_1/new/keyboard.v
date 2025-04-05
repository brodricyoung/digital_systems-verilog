// This module interfaces with a PS/2 keyboard and 
// decodes key presses
//   - Clock divider to generate slower clock
//   - PS2Receiver to read keycodes from the keyboard
//   - Keycode_decoder to map specific keycodes to player actions

`timescale 1ns / 1ps
module keyboard(
    input              clk,       // System clock
    input              PS2Data,   // PS/2 data line
    input              PS2Clk,    // PS/2 clock line
    output wire [3:0]  led        // Output LEDs to show player inputs
);

    // Internal wires and registers
    reg         start = 0;
    reg         CLK50MHZ = 0;     // Simulated 50MHz clock
    wire [15:0] keycode;          // Combined previous and current PS2 scan codes
    wire        flag;             // Flag indicating valid keycode received

    wire [3:0] player;            // Output from decoder, maps to led
    wire game;                    // Start signal from decoder

    // Clock divider: toggles CLK50MHZ on every rising edge of clk
    always @(posedge(clk)) begin
        CLK50MHZ <= ~CLK50MHZ;
    end

    // PS/2 keyboard receiver: extracts scan codes from PS/2 data/clock lines
    PS2Receiver uut (
        .clk(CLK50MHZ),
        .kclk(PS2Clk),
        .kdata(PS2Data),
        .keycode(keycode),
        .oflag(flag)
    );

    // Keycode decoder: maps scan codes to specific player actions or start signal
    Keycode_decoder jeff(
        .keycode(keycode),
        .clk(clk),
        .player1(player[3:2]),
        .player2(player[1:0]),
        .start(game)  
    );

    // LED output driven by player control signals
    assign led = player;
endmodule




///////////////////////////////////////////////////////////////////////////////
// Reads serial data from a PS/2 keyboard, debounces
// clock and data lines, converts data into 8-bit scan codes, and 
// outputs combined 16-bit keycodes (previous + current).
module PS2Receiver(
    input clk,                 // System clock
    input kclk,                // PS/2 clock
    input kdata,               // PS/2 data
    output reg [15:0] keycode = 0, // Output combined keycode
    output reg oflag           // Output flag - goes high when new keycode is ready
);

    wire kclkf, kdataf;
    reg [7:0] datacur = 0;     // Current byte being received
    reg [7:0] dataprev = 0;    // Previous byte
    reg [3:0] cnt = 0;         // Bit counter
    reg flag = 0;              // Internal flag for completed byte

    // Debounce PS/2 clock and data lines
    debouncer #(.COUNT_MAX(19), .COUNT_WIDTH(5)) db_clk  (.clk(clk), .I(kclk),  .O(kclkf));
    debouncer #(.COUNT_MAX(19), .COUNT_WIDTH(5)) db_data (.clk(clk), .I(kdata), .O(kdataf));

    // On falling edge of debounced PS/2 clock, shift in bits of scan code
    always @(negedge(kclkf)) begin
        case(cnt)
            0: ; // Start bit
            1: datacur[0] <= kdataf;
            2: datacur[1] <= kdataf;
            3: datacur[2] <= kdataf;
            4: datacur[3] <= kdataf;
            5: datacur[4] <= kdataf;
            6: datacur[5] <= kdataf;
            7: datacur[6] <= kdataf;
            8: datacur[7] <= kdataf;
            9: flag <= 1'b1; // Stop bit complete
            10: flag <= 1'b0;
        endcase
        if (cnt <= 9) cnt <= cnt + 1;
        else if (cnt == 10) cnt <= 0;
    end

    reg pflag;
    // On rising edge of clk, update keycode if new byte is received
    always @(posedge clk) begin
        if (flag == 1'b1 && pflag == 1'b0) begin
            keycode <= {dataprev, datacur}; // Combine previous and current bytes
            oflag <= 1'b1;
            dataprev <= datacur;
        end else begin
            oflag <= 1'b0;
        end
        pflag <= flag;
    end
endmodule



///////////////////////////////////////////////////////////////////////////////
// Debounces a digital input signal to remove noise.
module debouncer(
    input clk,       // System clock
    input I,         // Input signal
    output reg O     // Debounced output
);
    parameter COUNT_MAX = 255;     // Number of stable samples required
    parameter COUNT_WIDTH = 8;     // Bit-width of counter
    reg [COUNT_WIDTH-1:0] count;
    reg Iv = 0;

    always @(posedge clk)
        if (I == Iv) begin
            if (count == COUNT_MAX) O <= I;
            else count <= count + 1'b1;
        end else begin
            count <= 0;
            Iv <= I;
        end
endmodule


///////////////////////////////////////////////////////////////////////////////
// Decodes PS/2 keycodes into control signals for two 
// players and a game start signal
//   - Arrow keys for player1 (Up/Down)
//   - WASD keys for player2 (W/S)
module Keycode_decoder(
    input [15:0] keycode,     // Combined PS/2 keycode
    input clk,                // System clock
    output reg [1:0] player1, // Player 1 direction (00 = down, 01 = up)
    output reg [1:0] player2, // Player 2 direction (00 = down, 01 = up)
    output reg start          // Game start signal
);

    wire [7:0] jake = keycode[15:8]; // Previous byte
    wire [7:0] josh = keycode[7:0];  // Current byte

    always @(posedge clk) begin
        if (jake == 8'hF0) begin
            // Key released — reset player directions
            player1 <= 2'b10;
            player2 <= 2'b10;
        end else begin
            case (josh)
                8'h75: player1 <= 2'b01;   // Up arrow
                8'h72: player1 <= 2'b00;   // Down arrow
                8'h1D: player2 <= 2'b01;   // 'W' key
                8'h1B: player2 <= 2'b00;   // 'S' key
                8'h25: if (jake == josh) start <= 1; // Start (if pressed)
                8'h76: if (jake == josh) start <= 0; // Stop (if released)
                default: begin
                    player1 <= 2'b10;
                    player2 <= 2'b10;
                end
            endcase
        end
    end
endmodule
