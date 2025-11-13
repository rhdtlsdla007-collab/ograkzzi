module jk_ubus_tb_top;
 import uvm_pkg::*;

 
 jk_ubus_interface vif();

 initial vif.clk=0;
 always #5 vif.clk = ~vif.clk;

 
 initial begin
 uvm_config_db#(virtual jk_ubus_interface)::set(null,"*","vif",vif);
	run_test();
 end

endmodule

