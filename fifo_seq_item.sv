`include "defines.svh"
class fifo_seq_item extends uvm_sequence_item;

  //input
  rand logic wrst_n;
  rand logic rrst_n;
  rand logic winc;
  rand logic rinc;
  rand logic [`DSIZE - 1:0] wdata;

  //output
  rand logic [`DSIZE - 1:0] rdata;
  logic wfull;
  logic rempty;

  `uvm_object_utils_begin(fifo_seq_item)
  `uvm_field_int(wrst_n,UVM_ALL_ON)
  `uvm_field_int(rrst_n,UVM_ALL_ON)
  `uvm_field_int(winc, UVM_ALL_ON)
  `uvm_field_int(rinc, UVM_ALL_ON)
  `uvm_field_int(wdata, UVM_ALL_ON)
  `uvm_field_int(rdata, UVM_ALL_ON)
  `uvm_field_int(wfull,UVM_ALL_ON)
  `uvm_field_int(rempty,UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "fifo_seq_item");
    super.new(name);
  endfunction

endclass
