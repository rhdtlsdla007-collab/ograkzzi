class ubus_test_base extends uvm_test;
 `uvm_component_utils(ubus_test_base)

 ubus_env env;

 function new(string name = "ubus_test_base", uvm_component parent = null );
	super.new(name, parent);
 endfunction

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env = ubus_env::type_id::create("env", this);
 endfunction

 function void start_of_simulation_phase(uvm_phase phase);
	super.start_of_simulation_phase(phase);
	uvm_root::get().print_topology();
	env.tr.randomize();
	env.tr.print();
 

 endfunction

endclass : ubus_test_base

