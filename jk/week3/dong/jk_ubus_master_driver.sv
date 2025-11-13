class jk_ubus_master_driver extends uvm_driver#(jk_ubus_transfer);
 `uvm_component_utils(jk_ubus_master_driver)

 virtual jk_ubus_interface vif;

 function new(string name, uvm_component parent);
	super.new(name, parent);
 endfunction 

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
        uvm_config_db#(virtual jk_ubus_interface)::get(this,"","vif",vif);
 endfunction

 task run_phase(uvm_phase phase);
	jk_ubus_transfer tr;
  forever begin
	seq_item_port.get_next_item(tr);
	drive_transfer(tr);
	seq_item_port.item_done(tr);
  end
 endtask : run_phase

 task drive_transfer(jk_ubus_transfer tr);
	@(posedge vif.clk);
	vif.addr<=tr.addr;
	vif.write<=tr.write;
	vif.read<=tr.read;
	vif.data<=tr.data[0];
 endtask

endclass
