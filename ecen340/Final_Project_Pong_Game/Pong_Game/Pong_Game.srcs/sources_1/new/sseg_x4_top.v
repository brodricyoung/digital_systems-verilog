`timescale 1ns / 1ps
module sseg_x4_top(
    input btnC,
    input [7:0] scoreboard,
    //input player1,  emergency, og method of scorekeeping
    //input player2,
    input clk,
    output [6:0] seg,
    output [3:0] an,
    output dp,
    output reg [4:0] JA
    );
   
    wire clkd;
    wire [3:0] hex_number;
   
    Clk_Gen U1(.clk(clk), .rst(btnC), .clkd(clkd));
    digit_selector R2(.clkd(clkd), .btnC(btnC), .digit_sel(an), .sw(scoreboard), .hex_number(hex_number));
    // Scoreboard_State SS(.clk(clk), .rst(btnC), .signal1(player1), .signal2(player2), .scoreboard(scoreboard));
    decoder_7seg W4(.sw(hex_number), .seg(seg), .dp(dp));
   
    always @(posedge clk) begin
            JA[4] = clkd;
            JA[3:0] = an;
    end
endmodule

