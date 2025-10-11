
`include "defines.svh"
interface fifo_interface(input logic wclk, input logic rclk);
        logic wrst_n;
        logic rrst_n;
        logic winc;
        logic rinc;
        logic [`DSIZE -1 :0] wdata;
        //output
        logic [`DSIZE -1 :0] rdata;
        logic rempty;
        logic wfull;

        clocking drv_cb_write @(posedge wclk);
                output wrst_n , winc, wdata;
        endclocking

        clocking mon_cb_write @(posedge wclk);
                input #1ns wrst_n, winc, wdata, wfull; // sample after 1-ns
        endclocking

        clocking drv_cb_read @(posedge rclk);
                output rrst_n, rinc;
        endclocking

        clocking mon_cb_read @(posedge rclk);
                input #1ns rrst_n, rinc, rdata, rempty;
        endclocking


        modport DRV_WRITE( clocking drv_cb_write);

        modport DRV_READ( clocking drv_cb_read);

        modport MON_WRITE( clocking mon_cb_write);

        modport MON_READ( clocking mon_cb_read);

        //assertion checks

        //valid inputs
property one;
  @(posedge wclk) disable iff(!wrst_n)
    !$isunknown({winc, wdata});
endproperty

assert property(one)
  $info("++++++++++ VALID WRITE INPUTS");
else
  $error("++++++++ INVALID WRITE INPUTS");

property two;
  @(posedge rclk) disable iff(!rrst_n)
    !$isunknown(rinc);
endproperty

assert property(two)
  $info("++++++++++ VALID READ INPUTS");
else
  $error("++++++++++ INVALID READ INPUTS");


         // clock toggle

property three;
  @(posedge wclk) wclk != $past(1,wclk);
endproperty

assert property(three)
  $info("wclk is toggling");
else
  $error("wclk not toggling");


property four;
@(posedge rclk) rclk != $past(1, rclk);
endproperty

assert property(four)
  $info("rclk is toggling");
else
  $error("rclk is not toggling");


         // reset check
// Write reset clears full flag
property five;
  @(posedge wclk) (!wrst_n) |-> (!wfull);
endproperty

assert property(five)
  $info("wrst_n reset check passed");
else
  $error("wrst_n reset check FAILED");


// Read reset makes FIFO empty
property six;
  @(posedge rclk) (!rrst_n) |-> (rempty);
endproperty

assert property(six)
  $info("rrst_n reset check passed");
else
  $error("rrst_n reset check FAILED");



endinterface
