`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2025 04:31:31 PM
// Design Name: 
// Module Name: memory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 4-bit addressable 16x16-bit memory module with read and write 
//              capabilities. Supports separate write enable (we) and output enable (oe).
//
// Dependencies: None
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// - Implements a simple RAM with synchronous write and read.
// - Data bus is bidirectional, controlled by oe and we signals.
// - When oe is high and we is low, the memory outputs data.
// - When we is high, data is written to memory.
// - If neither reading nor writing, data bus is set to high impedance (Z state).
//
//////////////////////////////////////////////////////////////////////////////////

module memory(
    input clk,             // Clock signal
    input we,              // Write enable: 1 = write to memory
    input oe,              // Output enable: 1 = read from memory
    input [3:0] addr,      // 4-bit address bus (16 locations)
    inout [15:0] data      // 16-bit bidirectional data bus
);

// Memory array: 16 locations, each 16-bit wide
reg [15:0] mem [15:0]; 

// Internal register to hold output data
reg [15:0] data_out;

// Connect data output to data bus when reading, otherwise set to high impedance
assign data = (oe && !we) ? data_out : 16'hZZZZ;

always @(posedge clk) begin
    // Write operation: Store input data into memory at given address
    if (we) begin
        mem[addr] <= data;
    end
end

always @(posedge clk) begin
    // Read operation: Output memory contents to data bus
    if (oe && !we) begin
        data_out <= mem[addr];
    end else begin
        // Set data_out to high impedance when not reading
        data_out <= 16'hZZZZ;
    end
end

endmodule
