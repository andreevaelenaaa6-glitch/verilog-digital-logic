
`timescale 1ns/1ps

module asyncmem(
    input We,
    input [7:0] Wdata,
    input [3:0] Addr,
    output [7:0] Rdata
);
    reg [7:0] AsyncMem[0:15];

    always @(*) begin
        if (We)
            AsyncMem[Addr] <= Wdata;
    end

    assign Rdata = AsyncMem[Addr];
endmodule


module syncmem(
    input We,
    input clk,
    input [7:0] Wdata,
    input [3:0] Addr,
    output [7:0] Rdata
);
    reg [7:0] SyncMem[0:15];

    always @(posedge clk) begin
        if (We)
            SyncMem[Addr] <= Wdata;
    end

    assign Rdata = SyncMem[Addr];
endmodule


module portmem(
    input We,
    input We1,
    input clk,
    input [7:0] Wdata,
    input [7:0] Wdata1,
    input [3:0] Addr,
    input [3:0] Addr1,
    output [7:0] Rdata,
    output [7:0] Rdata1
);
    reg [7:0] PortMem[255:0];

    always @(posedge clk) begin
        if (We)
            PortMem[Addr] <= Wdata;
    end

    always @(posedge clk) begin
        if (We1)
            PortMem[Addr1] <= Wdata1;
    end

    assign Rdata  = PortMem[Addr];
    assign Rdata1 = PortMem[Addr1];
endmodule