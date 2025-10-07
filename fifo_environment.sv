
class fifo_environment extends uvm_env;
  `uvm_component_utils(fifo_environment)

  fifo_write_agent        write_agent;
  fifo_read_agent         read_agent;
  fifo_scoreboard         sb;
  fifo_virtual_sequencer  vseqr;

  fifo_subscriber cov;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    write_agent = fifo_write_agent       ::type_id::create("write_agent", this);
    read_agent  = fifo_read_agent        ::type_id::create("read_agent",  this);
    sb          = fifo_scoreboard        ::type_id::create("sb",          this);
    vseqr       = fifo_virtual_sequencer ::type_id::create("vseqr",       this);
    cov         = fifo_subscriber        ::type_id::create("cov",         this);
  endfunction

  function void connect_phase(uvm_phase phase);
    // connect monitors to scoreboard
    write_agent.monitor.write_ap.connect(sb.write_imp);
    read_agent.monitor.read_ap.connect(sb.read_imp);

    // connect sequencers to virtual sequencer
    vseqr.write_sqr = write_agent.sequencer;
    vseqr.read_sqr  = read_agent.sequencer;

    // connect monitor to subscriber
    write_agent.monitor.write_cg_port.connect(cov.write_mon_cov_imp);
    read_agent.monitor.read_cg_port.connect(cov.read_mon_cov_imp);

  endfunction
endclass
