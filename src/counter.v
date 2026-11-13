
`timescale 1ns/1ps

module counter(
    input clk,
    input res,
    output count0,
    output count1,
    output count2,
    output count3
);
    wire sum0, sum1, sum2, sum3;
    wire c1, c2, c3, c4;

    full_adder u_fa0(
        .NumA(1'b1),
        .NumB(count0),
        .Cin(1'b0),
        .Sum(sum0),
        .Cout(c1)
    );

    full_adder u_fa1(
        .NumA(1'b0),
        .NumB(count1),
        .Cin(c1),
        .Sum(sum1),
        .Cout(c2)
    );

    full_adder u_fa2(
        .NumA(1'b0),
        .NumB(count2),
        .Cin(c2),
        .Sum(sum2),
        .Cout(c3)
    );

    full_adder u_fa3(
        .NumA(1'b0),
        .NumB(count3),
        .Cin(c3),
        .Sum(sum3),
        .Cout(c4)
    );

    d_flip_flop_1bit u_dff0(
        .data_in(sum0),
        .clk(clk),
        .res(res),
        .data_out(count0)
    );

    d_flip_flop_1bit u_dff1(
        .data_in(sum1),
        .clk(clk),
        .res(res),
        .data_out(count1)
    );

    d_flip_flop_1bit u_dff2(
        .data_in(sum2),
        .clk(clk),
        .res(res),
        .data_out(count2)
    );

    d_flip_flop_1bit u_dff3(
        .data_in(sum3),
        .clk(clk),
        .res(res),
        .data_out(count3)
    );
endmodule