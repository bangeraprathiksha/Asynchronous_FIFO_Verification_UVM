class fifo_virtual_sequencer extends uvm_sequencer;
  `uvm_component_utils(fifo_virtual_sequencer)

  // handles to write/read sequencers
  fifo_write_sequencer write_sqr;
  fifo_read_sequencer  read_sqr;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
endclass
