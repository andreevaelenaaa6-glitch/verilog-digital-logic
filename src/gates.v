
`timescale 1ns/1ps

module and_gate(
    input a,
    input b,
    output and_out
);
    assign and_out = a & b;
endmodule

module or_gate(
    input a,
    input b,
    output or_out
);
    assign or_out = a | b;
endmodule

module not_gate(
    input a,
    output not_out
);
    assign not_out = ~a;
endmodule

module xor_gate(
    input a,
    input b,
    output xor_out
);
    assign xor_out = a ^ b;
endmodule

module xnor_gate(
    input a,
    input b,
    output xnor_out
);
    assign xnor_out = ~(a ^ b);
endmodule

module nand_gate(
    input a,
    input b,
    output nand_out
);
    assign nand_out = ~(a & b);
endmodule

module nor_gate(
    input a,
    input b,
    output nor_out
);
    assign nor_out = ~(a | b);
endmodule

module buffer_gate(
    input a,
    output buf_out
);
    assign buf_out = a;
endmodule