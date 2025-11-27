class jk_ubus_master_monitor extends uvm_monitor;
 `uvm_component_utils(jk_ubus_master_monitor)

 virtual jk_ubus_master_if vif;
 jk_ubus_master_transfer req;
 
 uvm_analysis_port #(jk_ubus_master_transfer) item_collected_port;
 
 function new(string name, uvm_component parent);
	super.new(name, parent);
 	item_collected_port = new("item_collected_port", this);
 endfunction

 function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	if (!uvm_config_db#(virtual jk_ubus_master_if)::get(this,"","vif",vif)) begin
	`uvm_fatal("NOVIF", "NO virtual interface spectified for this monitor instance") end
 endfunction


 task run_phase(uvm_phase phase);
	forever begin 
	 @(posedge vif.clk);
//	while(vif.cb.wait_state) begin @(vif.cb); end
	for (int j = 0; j<100; j++) begin
			if (vif.wait_state) @(vif.clk);
			else if (j == 0) break;
			else if (j != 0) begin @(vif.clk); break; end
		end

	  if (vif.read || vif.write) begin
	bit read_state = vif.read;
	   req = jk_ubus_master_transfer::type_id::create("req");
	   req.addr = vif.addr;
	   req.size = vif.size;
	   req.read = vif.read;
	   req.write = vif.write;
		case(vif.size)
		 2'b00 : req.data = new[1];
		 2'b01 : req.data = new[2];
		 2'b10 : req.data = new[4];
		 2'b11 : req.data = new[8];
		endcase
	   foreach(req.data[i]) begin
		@(posedge vif.clk);
		for (int j = 0; j<100; j++) begin
			if (vif.wait_state) @(vif.clk);
			else if (j == 0) break;
			else if (j != 0) begin @(vif.clk); break; end
		end

	//	while(vif.cb.wait_state) begin @(vif.cb); end
		 req.data[i] = vif.data; 
	if (req.read)	`uvm_info("MASTER_MON", $sformatf("READ : %p, ADDR : %h, DATA : %h", req.read, req.addr, req.data[i]), UVM_MEDIUM);
	   end
	 if (read_state) @(posedge vif.clk);	
	   item_collected_port.write(req);
	 end
	end
endtask

endclass
