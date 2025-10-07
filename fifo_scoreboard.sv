`uvm_analysis_imp_decl(_write)
`uvm_analysis_imp_decl(_read)

class fifo_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(fifo_scoreboard)

  uvm_analysis_imp_write #(fifo_seq_item, fifo_scoreboard) write_imp;
  uvm_analysis_imp_read  #(fifo_seq_item, fifo_scoreboard) read_imp;

  fifo_seq_item ref_q[$]; // queue for expected data
  int match, mismatch;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    write_imp = new("write_imp", this);
    read_imp  = new("read_imp", this);
  endfunction

  // ----------------------------------------------------------------
  // WRITE monitor callback
  // ----------------------------------------------------------------


function void write_write(fifo_seq_item t);
  if (t.wrst_n && t.winc && !t.wfull && !$isunknown(t.wdata)) begin
    ref_q.push_back(t);
    `uvm_info("SCOREBOARD_WRITE",
      $sformatf("PUSH: Stored %0d in ref_q (size=%0d, wfull=%0d)",
                t.wdata, ref_q.size(), t.wfull),
      UVM_LOW)
  end
  else if (t.wfull) begin
    `uvm_info("SCOREBOARD_WRITE",
      "???????? FIFO IS FULL - CANNOT WRITE FURTHER ????????",
      UVM_LOW)
  end
endfunction


function void write_read(fifo_seq_item t);
  if (t.rrst_n && t.rinc && !t.rempty && !$isunknown(t.rdata)) begin
    if (ref_q.size() > 0) begin
      fifo_seq_item exp = ref_q.pop_front();

      if (exp.wdata === t.rdata) begin
        match++;
        `uvm_info("SCOREBOARD_READ",$sformatf("MATCH -> Expected=%0d | Got=%0d | Queue size=%0d",exp.wdata, t.rdata, ref_q.size()),UVM_LOW)
      end
      else begin
        mismatch++;
        `uvm_error("SCOREBOARD_READ",$sformatf("MISMATCH -> Expected=%0d | Got=%0d | Queue size=%0d",exp.wdata, t.rdata, ref_q.size()))
      end
    end
    else begin
      `uvm_warning("SCOREBOARD_READ","Read occurred when ref_q is empty (possible underflow!)")
    end
  end
endfunction
  // ----------------------------------------------------------------
  // Report summary
  // ----------------------------------------------------------------
  function void report_phase(uvm_phase phase);
    `uvm_info("SCOREBOARD",
      $sformatf("FINAL RESULT: Matches=%0d | Mismatches=%0d | Remaining in ref_q=%0d",
                match, mismatch, ref_q.size()),
      UVM_NONE)
  endfunction

endclass
