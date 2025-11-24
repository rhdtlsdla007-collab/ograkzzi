class jk_ubus_base_sequence extends uvm_sequence#(jk_ubus_master_transfer);

 function new(string name = "ubus_virtual_sequence");
	super.new(name);
 endfunction

endclass : jk_ubus_base_sequence

//////////////

class incr_read_byte_seq extends jk_ubus_base_sequence;

 `uvm_object_utils(incr_read_byte_seq)

 function new(string name = "incr_read_byte_seq");
	super.new(name);
 endfunction
 
 

 //rand bit [15:0] start_address;
 int unsigned count = 100;
 

 virtual task body();
	jk_ubus_master_transfer tr;
	`uvm_info(get_type_name(), $sformatf("%s starting with count = %0d", get_sequence_path(), count), UVM_MEDIUM);
  
  repeat(count) begin
//	`uvm_do_with(tr, {addr == start_address; rw == 0;})
 	`uvm_do_with(tr, {rw == 0;})
//	start_address++;
  end
 endtask

endclass : incr_read_byte_seq

//////////////////////////

class incr_write_byte_seq extends jk_ubus_base_sequence;
 `uvm_object_utils(incr_write_byte_seq)

 function new(string name = "incr_write_byte_seq");
 	super.new(name);
 endfunction
  
 jk_ubus_master_transfer tr; 

// rand bit [15:0] start_address;
 int unsigned count = 100;
 


 virtual task body();
	`uvm_info(get_type_name(), $sformatf("%s starting with count = %0d", get_sequence_path(), count), UVM_MEDIUM)
  repeat(count) begin
//	`uvm_do_with(tr, {addr == start_address; rw ==1;})
	`uvm_do_with(tr, {rw == 1;})

//	start_address++;
  end
 endtask

endclass : incr_write_byte_seq

//////////////////////////////

class incr_read_write_read_seq extends jk_ubus_base_sequence;
 `uvm_object_utils(incr_read_write_read_seq)

 function new(string name = "incr_write_byte_seq");
	super.new(name);
 endfunction

 incr_read_byte_seq read0;
 incr_write_byte_seq write0;

 rand bit [15:0] start_address = 16'h1000;

 virtual task body();
  `uvm_info(get_type_name(), $sformatf("%s starting with count = %0d", get_sequence_path(), 1), UVM_MEDIUM)

  `uvm_do_with(read0, {count == 1; start_address == local::start_address;})
  `uvm_do_with(write0, {count == 1; start_address == local::start_address;})
  `uvm_do_with(read0, {count == 1; start_address == local::start_address;})


 endtask

endclass : incr_read_write_read_seq

