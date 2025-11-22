class jk_ubus_slave_sequencer extends uvm_sequencer #(jk_ubus_master_transfer);
  `uvm_component_utils(jk_ubus_slave_sequencer)

  uvm_tlm_analysis_fifo#(jk_ubus_master_transfer) request_fifo;
  uvm_analysis_port#(jk_ubus_master_transfer) item_collected_export;

  function new(string name = "jk_ubus_slave_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    request_fifo = new("request_fifo", this);
    // item_collected_export = new("item_collected_export", this);
  endfunction : build_phase
  
endclass : jk_ubus_slave_sequencer
