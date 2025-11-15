package jk_ubus_common_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
 // `include "jk_ubus_master_transfer.sv"
//  import jk_ubus_master_pkg::*;
//  import jk_ubus_slave_pkg::*;

  `include "master/jk_ubus_master_transfer.sv"
  `include "slave/jk_ubus_slave_sequencer.sv"
  `include "slave/jk_ubus_slave_sequence.sv"
  `include "slave/jk_ubus_slave_driver.sv"
  `include "slave/jk_ubus_slave_monitor.sv"
  `include "slave/jk_ubus_slave_agent.sv"

//   `include "jk_ubus_master_transfer.sv"
  `include "master/jk_ubus_master_sequence.sv" 	
  `include "master/jk_ubus_master_sequencer.sv"
  `include "master/jk_ubus_master_driver.sv"
  `include "master/jk_ubus_master_monitor.sv"
  `include "master/jk_ubus_master_agent.sv"


  `include "jk_ubus_scoreboard.sv"
  `include "jk_ubus_virtual_sequencer.sv"
  `include "jk_ubus_coverage.sv"
  `include "jk_ubus_env.sv"
  `include "jk_ubus_sequence_collection.sv"
  `include "jk_ubus_virtual_sequence.sv"
  `include "jk_ubus_test_collection.sv"

  
endpackage : jk_ubus_common_pkg
