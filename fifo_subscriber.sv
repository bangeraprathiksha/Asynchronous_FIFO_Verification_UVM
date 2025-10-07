`include "defines.svh"
`uvm_analysis_imp_decl(_read_mon_cg)

`uvm_analysis_imp_decl(_write_mon_cg)

class fifo_subscriber extends uvm_component;

  `uvm_component_utils(fifo_subscriber)
  uvm_analysis_imp_read_mon_cg#(fifo_seq_item, fifo_subscriber) read_mon_cov_imp;
  uvm_analysis_imp_write_mon_cg#(fifo_seq_item, fifo_subscriber) write_mon_cov_imp;

  fifo_seq_item read_mon;
  fifo_seq_item write_mon;


  covergroup read_mon_cgrp;

    rrst_n_cp : coverpoint read_mon.rrst_n{
      bins rrst_n_on = {1};
      bins rrst_n_off = {0};
    }
    rinc_cp :coverpoint read_mon.rinc {
      bins rinc_on = {1};
      bins rinc_off = {0};
    }
    rdata_cp : coverpoint read_mon.rdata {
      bins read_address_bin = {[0:(1<<`DSIZE)-1]};
    }
    rempty_cp: coverpoint read_mon.rempty{
      bins rempty_on = {1};
      bins rempty_off = {0};
    }
  endgroup

  covergroup write_mon_cgrp;
    wrst_n_cp : coverpoint write_mon.wrst_n {
      bins wrst_n_on = {1};
      bins wrst_n_off = {0};
    }
    winc_cp: coverpoint write_mon.winc{
      bins winc_on = {1};
      bins winc_off = {0};
    }
    wdata_cp : coverpoint write_mon.wdata {
      bins wdata_cg = {[0:`DSIZE-1]};
    }
    wfull_cp : coverpoint write_mon.wfull {
      bins wfull_on = {1};
      bins wfull_off = {0};
    }
  endgroup

  //new constructor
  function new(string name = "fifo_subscriber", uvm_component parent);
    super.new(name,parent);
    read_mon_cov_imp = new("read_mon_cov_imp",this);
    write_mon_cov_imp = new("write_mon_cov_imp",this);
    read_mon_cgrp = new();
    write_mon_cgrp = new();
  endfunction

  function void write_read_mon_cg(fifo_seq_item req);
    read_mon = req;
    read_mon_cgrp.sample();
  endfunction

  function void write_write_mon_cg(fifo_seq_item req);
    write_mon = req;
    write_mon_cgrp.sample();
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    $display("------------------------- READ-COVERAGE ------------------------------");
    $display("");
    $display(" !!!! READ COVERAGE = %0.2f %% !!!!",read_mon_cgrp.get_coverage());
    $display("");
    $display("------------------------- READ-COVERAGE ------------------------------");
    $display("");
    $display("------------------------- WRITE-COVERAGE ------------------------------");
    $display("");
    $display(" !!!!WRITE COVERAGE = %0.2f %% !!!!",write_mon_cgrp.get_coverage());
    $display("");
    $display("------------------------- WRITE-COVERAGE ------------------------------");
  endfunction



endclass
