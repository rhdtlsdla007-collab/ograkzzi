import uvm_pkg::*;

class ubus_transfer extends uvm_sequence_item;
 
 rand bit wait_state;
 rand bit [15:0] addr;
 rand bit read, write, error;
 rand bit [1:0] size;
 rand bit [7:0] data;

 `uvm_object_utils_begin(ubus_transfer)
	`uvm_field_int(addr, UVM_DEFAULT)
	`uvm_field_int(read, UVM_DEFAULT)
	`uvm_field_int(write, UVM_DEFAULT)
	`uvm_field_int(size, UVM_DEFAULT)
 	`uvm_field_int(data, UVM_DEFAULT)
	`uvm_field_int(wait_state, UVM_DEFAULT)
 `uvm_object_utils_end

 function new(string name = "ubus_transfer");
	super.new(name);
 endfunction 

endclass : ubus_transfer
//

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

//

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

//

module ubus_tb_top;

  initial begin
         run_test();
  end

endmodule

