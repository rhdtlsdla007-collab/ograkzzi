class jk_ubus_slave_driver extends uvm_driver #(jk_ubus_transfer);
  `uvm_component_utils(jk_ubus_slave_driver)

  virtual jk_ubus_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual jk_ubus_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "No virtual interface specified for this driver instance")
    end
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    jk_ubus_transfer tr;
    forever begin
      seq_item_port.get_next_item(tr);
      drive_transfer(tr);
      tr.print();
      seq_item_port.item_done();
    end
  endtask : run_phase

  task drive_transfer(jk_ubus_transfer tr);
    @(posedge vif.ubus_clock);
    vif.ubus_addr <= tr.addr;
    vif.ubus_size <= tr.size;
    vif.ubus_read <= tr.read;
    vif.ubus_write <= tr.write;
    vif.ubus_data <= tr.data;
    vif.ubus_error <= tr.error;
    vif.ubus_wait <= tr.wait_state;
  endtask : drive_transfer

  

endclass : jk_ubus_slave_driver
