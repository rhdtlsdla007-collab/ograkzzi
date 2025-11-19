class jk_ubus_master_monitor extends uvm_monitor;
 `uvm_component_utils(jk_ubus_master_monitor)

 virtual jk_ubus_master_if master_vif;
 jk_ubus_master_transfer req;
 
 uvm_analysis_port #(jk_ubus_master_transfer) item_collected_port;
 
 function new(string name, uvm_component parent);
	super.new(name, parent);
 	item_collected_port = new("item_collected_port", this);
 endfunction

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if (!uvm_config_db#(virtual jk_ubus_master_if)::get(this,"","master_vif",master_vif)) begin
	`uvm_fatal("NOVIF", "NO virtual interface spectified for this monitor instance") end
 endfunction

 task run_phase(uvm_phase phase);
	forever begin 
	 @(posedge master_vif.clk);
	  if (master_vif.read || master_vif.write) begin
	   req = jk_ubus_master_transfer::type_id::create("req");
	   req.addr = master_vif.addr;
	   req.size = master_vif.size;
	   req.read = master_vif.read;
	   req.write = master_vif.write;
		case(master_vif.size)
		 2'b00 : req.data = new[1];
		 2'b01 : req.data = new[2];
		 2'b10 : req.data = new[4];
		 2'b11 : req.data = new[8];
		endcase
	   foreach(req.data[i]) begin
		@(posedge master_vif.clk);
		req.data[i] = master_vif.data;
	   end
	   item_collected_port.write(req);
	 end
	end
endtask

endclass
