program automatic test;
import uvm_pkg::*;
import router_test_pkg::*;

initial begin
  uvm_resource_db#(virtual router_io)::set("router_vif", "", router_test_top.router_if);
  uvm_resource_db#(virtual reset_io)::set("reset_vif", "", router_test_top.reset_if);

   
   
   
  uvm_resource_db#(virtual host_io)::set("host_vif", "", router_test_top.host_if);

  $timeformat(-9, 1, "ns", 10);

   
   
   
  uvm_reg::include_coverage("*", UVM_CVR_ALL);

  run_test();
end

endprogram

