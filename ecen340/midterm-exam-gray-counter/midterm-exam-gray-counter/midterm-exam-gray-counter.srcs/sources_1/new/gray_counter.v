`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/25/2025 01:46:02 PM
// Design Name: 
// Module Name: gray_counter
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

//Create "gray_counter" module
//This module will implement the gray code counter. When implementing the counter, use the following
//structure:
//  • All three flip-flops will be implemented with one "always" block. The inputs to the flip-flops
//will be the "next_state" (or input forming) logic. Use one of the push-button switches to
//reset the flip-flops.

//  • The input forming logic will be designed using a separate "always" statement (procedural
//format), or by using an "assign" statement for each next_state variable (data flow format).

//  • The count will be displayed on 3 LEDs, and the count will increment slow enough to be seen
//and verified.


module gray_counter(
    input clk,
    input rst,
    output [2:0] led
    );
    
    wire [2:0] next_state;
    reg [2:0] current_state;
    
    // next state forming logic
    assign next_state[2] = (~current_state[1] & current_state[0]) | (current_state[1] & ~current_state[0]);
    assign next_state[1] = (~current_state[2] & current_state[1]) | (current_state[2] & current_state[0]);
    assign next_state[0] = (~current_state[2] & ~current_state[1]) | (current_state[2] & current_state[0]);
    
    always @(posedge clk or posedge rst) begin
          if(rst) begin
            current_state <= 3'b000; // if reset button is pushed, set current state to 000
          end
          else begin
            current_state <= next_state; // if not reset, set current state to the next state 
        end
    end 
    
    assign led = current_state;
    
endmodule
