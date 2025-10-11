`include "defines.svh"
class fifo_read_driver extends uvm_driver #(fifo_seq_item);
  `uvm_component_utils(fifo_read_driver)

  virtual fifo_interface vif;
  fifo_seq_item req;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(virtual fifo_interface)::get(this, "", "vif", vif))
      `uvm_fatal("READ_DRIVER", "Failed to get BFM")
  endfunction

  task run_phase(uvm_phase phase);
    @(vif.drv_cb_read);
    repeat(`no_of_trans) begin
      seq_item_port.get_next_item(req);
         drive();
      seq_item_port.item_done();
    end
  endtask

   task drive();

        @(vif.drv_cb_read);
        vif.rrst_n <= req.rrst_n;
        vif.rinc  <= req.rinc;
        `uvm_info("READ_DRIVER", $sformatf(" From READ DRIVER rrst_n= %0d, rinc= %0d, ",req.rrst_n,req.rinc), UVM_MEDIUM)
        $display("triggereing_______________");

    endtask
endclass
