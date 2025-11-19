class jk_ubus_slave_driver extends uvm_driver #(jk_ubus_slave_transfer);
  `uvm_component_utils(jk_ubus_slave_driver)

  virtual jk_ubus_slave_if slave_vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual jk_ubus_slave_if)::get(this, "", "slave_vif", slave_vif)) begin
      `uvm_fatal("NOVIF", "No virtual interface specified for this driver instance")
    end
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    forever begin
      jk_ubus_slave_transfer rsp;
      seq_item_port.get_next_item(rsp);
      if (rsp.read) begin
        drive_read_rsponse(rsp);
      end
    else if (rsp.write) begin
      drive_write_response(rsp);
      end
      seq_item_port.item_done(rsp);
    end
  endtask : run_phase

  virtual protected task drive_read_rsponse(jk_ubus_slave_transfer rsp);
  `uvm_info("SLV_DRV", "Processing READ transaction", UVM_LOW)

  for (int i = 0; i < rsp.size; i++) begin
      slave_vif.wait_state <= 0;
      slave_vif.data <= rsp.data[i];
      slave_vif.bip <= (i == rsp.size-1) ? 0:1;
      @(posedge slave_vif.clk);
  end

  slave_vif.data <= 'z;
  slave_vif.bip <= 'z;
  endtask : drive_read_rsponse

  virtual protected task drive_write_response(jk_ubus_slave_transfer rsp);
    `uvm_info("SLV_DRV", "Processing WRITE transaction", UVM_LOW)

    //WRITE 응답 신호 구동
    slave_vif.wait_state <= 0;
    slave_vif.error <= rsp.error;
    @(posedge slave_vif.clk);

  //신호해제
  slave_vif.error <= 'z;
  endtask
  

endclass : jk_ubus_slave_driver
