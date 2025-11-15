class jk_ubus_master_driver extends uvm_driver#(jk_ubus_master_transfer);
 `uvm_component_utils(jk_ubus_master_driver)

 virtual jk_ubus_master_if vif;

 function new(string name, uvm_component parent);
	super.new(name, parent);
 endfunction 

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
        uvm_config_db#(virtual jk_ubus_master_if)::get(this,"","vif",vif);
 endfunction

 task run_phase(uvm_phase phase);
	jk_ubus_master_transfer tr;
  forever begin
	seq_item_port.get_next_item(tr);
	if(tr.read == 1) drive_read_transfer(tr);
	else if(tr.write == 1) drive_write_transfer(tr);
	seq_item_port.item_done(tr);
  end
 endtask : run_phase

 task drive_read_transfer(jk_ubus_master_transfer tr);
  int data_size;
	case (tr.size)
		2'b00 : data_size = 1;
		2'b01 : data_size = 2;
		2'b10 : data_size = 4;
		2'b11 : data_size = 8;
	endcase
	@(posedge vif.clk);
	vif.addr <= tr.addr;
	vif.write <= tr.write;
	vif.size <= tr.size;
	vif.read <= tr.read;

	//first bit
	@(posedge vif.clk);
	vif.bip = (data_size == 1) ? 0 : 1;
	tr.data[0] = vif.data;

	for (int i = 1; i < data_size;i++) begin
	@(posedge vif.clk);
	tr.data[i] <= vif.data;
	if (i == data_size - 1) vif.bip <= 0;
	end

	@(posedge vif.clk);
	vif.write <= 0;
	vif.read <= 0;

 endtask

 task drive_write_transfer(jk_ubus_master_transfer tr);
  int data_size;
	case (tr.size)
		2'b00 : data_size = 1;
		2'b01 : data_size = 2;
		2'b10 : data_size = 4;
		2'b11 : data_size = 8;
	endcase
	@(posedge vif.clk);
	vif.addr<=tr.addr;
	vif.write <= tr.write;
	vif.read <= tr.read;
	vif.size <= tr.size;
	  
	  
	// ✅ 첫 번째 데이터
	@(posedge vif.clk);
	vif.data <= tr.data[0];
	vif.bip = (data_size==1) ? 0 : 1;
	
	// ✅ 나머지 데이터
	foreach(tr.data[i]) begin
		if (i > 0) begin  // i=0은 이미 위에서 함
		@(posedge vif.clk);
		vif.data <= tr.data[i];
			if (i == data_size - 1) vif.bip <=0 ;
		end
	end
	
	// ✅ 마지막 beat 후
	@(posedge vif.clk);
	vif.write <= 0;
	vif.read <= 0;
	vif.bip <= 0;
	
	`uvm_info("MSTR_DRV", 
		$sformatf("WRITE: addr=0x%0h, data=%p", tr.addr, tr.data), UVM_LOW)
	endtask

endclass
