interface jk_ubus_interface();
 logic read, write, bip, wait_state, error;
 logic [15:0] addr;
 logic [1:0] size;
 logic clk;
 wire logic [7:0] data;

 clocking cb @(posedge clk);
  default input #1ns output #1ns;
	input error, wait_state;
	output read, write, bip, addr, size, data;
endclocking 

endinterface : jk_ubus_interface
