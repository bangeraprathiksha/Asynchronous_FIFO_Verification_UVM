`include "defines.svh"

class fifo_write_sequence extends uvm_sequence#(fifo_seq_item);

        fifo_seq_item req;

        `uvm_object_utils(fifo_write_sequence)

        function new(string name = "fifo_write_sequence");
                super.new(name);
        endfunction
        task body();
                repeat(`no_of_trans) begin
                        fifo_seq_item req;
                        req = fifo_seq_item::type_id::create("req");
                        start_item(req);
                        assert(req.randomize() with {
                                //wrst_n inside { 0, 1};
                                //winc inside { 0, 1};
                                wrst_n == 1;
                                winc == 1;
                                wdata inside {[0:(1<<`DSIZE)-1]};
                        });
                        `uvm_info("FIFO_WRITE_SEQUENCE",$sformatf("wrst_n=%0d, winc=%0d, wdata=%0d", req.wrst_n,  req.winc, req.wdata), UVM_LOW);
                        finish_item(req);
                end
        endtask

endclass
