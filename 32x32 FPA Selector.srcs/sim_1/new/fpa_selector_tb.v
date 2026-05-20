`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.07.2025 15:56:40
// Design Name: 
// Module Name: fpa_selector_tb
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


module fpa_selector_tb;

    reg clk;
    reg rst;
    wire [31:0] row_sel;
    wire [31:0] col_sel;

    // Instantiate the top-level module
    fpa_selector uut (
        .clk(clk),
        .rst(rst),
        .row_sel(row_sel),
        .col_sel(col_sel)
    );

    // Clock generation: 10ns period (100MHz)
    initial clk = 0;
    always #5 clk = ~clk;

    // Stimulus
    initial begin
        rst = 1;
        #20;
        rst = 0;

        #10235;  // simulate enough to cover all 1024 scans
        $finish;
    end

endmodule