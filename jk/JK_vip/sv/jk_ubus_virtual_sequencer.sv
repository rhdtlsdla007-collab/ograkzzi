class jk_ubus_virtual_sequencer extends uvm_sequencer;
 `uvm_component_utils(jk_ubus_virtual_sequencer)

	jk_ubus_master_sequencer master_sequencer;
	jk_ubus_slave_sequencer slave_sequencer;

 function new(string name = "jk_ubus_virtual_sequencer", uvm_component parent=null);
	super.new(name, parent);
 endfunction

endclass

