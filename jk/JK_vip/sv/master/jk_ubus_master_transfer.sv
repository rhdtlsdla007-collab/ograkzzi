class jk_ubus_master_transfer extends uvm_sequence_item;
 
 rand bit wait_state[];
 rand bit [15:0] addr;
 rand bit rw, error;
 rand bit [1:0] size;
 rand bit [7:0] data[];
 rand bit read, write;

 constraint data_size {
	(size == 2'b00) -> data.size() == 1 ;
	(size == 2'b01) -> data.size() == 2 ;
	(size == 2'b10) -> data.size() == 4 ;
 	(size == 2'b11) -> data.size() == 8 ;
 }
 constraint read_state{
	(rw == 1'b0) -> read == 1;
	(rw == 1'b1) -> read == 0;
 } 

 constraint write_state{
	(rw == 1'b0) -> write == 0;
	(rw == 1'b1) -> write == 1;
 }
 
 `uvm_object_utils_begin(jk_ubus_master_transfer)
	`uvm_field_int(addr, UVM_DEFAULT)
	`uvm_field_int(rw, UVM_DEFAULT)
	`uvm_field_int(read, UVM_DEFAULT)
	`uvm_field_int(write, UVM_DEFAULT)
	`uvm_field_int(size, UVM_DEFAULT)
	`uvm_field_int(error, UVM_DEFAULT)
 	`uvm_field_array_int(data, UVM_DEFAULT)
	`uvm_field_array_int(wait_state, UVM_DEFAULT)
 `uvm_object_utils_end

 function new(string name = "jk_ubus_master_transfer");
	super.new(name);
 endfunction 

endclass : jk_ubus_master_transfer
