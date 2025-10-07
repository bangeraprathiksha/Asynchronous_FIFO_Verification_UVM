class fifo_test extends uvm_test;
  `uvm_component_utils(fifo_test)

  fifo_environment env;

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = fifo_environment::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
   fifo_virtual_sequence vseq;
    phase.raise_objection(this);

    vseq = fifo_virtual_sequence::type_id::create("vseq");
    vseq.start(env.vseqr);

    phase.drop_objection(this);
  endtask
endclass

// Write Test

//-------------------------------------------

class fifo_write_test extends fifo_test;

  `uvm_component_utils(fifo_write_test)
   fifo_write_sequence write_seq;

  function new(string name="fifo_write_test", uvm_component parent=null);
    super.new(name,parent);
 endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    write_seq = fifo_write_sequence::type_id::create("write_seq");
    write_seq.start(env.write_agent.sequencer);
    phase.drop_objection(this);
  endtask

endclass


// Read Test

//-------------------------------------------

class fifo_read_test extends fifo_test;

  `uvm_component_utils(fifo_read_test)
  fifo_read_sequence read_seq;

  function new(string name="fifo_read_test", uvm_component parent=null);
    super.new(name,parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    read_seq = fifo_read_sequence::type_id::create("read_seq");
    read_seq.start(env.read_agent.sequencer);
    phase.drop_objection(this);
  endtask

endclass

// Write Then Read Test


//-------------------------------------------

class fifo_reset_test extends fifo_test;
  `uvm_component_utils(fifo_reset_test)

  fifo_virtual_sequence vseq;

  function new(string name="fifo_reset_test", uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this, "Starting test");

    `uvm_info("TEST", "Starting virtual sequence after reset", UVM_LOW)
    vseq = fifo_virtual_sequence::type_id::create("vseq");
    vseq.start(env.vseqr);

    #200;
    phase.drop_objection(this, "Test completed");
  endtask
endclass
