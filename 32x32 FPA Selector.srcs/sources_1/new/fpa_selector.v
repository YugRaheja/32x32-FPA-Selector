module fpa_selector(
    input clk,
    input rst,
    output [31:0] row_sel,
    output [31:0] col_sel
);

    wire [4:0] row_cnt;
    wire [4:0] col_cnt;

    // Column counter (changes every clk cycle)
    counter_5bit col_counter (
        .clk(clk),
        .rst(rst),
        .count(col_cnt)
    );

    // Row counter (changes every 32 cycles)
    reg [4:0] row_counter;
    always @(posedge clk or posedge rst) begin
        if (rst)
            row_counter <= 5'd0;
        else if (col_cnt == 5'd31)
            row_counter <= (row_counter == 5'd31) ? 5'd0 : row_counter + 1;
    end

    assign row_cnt = row_counter;

    // Decoders
    decoder_5to32 row_decoder (
        .in(row_cnt),
        .out(row_sel)
    );

    decoder_5to32 col_decoder (
        .in(col_cnt),
        .out(col_sel)
    );

endmodule
