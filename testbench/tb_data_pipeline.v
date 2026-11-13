
`timescale 1ns/1ps

module tb_data_pipeline;

    reg [7:0] Icode;
    reg clk = 0;
    reg res;

    data_pipeline dut (
        .Icode(Icode),
        .clk(clk),
        .res(res)
    );

    always #5 clk = ~clk;

    initial begin
        res = 0;
        Icode = 0;

        #12 res = 1;

        #10 Icode = 1;
        #10 Icode = 2;
        #10 Icode = 3;
        #10 Icode = 5;
        #10 Icode = 5;
        #10 Icode = 7;
        #10 Icode = 8;
        #10 Icode = 7;

        #100 $finish;
    end

endmodule