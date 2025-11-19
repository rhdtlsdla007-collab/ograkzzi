package jk_ubus_master_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import jk_ubus_common_pkg::*;
   	
  `include "jk_ubus_master_transfer.sv"
  `include "jk_ubus_master_sequence.sv" 	
  `include "jk_ubus_master_sequencer.sv"
  `include "jk_ubus_master_driver.sv"
  `include "jk_ubus_master_monitor.sv"
  `include "jk_ubus_master_agent.sv"

endpackage : jk_ubus_master_pkg


