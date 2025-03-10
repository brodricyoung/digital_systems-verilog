`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2025 04:51:42 PM
// Design Name: 
// Module Name: memory_tb
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

module memory_tb;
    // Declare testbench variables
    reg clk;                // Clock signal
    reg we;                 // Write enable
    reg oe;                 // Output enable
    reg [3:0] addr;        // 4-bit address for memory locations (16 addresses)
    reg [15:0] data_in;    // 16-bit Data input for write
    wire [15:0] data;      // 16-bit Data wire for read (inout is now a wire)

    memory uut (
        .clk(clk),
        .we(we),
        .oe(oe),
        .addr(addr),
        .data(data)
    );

    always #5 clk = ~clk;  // 100 MHz clock (period = 10ns)

    initial begin
        clk = 0;
        we = 0;               // Write Enable (initially disabled)
        oe = 0;               // Output Enable (initially disabled)
        addr = 4'b0000;       // Start with address 0
        data_in = 16'h0000;   // Start with data value 0x0000
        #10;

        // Test 1: Write data to address 0
        we = 1;               // Enable write
        addr = 4'b0000;       // Set address to 0
        data_in = 16'hA5A5;   // Set data to write (0xA5A5)
        #10;                  // Wait 10ns

        // Test 2: Read data from address 0
        we = 0;               // Disable write
        oe = 1;               // Enable output (read)
        addr = 4'b0000;       // Set address to 0 (where we wrote data)
        #10;                  // Wait 10ns

        // Test 3: Write data to address 1
        we = 1;               // Enable write
        oe = 0;               // Disable output
        addr = 4'b0001;       // Set address to 1
        data_in = 16'h3C3C;   // Set data to write (0x3C3C)
        #10;                  // Wait 10ns

        // Test 4: Read data from address 1
        we = 0;               // Disable write
        oe = 1;               // Enable output (read)
        addr = 4'b0001;       // Set address to 1 (where we wrote data)
        #10;                  // Wait 10ns

        // Test 5: Write data to multiple addresses
        we = 1;               // Enable write
        addr = 4'b0010;       // Set address to 2
        data_in = 16'h7F7F;   // Set data to write (0x7F7F)
        #10;
       
        addr = 4'b0011;       // Set address to 3
        data_in = 16'h9C9C;   // Set data to write (0x9C9C)
        #10;

        addr = 4'b0100;       // Set address to 4
        data_in = 16'hF0F0;   // Set data to write (0xF0F0)
        #10;
       
        // Test 6: Read all addresses
        we = 0;               // Disable write
        oe = 1;               // Enable output (read)
        addr = 4'b0010;       // Read from address 2
        #10;
       
        addr = 4'b0011;       // Read from address 3
        #10;
       
        addr = 4'b0100;       // Read from address 4
        #10;
       
        // Test 7: Edge case - Write at maximum address (4'b1111)
        we = 1;               // Enable write
        addr = 4'b1111;       // Set address to the maximum value (0xF)
        data_in = 16'hABAB;   // Set data to write (0xABAB)
        #10;

        // Test 8: Read from maximum address
        we = 0;               // Disable write
        oe = 1;               // Enable output (read)
        addr = 4'b1111;       // Read from maximum address
        #10;

        // Test 9: Verify that no data is output when we is high but oe is low
        we = 1;               // Enable write
        oe = 0;               // Disable output
        addr = 4'b0010;       // Set address to 2
        data_in = 16'h1234;   // Set data to write (0x1234)
        #10;
       
        $finish;
    end
   
    // Tri-state buffer control for data line
    // If output enable (oe) is active, drive data_in to data bus, otherwise high-Z
    assign data = oe ? data_in : 16'hZZZZ; 
endmodule

