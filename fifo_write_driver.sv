`include "defines.svh"
class fifo_write_driver extends uvm_driver #(fifo_seq_item);
  `uvm_component_utils(fifo_write_driver)

  virtual fifo_interface vif;
  event write_event;
  fifo_seq_item req;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(virtual fifo_interface)::get(this, "", "vif", vif))
      `uvm_fatal("WRITE_DRIVER", "Failed to get BFM")
  endfunction

  task run_phase(uvm_phase phase);
    repeat(1) @(vif.drv_cb_write);
        repeat(`no_of_trans) begin
      seq_item_port.get_next_item(req);
         drive();
      seq_item_port.item_done();
    end
  endtask

   task drive();
        @(vif.drv_cb_write);
        vif.wrst_n <= req.wrst_n;
        vif.winc  <= req.winc;
        vif.wdata <= req.wdata;
        `uvm_info("WRITE_DRIVER", $sformatf("From WRITE DRIVER wrst_n= %0d, winc= %0d, wdata=%0d ",req.wrst_n,req.winc, req.wdata), UVM_MEDIUM)
        //@(vif.drv_cb_write);
   endtask
endclass
