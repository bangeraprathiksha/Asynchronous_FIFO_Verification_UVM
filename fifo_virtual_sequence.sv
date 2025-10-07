class fifo_virtual_sequence extends uvm_sequence;
  `uvm_object_utils(fifo_virtual_sequence)

  // declare parent sequencer type
  `uvm_declare_p_sequencer(fifo_virtual_sequencer)

  function new(string name = "fifo_virtual_sequence");
    super.new(name);
  endfunction

  task body();
    fifo_write_sequence wseq;
    fifo_read_sequence  rseq;

    wseq = fifo_write_sequence::type_id::create("wseq");
    rseq = fifo_read_sequence::type_id::create("rseq");

    fork
                wseq.start(p_sequencer.write_sqr);
                rseq.start(p_sequencer.read_sqr);
    join
  endtask
endclass
