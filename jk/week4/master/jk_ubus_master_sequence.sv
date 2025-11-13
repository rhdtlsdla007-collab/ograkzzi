class jk_ubus_master_sequence extends uvm_sequence#(jk_ubus_master_transfer);
 `uvm_object_utils(jk_ubus_master_sequence)

 function new(string name = "jk_ubus_master_sequence");
	super.new(name);
 endfunction

 virtual task body();
	jk_ubus_master_transfer tr;
  repeat (10) begin
	tr = jk_ubus_master_transfer::type_id::create("tr");
	assert(tr.randomize);
	start_item(tr);
	finish_item(tr);
  end
 endtask : body

endclass

