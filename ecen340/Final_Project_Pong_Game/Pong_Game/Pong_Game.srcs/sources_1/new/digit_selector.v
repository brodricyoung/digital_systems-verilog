`timescale 1ns / 1ps
module digit_selector(
    input clkd,
    input btnC,
    input [7:0] sw,              // Switch input for score    
    output reg [3:0] hex_number, // Output hex number to display on the segment
    output reg [3:0] digit_sel   // Which digit to display
);
    reg [3:0] counter = 4'b0001;  // Counter to cycle through digits
    reg [1:0] game_state = 2'b00; // Game state: 00 = normal, 01 = "gg1", 10 = "gg2"
    reg [35:0]delay_counter = 1;
   
    // Always block to cycle through digits
    always @(posedge btnC or posedge clkd) begin
        if (btnC) begin
            counter <= 4'b0001; // Reset the counter
            game_state <= 2'b00; end
        else begin
            counter <= (counter << 1); // Shift left
            if (counter == 4'b1000)
                counter <= 4'b0001; // Wrap back to the first digit
        end
    end

    // Always block to assign hex_number and digit_sel based on game state and counter
    always @(*) begin
        // Determine the game state based on player scores
        if (sw[3:0] >= 10 && game_state != 2'b01) begin
            game_state = 2'b01; // Player 1 reached 10, display "gg1"
        end
        else if (sw[7:4] >= 10 && game_state != 2'b10) begin
            game_state = 2'b10; // Player 2 reached 10, display "gg2"
        end
       
        // Assign hex_number and digit_sel based on the current state and counter
        case (game_state)
            2'b00: begin  // Normal game state, display score
                case (counter)
                    4'b0001: begin
                        hex_number = sw[3:0]; // Display lower 4 bits of sw
                        digit_sel = 4'b1110;
                    end
                    4'b0010: begin
                        hex_number = 4'b1111; // Blank digit
                        digit_sel = 4'b1101;
                    end
                    4'b0100: begin
                        hex_number = sw[7:4]; // Display upper 4 bits of sw
                        digit_sel = 4'b1011;
                    end
                    4'b1000: begin
                        hex_number = 4'b1110; // Blank or no display
                        digit_sel = 4'b0111;
                    end
                endcase
            end
            2'b01: begin  // Player 1 wins, display "gg1"
         
                case (counter)
                    4'b0001: begin
                        hex_number = 4'b1101; // Display 'g'
                        digit_sel = 4'b1110;
                    end
                    4'b0010: begin
                        hex_number = 4'b1101; // Display 'g'
                        digit_sel = 4'b1101;
                    end
                    4'b0100: begin
                        hex_number = 4'b0001; // Display '1'
                        digit_sel = 4'b1011;
                    end
                    4'b1000: begin
                        hex_number = 4'b1110; // Blank
                        digit_sel = 4'b0111;
                    end
                endcase
               
                delay_counter <= delay_counter + 1; // Increment delay counter

                if (delay_counter == 0) begin
                    game_state <= 2'b00;  // Transition back to normal game state
                    delay_counter <= 1;  // Reset the delay counter
                end
            end
            2'b10: begin  // Player 2 wins, display "gg2"
                case (counter)
                    4'b0001: begin
                        hex_number = 4'b1101; // Display 'g'
                        digit_sel = 4'b1110;
                    end
                    4'b0010: begin
                        hex_number = 4'b1101; // Display 'g'
                        digit_sel = 4'b1101;
                    end
                    4'b0100: begin
                        hex_number = 4'b0010; // Display '2'
                        digit_sel = 4'b1011;
                    end
                    4'b1000: begin
                        hex_number = 4'b1110; // Blank
                        digit_sel = 4'b0111;
                    end
                endcase
               
                delay_counter <= delay_counter + 1; // Increment delay counter

                if (delay_counter == 0) begin
                    game_state <= 2'b00;  // Transition back to normal game state
                    delay_counter <= 1;  // Reset the delay counter
                end
            end
        endcase
    end
endmodule
