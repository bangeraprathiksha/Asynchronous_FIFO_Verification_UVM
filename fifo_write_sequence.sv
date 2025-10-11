`include "defines.svh"

class fifo_write_sequence extends uvm_sequence#(fifo_seq_item);
  `uvm_object_utils(fifo_write_sequence)

  function new(string name = "fifo_write_sequence");
    super.new(name);
  endfunction

  task body();
    fifo_seq_item req;
        int i=0;

    //Initially applying reset
    req = fifo_seq_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      winc == 1;
      wrst_n == 0;
    });
        `uvm_info("FIFO_WRITE_SEQUENCE",$sformatf("trans{{%0d}} applying wrst_n \n wrst_n=%0d, winc=%0d, wdata=%0d",i, req.wrst_n,  req.winc, req.wdata), UVM_LOW);
    finish_item(req);

    for (int i = 1; i < `no_of_trans; i++) begin
      req = fifo_seq_item::type_id::create($sformatf("req_%0d", i));
      start_item(req);
      assert(req.randomize() with {
        winc == 1;
        wrst_n == 1;
        wdata inside {[0:(1<<`DSIZE)-1]};
      });
        `uvm_info("FIFO_WRITE_SEQUENCE",$sformatf("trans{{%0d}} wrst_n=%0d, winc=%0d, wdata=%0d",i, req.wrst_n,  req.winc, req.wdata), UVM_LOW);
      finish_item(req);
    end
  endtask
endclass
///////////////////////////////////////////////////////////
class fifo_write extends fifo_write_sequence;
  `uvm_object_utils(fifo_write)

  function new(string name = "fifo_write");
    super.new(name);
  endfunction

  task body();
    fifo_seq_item req;
        int i=0;

        //Initially applying reset
    req = fifo_seq_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      winc == 1;
      wrst_n == 0;
    });
        `uvm_info("FIFO_WRITE_SEQUENCE",$sformatf("trans{{%0d}} applying wrst_n \n wrst_n=%0d, winc=%0d, wdata=%0d",i, req.wrst_n,  req.winc, req.wdata), UVM_LOW);
    finish_item(req);
        i++;

    for (int i = 1; i < `no_of_trans; i++) begin
      req = fifo_seq_item::type_id::create($sformatf("req_%0d", i));
      start_item(req);
      assert(req.randomize() with {
        winc == 1;
        wrst_n == 1;
        wdata inside {[0:(1<<`DSIZE)-1]};
      });
        `uvm_info("FIFO_WRITE_SEQUENCE",$sformatf("trans{{%0d}} wrst_n=%0d, winc=%0d, wdata=%0d",i, req.wrst_n,  req.winc, req.wdata), UVM_LOW);
      finish_item(req);
    end
  endtask
endclass


////////////////////////////////////////////////////////////////////////

class fifo_read_only extends fifo_write_sequence;
  `uvm_object_utils(fifo_read_only)

  function new(string name = "fifo_read_only");
    super.new(name);
  endfunction

  task body();
    fifo_seq_item req;
        int i=0;

        //Initially applying reset
    req = fifo_seq_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      winc == 0;
      wrst_n == 0;
    });
        `uvm_info("FIFO_WRITE_SEQUENCE",$sformatf("trans{{%0d}} applying wrst_n \n wrst_n=%0d, winc=%0d, wdata=%0d",i, req.wrst_n,  req.winc, req.wdata), UVM_LOW);
    finish_item(req);
    for (int i = 1; i < `no_of_trans; i++) begin
      req = fifo_seq_item::type_id::create($sformatf("req_%0d", i));
      start_item(req);
      assert(req.randomize() with {
        winc == 0;
        wrst_n == 1;
        wdata inside {[0:(1<<`DSIZE)-1]};
      });
        `uvm_info("FIFO_WRITE_SEQUENCE",$sformatf("trans{{%0d}} wrst_n=%0d, winc=%0d, wdata=%0d",i, req.wrst_n,  req.winc, req.wdata), UVM_LOW);
      finish_item(req);
    end
  endtask
endclass

///////////////////////////////////////////////////////////////////////
class fifo_always_reset_winc_write_sequence extends fifo_write_sequence;
  `uvm_object_utils(fifo_always_reset_winc_write_sequence)

  function new(string name = "fifo_always_reset_winc_write_sequence");
    super.new(name);
  endfunction

  task body();
    fifo_seq_item req;
        int i=0;

        //Initially applying reset
    repeat(`no_of_trans)begin
    req = fifo_seq_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      winc == 0;
      wrst_n == 0;
    });
        `uvm_info("FIFO_WRITE_SEQUENCE",$sformatf("trans{{%0d}} applying wrst_n \n wrst_n=%0d, winc=%0d, wdata=%0d",i, req.wrst_n,  req.winc, req.wdata), UVM_LOW);
    finish_item(req);
        i++;
        end
  endtask
endclass

//////////////////////////////////////////////////////////////////////

class fifo_always_winc_write_sequence extends fifo_write_sequence;
  `uvm_object_utils(fifo_always_winc_write_sequence)

  function new(string name = "fifo_always_winc_write_sequence");
    super.new(name);
  endfunction

  task body();
    fifo_seq_item req;
        int i = 0;
        repeat(`no_of_trans)begin
    req = fifo_seq_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with {
      winc == 0;
      wrst_n == 1;
    });
        `uvm_info("FIFO_WRITE_SEQUENCE", $sformatf("aplying winc as 0 \n trans = [[%0d]],wrst_n=%0d, winc=%0d",i, req.wrst_n, req.winc), UVM_LOW);
    finish_item(req);
        i++;

        end
  endtask
