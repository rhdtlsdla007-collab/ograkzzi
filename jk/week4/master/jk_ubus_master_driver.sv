class jk_ubus_master_driver extends uvm_driver#(jk_ubus_master_transfer);
 `uvm_component_utils(jk_ubus_master_driver)

 virtual jk_ubus_master_if master_vif;

 function new(string name, uvm_component parent);
	super.new(name, parent);
 endfunction 

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
        uvm_config_db#(virtual jk_ubus_master_if)::get(this,"","master_vif",master_vif);
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
	@(posedge master_vif.clk);
	master_vif.bip <=0;
	master_vif.addr <= tr.addr;
	master_vif.write <= tr.write;
	master_vif.size <= tr.size;
	master_vif.read <= tr.read;
	`uvm_info("MASTER_DRV", $sformatf(">>> MASTER TO SLAVE <<< addr=0x%0h size=%0d read=%0b write=%0b", 
                  tr.addr, tr.size, tr.read, tr.write), UVM_MEDIUM)
	for (int i = 0; i < data_size;i++) begin
	@(posedge master_vif.clk);
	master_vif.write <= 0;
	master_vif.read <= 0;
	tr.data[i] = master_vif.data;
	end
 endtask

 task drive_write_transfer(jk_ubus_master_transfer tr);
  int data_size;
	case (tr.size)
		2'b00 : data_size = 1;
		2'b01 : data_size = 2;
		2'b10 : data_size = 4;
		2'b11 : data_size = 8;
	endcase
	@(posedge master_vif.clk);
	master_vif.bip <= 0;
	master_vif.addr<=tr.addr;
	master_vif.write <= tr.write;
	master_vif.read <= tr.read;
	master_vif.size <= tr.size;
	foreach(tr.data[i]) begin
	@(posedge master_vif.clk);
	master_vif.write <= 0;
	master_vif.read <= 0; 
	master_vif.data <= tr.data[i];
	if (i == (data_size-1)) master_vif.bip <= 1;
	end
 endtask

endclass
