class jk_ubus_master_sequence extends uvm_sequence#(jk_ubus_transfer);
 `uvm_object_utils(jk_ubus_master_sequence)

 function new(string name = "jk_ubus_master_sequence");
	super.new(name);
 endfunction

 virtual task body();
	jk_ubus_transfer tr;
  repeat (10) begin
	tr = jk_ubus_transfer::type_id::create("tr");
	tr.data = new[1];
	assert(tr.randomize);
	start_item(tr);
	tr.print();
	finish_item(tr);
  end
 endtask : body

endclass

