class fifo_virtual_sequence extends uvm_sequence;
  `uvm_object_utils(fifo_virtual_sequence)
  `uvm_declare_p_sequencer(fifo_virtual_sequencer)

  event stop_event;

bit only_write = 0;
bit only_read = 0;
bit write_and_read = 1;
bit reset = 0;
bit only_inc = 0;

  function new(string name = "fifo_virtual_sequence");
    super.new(name);
  endfunction


task body();
  fifo_write_sequence wseq = fifo_write_sequence::type_id::create("wseq");
  fifo_read_sequence rseq = fifo_read_sequence::type_id::create("rseq");

  fifo_always_reset_winc_write_sequence wseq1 = fifo_always_reset_winc_write_sequence::type_id::create("wseq1");
  fifo_always_reset_rinc_read_sequence rseq1 = fifo_always_reset_rinc_read_sequence::type_id::create("rseq1");

  fifo_always_winc_write_sequence wseq3 = fifo_always_winc_write_sequence::type_id::create("wseq3");
  fifo_always_rinc_read_sequence rseq3 = fifo_always_rinc_read_sequence::type_id::create("rseq3");

  fifo_write wseq4 = fifo_write::type_id::create("wseq4");
  fifo_write_only rseq4 = fifo_write_only::type_id::create("rseq4");

  fifo_read_only wseq5 = fifo_read_only::type_id::create("wseq5");
  fifo_read rseq5 = fifo_read::type_id::create("rseq5");



        if(reset)begin
                fork
                        wseq1.start(p_sequencer.write_sqr);
                        rseq1.start(p_sequencer.read_sqr);
                join
        end
        if(only_write)begin
                fork
                        wseq4.start(p_sequencer.write_sqr);
                        rseq4.start(p_sequencer.read_sqr);
                join
        end
        if(only_read)begin
                fork
                        wseq5.start(p_sequencer.write_sqr);
                        rseq5.start(p_sequencer.read_sqr);
                join
        end
        if (write_and_read) begin
                fork
                        wseq.start(p_sequencer.write_sqr);
                        rseq.start(p_sequencer.read_sqr);
                join
        end
        if (only_inc) begin
                fork
                        wseq3.start(p_sequencer.write_sqr);
                        rseq3.start(p_sequencer.read_sqr);
                join
        end



endtask



endclass
