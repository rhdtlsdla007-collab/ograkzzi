import uvm_pkg::*;

class ubus_transfer extends uvm_sequence_item;
 
 rand wait_state;
 rand bit [15:0] addr;
 rand bit read, write, error;
 rand bit [1:0] size;
 rand [7:0] data;

 `uvm_object_utils_begin(ubus_transfer)
	`uvm_field_int(addr, UVM_DEFAULT)
	`uvm_field_int(read, UVM_DEFAULT)
	`uvm_field_int(write, UVM_DEFAULT)
	`uvm_field_int(error, UVM_DEFAULT)
	`uvm_field_int(size, UVM_DEFAULT)
 	`uvm_field_array_int(data, UVM_DEFAULT)
	`uvm_field_array_int(wait_state, UVM_DEFAULT)
 `uvm_object_utils_end

 function new(string name = "ubus_transfer");
	super.new(name);
 endfunction 

endclass : ubus_transfer

