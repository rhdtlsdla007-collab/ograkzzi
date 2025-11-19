package jk_ubus_slave_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
  //import jk_ubus_master_pkg::*;

  // `include "jk_ubus_slave_transfer.sv"
  `include "jk_ubus_master_transfer.sv"
  `include "jk_ubus_slave_sequencer.sv"
  `include "jk_ubus_slave_sequence.sv"
  `include "jk_ubus_slave_driver.sv"
  `include "jk_ubus_slave_monitor.sv"
  `include "jk_ubus_slave_agent.sv"
 // `include "../jk_ubus_scoreboard.sv"
 // `include "../jk_ubus_virtual_sequencer.sv"
 // `include "../jk_ubus_env.sv"
 // `include "../jk_ubus_sequence_collection.sv"
 // `include "../jk_ubus_virtual_sequence.sv"
 // `include "jk_ubus_test_collection.sv"
endpackage
