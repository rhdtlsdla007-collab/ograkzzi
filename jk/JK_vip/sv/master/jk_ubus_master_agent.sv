class jk_ubus_master_agent extends uvm_agent;
 `uvm_component_utils(jk_ubus_master_agent)

 jk_ubus_master_sequencer sequencer;
 jk_ubus_master_driver driver;
 jk_ubus_master_monitor monitor;

 function new(string name = "jk_ubus_master_agent", uvm_component parent);
	super.new(name, parent);
 endfunction

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	sequencer = jk_ubus_master_sequencer::type_id::create("sequencer", this);
	driver = jk_ubus_master_driver::type_id::create("driver", this);
	monitor = jk_ubus_master_monitor::type_id::create("monitor", this); 
 endfunction 

 function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	driver.seq_item_port.connect(sequencer.seq_item_export);
 endfunction

endclass

