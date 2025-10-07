`include "defines.svh"

class fifo_read_sequence extends uvm_sequence#(fifo_seq_item);

        fifo_seq_item req;

        `uvm_object_utils(fifo_read_sequence)

        function new(string name = "fifo_read_sequence");
                super.new(name);
        endfunction

        task body();
                repeat(`no_of_trans) begin
                        fifo_seq_item req;
                        req = fifo_seq_item::type_id::create("req");
                        start_item(req);
                        assert(req.randomize() with {
                                //rinc inside {0, 1};
                                //rrst_n inside { 0,1};
                                rinc == 1;
                                rrst_n == 1;
                        });
                        `uvm_info("FIFO_READ_SEQUENCE", $sformatf("rrst_n=%0d, rinc=%0d", req.rrst_n, req.rinc), UVM_LOW);
                        finish_item(req);
                end
        endtask

endclass
