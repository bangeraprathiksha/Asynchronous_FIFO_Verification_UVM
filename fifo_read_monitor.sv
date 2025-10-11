`include "defines.svh"

class fifo_read_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_read_monitor)

  uvm_analysis_port#(fifo_seq_item) read_ap;
  virtual fifo_interface vif;
 fifo_seq_item t;
uvm_analysis_port #(fifo_seq_item) read_cg_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    read_ap = new("read_ap", this);
        read_cg_port = new("read_cg_port",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif))
      `uvm_fatal("READ_MON", "Virtual interface not found!")
  endfunction

  task run_phase(uvm_phase phase);
//      @(vif.mon_cb_read);
    forever begin
        @(vif.mon_cb_read);
      t = fifo_seq_item::type_id::create("t");
      t.rrst_n  = vif.rrst_n;
      t.rinc    = vif.rinc;
      t.rdata   = vif.rdata;
      t.rempty  = vif.rempty;


      if (t.rrst_n && t.rinc && !t.rempty && t.rdata !== 'x) begin
        `uvm_info("FIFO_READ_MONITOR",
          $sformatf("time[%0t] READ_MONITOR -> rrst_n=%0d | rinc=%0d | rdata=%0d | rempty=%0d",
                    $time, t.rrst_n, t.rinc, t.rdata, t.rempty),
          UVM_MEDIUM)
      end
      else if(t.rempty)begin
          `uvm_info("FIFO_READ_MONITOR", $sformatf("time[%0t] READ_IS_EMPTY -> rrst_n=%0d | rinc=%0d | rdata=%0d | rempty=%0d",$time, t.rrst_n, t.rinc, t.rdata, t.rempty),UVM_MEDIUM)
      end
      else begin
        `uvm_info("FIFO_READ_MONITOR",
          $sformatf("time[%0t] READ_MONITOR -> rrst_n=%0d | rinc=%0d | rdata=%0d | rempty=%0d",
                    $time, t.rrst_n, t.rinc, t.rdata, t.rempty),
          UVM_MEDIUM)
     end


        read_ap.write(t);
        read_cg_port.write(t);
        //repeat(2)@(vif.mon_cb_read);
    end
  endtask
endclass
