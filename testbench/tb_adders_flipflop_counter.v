
`timescale 1ns/1ps

module tb;

    reg tb_NumA;
    reg tb_NumB;
    reg tb_Cin;

    wire tb_HalfSum;
    wire tb_HalfCout;
    wire tb_Sum;
    wire tb_Cout;

    reg  [7:0] tb_data_in;
    reg        tb_clk;
    reg        tb_res;

    wire [7:0] tb_data_out;
    wire tb_count0, tb_count1, tb_count2, tb_count3;

    integer i;

    half_adder u_half_adder(
        .NumA(tb_NumA),
        .NumB(tb_NumB),
        .Sum(tb_HalfSum),
        .Cout(tb_HalfCout)
    );

    full_adder u_full_adder(
        .NumA(tb_NumA),
        .NumB(tb_NumB),
        .Cin(tb_Cin),
        .Sum(tb_Sum),
        .Cout(tb_Cout)
    );

    d_flip_flop u_d_flip_flop(
        .data_in(tb_data_in),
        .clk(tb_clk),
        .res(tb_res),
        .data_out(tb_data_out)
    );

    counter u_counter(
        .clk(tb_clk),
        .res(tb_res),
        .count0(tb_count0),
        .count1(tb_count1),
        .count2(tb_count2),
        .count3(tb_count3)
    );

    initial begin
        tb_clk = 1'b0;
        forever #5 tb_clk = ~tb_clk;
    end

    initial begin
        tb_NumA = 0;
        tb_NumB = 0;
        tb_Cin = 0;
        tb_data_in = 8'd0;
        tb_res = 0;

        #2;
        tb_res = 1;

        for (i = 0; i < 8; i = i + 1) begin
            tb_NumA = (i >> 2) & 1;
            tb_NumB = (i >> 1) & 1;
            tb_Cin  = i & 1;
            #10;
        end

        tb_data_in = 8'd1;
        #10;
        tb_data_in = 8'd0;
        #10;
        tb_data_in = 8'd1;
        #10;

        tb_res = 1'b0;
        #10;
        tb_res = 1'b1;
        #76;

        $stop;
    end

endmodule


module tb_counter;

    reg tb_clk;
    reg tb_res;
    wire tb_count0, tb_count1, tb_count2, tb_count3;

    counter u_counter(
        .clk(tb_clk),
        .res(tb_res),
        .count0(tb_count0),
        .count1(tb_count1),
        .count2(tb_count2),
        .count3(tb_count3)
    );

    initial begin
        tb_clk = 1'b0;
        forever #5 tb_clk = ~tb_clk;
    end

    initial begin
        tb_res = 1'b0;
        #12;
        tb_res = 1'b1;
        #200;
        tb_res = 1'b0;
        #20;
        tb_res = 1'b1;
        #50;
        $stop;
    end

endmodule