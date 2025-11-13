class jk_ubus_master_agent extends uvm_agent;
 `uvm_component_utils(jk_ubus_master_agent)

 jk_ubus_master_sequencer sqr;
 jk_ubus_master_driver drv;
 jk_ubus_master_monitor mon;

 function new(string name = "jk_ubus_master_agent", uvm_component parent);
	super.new(name, parent);
 endfunction

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	sqr = jk_ubus_master_sequencer::type_id::create("sqr", this);
	drv = jk_ubus_master_driver::type_id::create("drv", this);
	mon = jk_ubus_master_monitor::type_id::create("mon", this); 
 endfunction 

 function void connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	drv.seq_item_port.connect(sqr.seq_item_export);
 endfunction

endclass

