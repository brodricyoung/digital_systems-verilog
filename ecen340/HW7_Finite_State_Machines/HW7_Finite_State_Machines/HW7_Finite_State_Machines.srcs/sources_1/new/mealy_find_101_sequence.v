`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2025 10:00:57 PM
// Design Name: 
// Module Name: mealy_find_101_sequence
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


// Mealy state machine to assert "found" as true when a 
// sequence of "101" occurs from input signal "data"
module mealy_find_101_sequence(
    input clk, 
    input data, 
    output reg found
    );
    
    // state names
    parameter INIT = 2'b00;
    parameter GOT1 = 2'b01;
    parameter GOT10 = 2'b10;
    
    reg [1:0] next_state;
    reg [1:0] state;
    
    initial state = INIT;

    // next state forming logic
    always @(*) begin
        case(state)
            INIT: 
                if(data) next_state = GOT1;
                else next_state = INIT;
            GOT1:
                if(data) next_state = GOT1;
                else next_state = GOT10;
            GOT10:
                if(data) next_state = GOT1;
                else next_state = INIT;
            default: 
                next_state = INIT;
        endcase
    end
    
    // update the state to the next state at posedge of the clk
    always @(posedge clk) begin
        state <= next_state;
    end
    
    // output forming logic
    always @(*) begin
        case(state)
            INIT:
                found <= 0;
            GOT1:
                found <= 0;
            GOT10:
                // if transitioning from GOT10 to GOT1, assert found as true
                if(next_state == GOT1) found <= 1;
                else found <= 0;
            default: 
                found <= 0;
        endcase
    end
endmodule

