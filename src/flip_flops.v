
`timescale 1ns/1ps

module d_flip_flop(
    input [7:0] data_in,
    input clk,
    input res,
    output reg [7:0] data_out
);
    always @(posedge clk or negedge res) begin
        if (res == 1'b0)
            data_out <= 8'b0;
        else
            data_out <= data_in;
    end
endmodule

module d_flip_flop_1bit(
    input data_in,
    input clk,
    input res,
    output reg data_out
);
    always @(posedge clk or negedge res) begin
        if (res == 1'b0)
            data_out <= 1'b0;
        else
            data_out <= data_in;
    end
endmodule