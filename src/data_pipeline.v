
`timescale 1ns/1ps

module data_pipeline(
    input [7:0] Icode,
    input clk,
    input res
);

    wire [7:0] instruction_mem_addr;
    wire [7:0] stage1_addr;
    wire [7:0] stage2_addr;
    wire [7:0] stage3_addr;
    wire [7:0] writeback_addr;

    wire [7:0] writeback_data;
    wire [7:0] memory_data_out;
    wire [7:0] incremented_value;
    wire [7:0] saved_result;

    wire stage1_stage4_match;
    wire stage2_stage4_match;
    wire stage3_stage4_match;
    wire stage1_match_delayed;

    wire [7:0] memory_read_data;
    wire [7:0] mux_output;
    wire [7:0] pipeline_data;


    // Stage 1

    d_flip_flop icode_register(
        .data_in(Icode),
        .clk(clk),
        .res(res),
        .data_out(instruction_mem_addr)
    );

    d_flip_flop addr_s1(
        .data_in(Icode),
        .clk(clk),
        .res(res),
        .data_out(stage1_addr)
    );

    assign stage1_stage4_match = (stage1_addr == writeback_addr);

    d_flip_flop_1bit comparison_register(
        .data_in(stage1_stage4_match),
        .clk(clk),
        .res(res),
        .data_out(stage1_match_delayed)
    );


    // Stage 2

    portmem memory(
        .We(1'b0),
        .We1(1'b1),
        .Wdata(8'b0),
        .Wdata1(writeback_data),
        .Addr(instruction_mem_addr[3:0]),
        .Addr1(writeback_addr[3:0]),
        .Rdata(memory_read_data),
        .Rdata1(),
        .clk(clk)
    );

    d_flip_flop addr_s2(
        .data_in(stage1_addr),
        .clk(clk),
        .res(res),
        .data_out(stage2_addr)
    );

    assign stage2_stage4_match = (stage2_addr == writeback_addr);

    assign mux_output =
        (stage1_match_delayed == 1'b1) ?
        saved_result : memory_read_data;

    assign pipeline_data =
        (stage2_stage4_match == 1'b1) ?
        writeback_data : mux_output;


    // Stage 3

    d_flip_flop mem_register(
        .data_in(pipeline_data),
        .clk(clk),
        .res(res),
        .data_out(memory_data_out)
    );

    d_flip_flop addr_s3_to_addr_s4(
        .data_in(stage2_addr),
        .clk(clk),
        .res(res),
        .data_out(stage3_addr)
    );


    // Stage 4

    assign stage3_stage4_match = (stage3_addr == writeback_addr);

    assign incremented_value =
        (stage3_stage4_match == 1'b1) ?
        (writeback_data + 8'd1) :
        (memory_data_out + 8'd1);

    d_flip_flop result_reg(
        .data_in(incremented_value),
        .clk(clk),
        .res(res),
        .data_out(writeback_data)
    );

    d_flip_flop addr_s4(
        .data_in(stage3_addr),
        .clk(clk),
        .res(res),
        .data_out(writeback_addr)
    );


    // Stage 5

    d_flip_flop result_reg_keeper(
        .data_in(writeback_data),
        .clk(clk),
        .res(res),
        .data_out(saved_result)
    );

endmodule