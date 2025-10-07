`include "FIFO.v"
`include "FIFO_memory.v"
`include "rptr_empty.v"
`include "wptr_full.v"
`include "two_ff_sync.v"


`include "uvm_macros.svh"
import uvm_pkg::*;

`include "fifo_pkg.sv"
import fifo_pkg::*;

`include "fifo_interface.sv"
`include "defines.svh"
module top;

  //parameter DSIZE = 8;

  // Clock & Reset
  logic wclk, rclk, wrst_n,rrst_n;
  initial begin
    wclk = 0;
    forever #5  wclk = ~wclk;  // 100 MHz
  end
  initial begin
    rclk = 0;
    forever #10  rclk = ~rclk;  // 50 MHz
  end

  // Instantiate interface
  fifo_interface fifo_if (.wclk(wclk), .rclk(rclk), .wrst_n(wrst_n), .rrst_n(rrst_n));

  // DUT instantiation
  FIFO #( .DSIZE(`DSIZE), .ASIZE(`ASIZE) ) dut (
    .wclk   (wclk),
    .wrst_n (fifo_if.wrst_n),
    .winc   (fifo_if.winc),
    .wdata  (fifo_if.wdata),
    .wfull  (fifo_if.wfull),

    .rclk   (rclk),
    .rrst_n (fifo_if.rrst_n),
    .rinc   (fifo_if.rinc),
    .rdata  (fifo_if.rdata),
    .rempty (fifo_if.rempty)
  );

  // Reset generation
  initial begin
    wrst_n = 0;
    rrst_n = 0;
    #50;
    wrst_n = 1;
    rrst_n = 1;
  end


  //Connect virtual interface to UVM
  initial begin
    uvm_config_db#(virtual fifo_interface)::set(null, "*", "vif", fifo_if);
    run_test("fifo_test");
end
endmodule
