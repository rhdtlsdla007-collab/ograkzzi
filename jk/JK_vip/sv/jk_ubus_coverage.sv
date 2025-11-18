class coverage_sb extends uvm_subscriber #(jk_ubus_master_transfer);
 `uvm_component_utils(coverage_sb)
 jk_ubus_master_transfer tr;
 int tr_cnt; 

 covergroup cov1;
	cov_data : coverpoint tr.data[0] {
		}
	cov_size : coverpoint tr.size{
		}
	cov_addr : coverpoint tr.addr{
		}
	cov_write : coverpoint tr.write{
		}
	cov_read : coverpoint tr.read{
		}
 endgroup

 function new(string name, uvm_component parent);
	super.new(name, parent);
	cov1=new();
 endfunction

 function void write(jk_ubus_master_transfer tr0);
	real current_coverage;
	tr = tr0;
	tr_cnt++;
	cov1.sample();
	current_coverage = $get_coverage();
	`uvm_info("COVERAGE", $sformatf("%0d tr sampled, Coverage = %f%%", tr_cnt, current_coverage), UVM_MEDIUM)
 endfunction 
endclass

