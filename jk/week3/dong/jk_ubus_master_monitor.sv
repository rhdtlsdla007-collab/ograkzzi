class jk_ubus_master_monitor extends uvm_monitor;
 `uvm_component_utils(jk_ubus_master_monitor)

 virtual jk_ubus_interface vif;
 
 function new(string name, uvm_component parent);
	super.new(name, parent);
 endfunction

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if (!uvm_config_db#(virtual jk_ubus_interface)::get(this,"","vif",vif)) begin
	`uvm_fatal("NOVIF", "NO virtual interface spectified for this monitor instance") end
 endfunction

 task run_phase(uvm_phase phase);
	forever begin 
	@(posedge vif.clk);
	end
endtask

endclass
