class jk_ubus_slave_monitor extends uvm_monitor;
  `uvm_component_utils(jk_ubus_slave_monitor)

  virtual jk_ubus_if vif;
  uvm_analysis_port#(jk_ubus_transfer) request_aport;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    request_aport = new("request_aport", this);
    if (!uvm_config_db#(virtual jk_ubus_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "virtual interface not set for monitor")
    end
  endfunction

  task run_phase(uvm_phase phase);
  jk_ubus_transfer req;
    forever begin
      jk_ubus_transfer req;
      @(posedge vif.ubus_clock);

      req = jk_ubus_transfer::type_id::create("req");
      req.addr = vif.ubus_addr;
      req.size = vif.ubus_size;
      req.data = vif.ubus_data;
      req.read = vif.ubus_read;
      req.write = vif.ubus_write;
      req.error = vif.ubus_error;
      req.wait_state = vif.ubus_wait;

      request_aport.write(req);

      
    end
    `uvm_info("MONITOR", $sformatf("Monitored request addr=%0h size=%0d", req.addr, req.size), UVM_LOW)
  endtask
endclass : jk_ubus_slave_monitor
