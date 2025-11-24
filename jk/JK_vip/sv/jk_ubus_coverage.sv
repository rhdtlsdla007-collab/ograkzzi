class coverage_sb extends uvm_subscriber #(jk_ubus_master_transfer);
 `uvm_component_utils(coverage_sb)
 jk_ubus_master_transfer tr;
 int tr_cnt; 

 covergroup cov1;
	cov_data : coverpoint tr.data[0] {
			option.auto_bin_max = 16;
		}
	cov_addr : coverpoint tr.addr{
			option.auto_bin_max=16;
		}
	dir : coverpoint {tr.read, tr.write} {
		bins write_state = {2'b01};
		bins read_state  = {2'b10};
		}
	c_size : cross dir, tr.size;
	c_data : cross dir, cov_data;
	c_addr : cross dir, cov_addr;
 endgroup

 function new(string name, uvm_component parent);
	super.new(name, parent);
	cov1=new();
 endfunction

 function void write(jk_ubus_master_transfer t);
	real current_coverage;
	tr = t;
	tr_cnt++;
	cov1.sample();
	current_coverage = $get_coverage();
	`uvm_info("COVERAGE", $sformatf("%0d tr sampled, Coverage = %f%%", tr_cnt, current_coverage), UVM_MEDIUM)
 endfunction 
endclass

