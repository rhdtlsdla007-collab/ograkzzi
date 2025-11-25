class jk_ubus_slave_driver extends uvm_driver #(jk_ubus_master_transfer);
  `uvm_component_utils(jk_ubus_slave_driver)

  virtual jk_ubus_slave_if vif;

  uvm_analysis_port#(jk_ubus_master_transfer) item_collected_port;

 int unsigned j = 0;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual jk_ubus_slave_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", "No virtual interface specified for this driver instance")
    end
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    forever begin
      jk_ubus_master_transfer rsp;
      seq_item_port.get_next_item(rsp);
 	    item_collected_port.write(rsp);
      if (rsp.read) begin
        drive_read_rsponse(rsp);
        `uvm_info("slave 드라이버 ", $sformatf("DRV rsp.read=%0d", rsp.read), UVM_LOW)
      end
    else if (rsp.write) begin
      drive_write_response(rsp);
      end
      seq_item_port.item_done();
    end
  endtask : run_phase

  virtual protected task drive_read_rsponse(jk_ubus_master_transfer rsp);
    int data_beats;
    data_beats = size_to_beats(rsp.size);
    `uvm_info("SLV_DRV", "Processing READ transaction", UVM_LOW)

    for (int i = 0; i < data_beats; i++) begin
      @(vif.cb);
      vif.cb.wait_state <= rsp.wait_state[j];
      while (rsp.wait_state[j]) begin
        @(vif.cb);
      j++;
      end
      vif.cb.wait_state <= rsp.wait_state[j];
      j++;
      vif.data <= rsp.data[i]; 
      `uvm_info("SLV_DRV_DATA", $sformatf("rsp.data=%h", rsp.data[i]), UVM_LOW)
      if(i==data_beats-1) @(vif.cb);
    end
   
    j = 0; 
    vif.data <= 'z; 
  endtask : drive_read_rsponse

  virtual protected task drive_write_response(jk_ubus_master_transfer rsp);
	int data_beats;
 	data_beats = size_to_beats(rsp.size);
    `uvm_info("SLV_DRV", "Processing WRITE transaction", UVM_LOW)
    //WRITE 응답 신호 구동
    //vif.cb.wait_state <= 0;
   for (int i = 0; i < data_beats; i++) begin
		@(vif.cb);
		vif.cb.wait_state <= rsp.wait_state[j];
		while (rsp.wait_state[j]) begin
		 @(vif.cb);
		 j++;
 		end
	vif.cb.wait_state <= rsp.wait_state[j];
    end

    vif.cb.error <= rsp.error;
    @(vif.cb);

  //신호해제
  j = 0;
  vif.cb.error <= 'z;
  endtask
  
  function automatic int unsigned size_to_beats(bit [1:0] size_value);
    case (size_value)
      2'b00: return 1;
      2'b01: return 2;
      2'b10: return 4;
      default: return 8;
    endcase
  endfunction

endclass : jk_ubus_slave_driver
