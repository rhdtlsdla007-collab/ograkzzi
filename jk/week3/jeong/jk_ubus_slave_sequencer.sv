class jk_ubus_slave_sequencer extends uvm_sequencer #(jk_ubus_transfer);
  `uvm_component_utils(jk_ubus_slave_sequencer)

  uvm_tlm_fifo#(jk_ubus_transfer) request_fifo;

  function new(string name = "jk_ubus_slave_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    request_fifo = new("request_fifo", this);
  endfunction : build_phase

  
endclass : jk_ubus_slave_sequencer
