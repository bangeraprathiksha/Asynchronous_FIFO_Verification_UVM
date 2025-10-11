`include "defines.svh"

class fifo_read_sequence extends uvm_sequence#(fifo_seq_item);
  `uvm_object_utils(fifo_read_sequence)

  function new(string name = "fifo_read_sequence");
    super.new(name);
  endfunction

  task body();
    fifo_seq_item req;
        int i = 0;
    req = fifo_seq_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      rinc == 0;
      rrst_n == 0;
    });
        `uvm_info("FIFO_READ_SEQUENCE", $sformatf("aplying rrst_n \n trans = [[%0d]],rrst_n=%0d, rinc=%0d",i, req.rrst_n, req.rinc), UVM_LOW);
    finish_item(req);
        i++;

    for (int i = 1; i < `no_of_trans; i++) begin
      req = fifo_seq_item::type_id::create($sformatf("req_%0d", i));
      start_item(req);
      assert(req.randomize() with {
        rinc == 1;
        rrst_n == 1;
      });
      finish_item(req);
        `uvm_info("FIFO_READ_SEQUENCE", $sformatf("trans = [[%0d]],rrst_n=%0d, rinc=%0d",i, req.rrst_n, req.rinc), UVM_LOW);
    end
  endtask
endclass
/////////////////////////////////////////////////////////////



class fifo_write_only extends fifo_read_sequence;
  `uvm_object_utils(fifo_write_only)

  function new(string name = "fifo_write_only");
    super.new(name);
  endfunction

  task body();
    fifo_seq_item req;
        int i = 0;
    req = fifo_seq_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      rinc == 0;
      rrst_n == 0;
    });
        `uvm_info("FIFO_READ_SEQUENCE", $sformatf("aplying rrst_n \n trans = [[%0d]],rrst_n=%0d, rinc=%0d",i, req.rrst_n, req.rinc), UVM_LOW);
    finish_item(req);
        i++;

    for (int i = 1; i < `no_of_trans; i++) begin
      req = fifo_seq_item::type_id::create("req");
        start_item(req);
      assert(req.randomize() with {
        rinc == 1;
        rrst_n == 0;
      });
      finish_item(req);
        `uvm_info("FIFO_READ_SEQUENCE", $sformatf("rrst_n=%0d, rinc=%0d", req.rrst_n, req.rinc), UVM_LOW);
    end
  endtask
endclass
///////////////////////////////////////////////////////////////////

class fifo_read extends fifo_read_sequence;
  `uvm_object_utils(fifo_read)

  function new(string name = "fifo_read");
    super.new(name);
  endfunction

  task body();
    fifo_seq_item req;
        int i = 0;
    req = fifo_seq_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      rinc == 1;
      rrst_n == 0;
    });
        `uvm_info("FIFO_READ_SEQUENCE", $sformatf("aplying rrst_n \n trans = [[%0d]],rrst_n=%0d, rinc=%0d",i, req.rrst_n, req.rinc), UVM_LOW);
    finish_item(req);
       // i++;

    for (int i = 1; i < `no_of_trans; i++) begin
      req = fifo_seq_item::type_id::create("req");
        start_item(req);
      assert(req.randomize() with {
        rinc == 1;
        rrst_n == 1;
      });
      finish_item(req);
        `uvm_info("FIFO_READ_SEQUENCE", $sformatf("rrst_n=%0d, rinc=%0d", req.rrst_n, req.rinc), UVM_LOW);
    end
  endtask
endclass


class fifo_always_reset_rinc_read_sequence extends fifo_read_sequence;
  `uvm_object_utils(fifo_always_reset_rinc_read_sequence)

  function new(string name = "fifo_always_reset_rinc_read_sequence");
    super.new(name);
  endfunction

  task body();
    fifo_seq_item req;
        int i = 0;
        repeat(`no_of_trans)begin
    req = fifo_seq_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      rinc == 0;
      rrst_n == 0;
    });
        `uvm_info("FIFO_READ_SEQUENCE", $sformatf("aplying rrst_n \n trans = [[%0d]],rrst_n=%0d, rinc=%0d",i, req.rrst_n, req.rinc), UVM_LOW);
    finish_item(req);
        i++;

        end
  endtask
endclass
///////////////////////////////////////////////////////////////////

class fifo_always_rinc_read_sequence extends fifo_read_sequence;
  `uvm_object_utils(fifo_always_rinc_read_sequence)

  function new(string name = "fifo_always_rinc_read_sequence");
    super.new(name);
  endfunction

  task body();
    fifo_seq_item req;
        int i = 0;
        repeat(`no_of_trans)begin
    req = fifo_seq_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      rinc == 0;
      rrst_n == 1;
    });
        `uvm_info("FIFO_READ_SEQUENCE", $sformatf("aplying rrst_n \n trans = [[%0d]],rrst_n=%0d, rinc=%0d",i, req.rrst_n, req.rinc), UVM_LOW);
    finish_item(req);
        i++;

        end
  endtask
endclass
