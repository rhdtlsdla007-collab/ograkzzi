class jk_ubus_master_sequencer extends uvm_sequencer #(jk_ubus_master_transfer);
 `uvm_component_utils(jk_ubus_master_sequencer)

 function new(string name = "jk_ubus_master_sequencer", uvm_component parent);
	super.new(name, parent);
 endfunction

endclass

