
`timescale 1ns/1ps

module half_adder(
    input NumA,
    input NumB,
    output Sum,
    output Cout
);
    and_gate u_and_gate(
        .a(NumA),
        .b(NumB),
        .and_out(Cout)
    );

    xor_gate u_xor_gate(
        .a(NumA),
        .b(NumB),
        .xor_out(Sum)
    );
endmodule

module full_adder(
    input NumA,
    input NumB,
    input Cin,
    output Sum,
    output Cout
);
    wire xor_ab;
    wire and_ab;
    wire and_cin;

    xor_gate u_xor1(
        .a(NumA),
        .b(NumB),
        .xor_out(xor_ab)
    );

    xor_gate u_xor2(
        .a(xor_ab),
        .b(Cin),
        .xor_out(Sum)
    );

    and_gate u_and1(
        .a(NumA),
        .b(NumB),
        .and_out(and_ab)
    );

    and_gate u_and2(
        .a(xor_ab),
        .b(Cin),
        .and_out(and_cin)
    );

    or_gate u_or1(
        .a(and_ab),
        .b(and_cin),
        .or_out(Cout)
    );
endmodule