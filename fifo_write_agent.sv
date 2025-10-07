class fifo_write_agent extends uvm_agent;
  `uvm_component_utils(fifo_write_agent)
  fifo_write_driver    driver;
  fifo_write_monitor   monitor;
  fifo_write_sequencer sequencer;

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
      sequencer = fifo_write_sequencer::type_id::create("sequencer", this);
      driver    = fifo_write_driver   ::type_id::create("driver", this);
    monitor = fifo_write_monitor::type_id::create("monitor", this);
  endfunction

  function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
