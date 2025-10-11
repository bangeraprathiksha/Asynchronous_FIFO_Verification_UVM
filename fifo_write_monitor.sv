`include "defines.svh"

class fifo_write_monitor extends uvm_monitor;
  `uvm_component_utils(fifo_write_monitor)

  uvm_analysis_port#(fifo_seq_item) write_ap;
  virtual fifo_interface vif;
    fifo_seq_item t;
uvm_analysis_port #(fifo_seq_item) write_cg_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    write_ap = new("write_ap", this);
    write_cg_port = new("write_cg_port",this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual fifo_interface)::get(this, "", "vif", vif))
      `uvm_fatal("WRITE_MON", "Virtual interface not found!")
  endfunction

  task run_phase(uvm_phase phase);
//      @(vif.mon_cb_write);
    forever begin
      @(vif.mon_cb_write);
      t = fifo_seq_item::type_id::create("t");
      t.wrst_n  = vif.wrst_n;
      t.winc    = vif.winc;
      t.wdata   = vif.wdata;
      t.wfull   = vif.wfull;

      if (t.wrst_n && t.winc && !t.wfull && (t.wdata !== 'x)) begin
        `uvm_info("FIFO_WRITE_MONITOR",
          $sformatf("time[%0t] WRITE_MONITOR -> wrst_n=%0d |  winc=%0d | wdata=%0d | wfull=%0d",
                    $time, t.wrst_n, t.winc, t.wdata, t.wfull),
          UVM_MEDIUM)
       // write_ap.write(t);
      //write_cg_port.write(t);
      end

      else if(t.wfull)begin

        `uvm_info("SCOREBOARD_WRITE",$sformatf("?????????????FIFO IS FULL CANNOT WRITE FURTHER???????????\n wrst_n=%0d |  winc=%0d | wdata=%0d | wfull = %0d ",t.wrst_n,t.winc,t.wdata, t.wfull),UVM_LOW)
      end
      else begin
         `uvm_info("SCOREBOARD_WRITE",$sformatf(" wrst_n=%0d |  winc=%0d | wdata=%0d | wfull = %0d ",t.wrst_n,t.winc,t.wdata, t.wfull),UVM_LOW)
        end

        write_ap.write(t);
        write_cg_port.write(t);
  end
endtask
endclass
