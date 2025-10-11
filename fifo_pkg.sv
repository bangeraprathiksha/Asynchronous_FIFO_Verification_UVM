package fifo_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

   // sequence item
  `include "fifo_seq_item.sv"

  // sequences
  `include "fifo_write_sequence.sv"
  `include "fifo_read_sequence.sv"

  // write side
  `include "fifo_write_sequencer.sv"
  `include "fifo_write_driver.sv"
  `include "fifo_write_monitor.sv"
  `include "fifo_write_agent.sv"

  // read side
  `include "fifo_read_sequencer.sv"
  `include "fifo_read_driver.sv"
  `include "fifo_read_monitor.sv"
  `include "fifo_read_agent.sv"

  // virtual sequencer/sequence
  `include "fifo_virtual_sequencer.sv"
  `include "fifo_virtual_sequence.sv"


  //coverage
  `include "fifo_subscriber.sv"

  // scoreboard
  `include "fifo_scoreboard.sv"

  // environment
  `include "fifo_environment.sv"

  // test
  `include "fifo_test.sv"

endpackage
