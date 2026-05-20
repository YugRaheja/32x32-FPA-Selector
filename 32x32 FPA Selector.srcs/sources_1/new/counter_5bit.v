`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2025 15:54:39
// Design Name: 
// Module Name: counter_5bit
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


module counter_5bit (
    input clk,
    input rst,
    output reg [4:0] count
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 5'b0;
        else if (count == 5'd31)
            count <= 5'b0;
        else
            count <= count + 1;
    end
endmodule



