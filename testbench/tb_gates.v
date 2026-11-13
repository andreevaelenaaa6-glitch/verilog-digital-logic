
`timescale 1ns/1ps

module tb_gates;

    reg tb_a;
    reg tb_b;

    wire tb_and_out;
    wire tb_or_out;
    wire tb_not_out;
    wire tb_xor_out;
    wire tb_xnor_out;
    wire tb_nand_out;
    wire tb_nor_out;
    wire tb_buf_out;

    integer i;

    and_gate    u_and_gate   (.a(tb_a), .b(tb_b), .and_out(tb_and_out));
    or_gate     u_or_gate    (.a(tb_a), .b(tb_b), .or_out(tb_or_out));
    not_gate    u_not_gate   (.a(tb_a),           .not_out(tb_not_out));
    xor_gate    u_xor_gate   (.a(tb_a), .b(tb_b), .xor_out(tb_xor_out));
    xnor_gate   u_xnor_gate  (.a(tb_a), .b(tb_b), .xnor_out(tb_xnor_out));
    nand_gate   u_nand_gate  (.a(tb_a), .b(tb_b), .nand_out(tb_nand_out));
    nor_gate    u_nor_gate   (.a(tb_a), .b(tb_b), .nor_out(tb_nor_out));
    buffer_gate u_buffer_gate(.a(tb_a),           .buf_out(tb_buf_out));

    initial begin
        tb_a = 1'b0;
        tb_b = 1'b0;

        for (i = 0; i < 4; i = i + 1) begin
            tb_a = (i >> 1) & 1;
            tb_b = i & 1;
            #10;
        end

        $stop;
    end

endmodule