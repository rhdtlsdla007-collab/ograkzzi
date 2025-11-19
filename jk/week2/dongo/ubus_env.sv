class ubus_env extends uvm_env;

 ubus_transfer tr;

 `uvm_component_utils(ubus_env)

 function new(string name = "ubus_env", uvm_component parent = null);
 	super.new(name, parent);
 endfunction 

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
 	tr = ubus_transfer::type_id::create("tr", this);
 endfunction


endclass : ubus_env

