class jk_ubus_master_sequence extends uvm_sequence#(jk_ubus_master_transfer);
 `uvm_object_utils(jk_ubus_master_sequence)
       
 function new(string name = "jk_ubus_master_sequence");
	super.new(name);
 endfunction

 virtual task body();
	jk_ubus_master_transfer tr;
  repeat (5) begin
	`uvm_do(tr)
	get_response(tr);
	`uvm_info("MsT", $sformatf(": 0x%p ", tr.data), UVM_HIGH)
  end
 endtask : body

endclass

