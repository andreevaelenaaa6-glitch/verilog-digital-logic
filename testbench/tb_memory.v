
`timescale 1ns/1ps

module tb_all_mem;

    reg tb_clk;
    reg tb_We;
    reg tb_We1;
    reg [7:0] tb_Wdata;
    reg [7:0] tb_Wdata1;
    reg [3:0] tb_Addr;
    reg [3:0] tb_Addr1;

    wire [7:0] async_Rdata;
    wire [7:0] sync_Rdata;
    wire [7:0] port_Rdata;
    wire [7:0] port_Rdata1;

    asyncmem u_asyncmem(
        .We(tb_We),
        .Wdata(tb_Wdata),
        .Addr(tb_Addr),
        .Rdata(async_Rdata)
    );

    syncmem u_syncmem(
        .We(tb_We),
        .clk(tb_clk),
        .Wdata(tb_Wdata),
        .Addr(tb_Addr),
        .Rdata(sync_Rdata)
    );

    portmem u_portmem(
        .We(tb_We),
        .We1(tb_We1),
        .clk(tb_clk),
        .Wdata(tb_Wdata),
        .Wdata1(tb_Wdata1),
        .Addr(tb_Addr),
        .Addr1(tb_Addr1),
        .Rdata(port_Rdata),
        .Rdata1(port_Rdata1)
    );

    initial begin
        tb_clk = 1'b0;
        forever #5 tb_clk = ~tb_clk;
    end

    initial begin
        tb_We = 1'b0;
        tb_We1 = 1'b0;
        tb_Wdata = 8'b00000000;
        tb_Wdata1 = 8'b00000000;
        tb_Addr = 4'b0000;
        tb_Addr1 = 4'b0001;
        #12;

        tb_We = 1'b1;
        tb_Addr = 4'b0011;
        tb_Wdata = 8'b10100101;
        tb_We1 = 1'b1;
        tb_Addr1 = 4'b0101;
        tb_Wdata1 = 8'b00111100;
        #10;
        tb_We = 1'b0;
        tb_We1 = 1'b0;
        #10;

        tb_Addr = 4'b0011;
        tb_Addr1 = 4'b0101;
        #10;

        tb_We = 1'b1;
        tb_Addr = 4'b0111;
        tb_Wdata = 8'b00011110;
        tb_We1 = 1'b1;
        tb_Addr1 = 4'b1001;
        tb_Wdata1 = 8'b00101000;
        #10;
        tb_We = 1'b0;
        tb_We1 = 1'b0;
        #10;

        tb_Addr = 4'b0111;
        tb_Addr1 = 4'b1001;
        #10;

        tb_Addr = 4'b1001;
        tb_Addr1 = 4'b0011;
        #10;

        tb_Addr = 4'b0000;
        tb_Addr1 = 4'b0001;
        #10;

        $stop;
    end

endmodule