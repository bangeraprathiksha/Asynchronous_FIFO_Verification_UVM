module FIFO_memory #(parameter DATA_SIZE = 8,
    parameter ADDR_SIZE = 2)(
    output [DATA_SIZE-1:0] rdata,
    input [DATA_SIZE-1:0] wdata,
    input [ADDR_SIZE-1:0] waddr, raddr,
    input wclk_en, wfull, wclk
    );

    localparam DEPTH = 1<<ADDR_SIZE;
    reg [DATA_SIZE-1:0] mem [0:DEPTH-1];

    assign rdata = mem[raddr];

    always @(posedge wclk)
        if (wclk_en && !wfull) mem[waddr] <= wdata;

endmodule
