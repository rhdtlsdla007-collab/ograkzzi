class jk_ubus_master_env extends uvm_env;
 `uvm_component_utils(jk_ubus_master_env)

 jk_ubus_master_agent agt;

 function new(name = "jk_ubus_master_env", uvm_component parent);
	super.new(name, parent);
 endfunction

 function void build_phase(uvm_phase phase);
 	super.build_phase(phase);
	agt = jk_ubus_master_agent::type_id::create("agt", this);
 endfunction

endclass


