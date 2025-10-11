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
