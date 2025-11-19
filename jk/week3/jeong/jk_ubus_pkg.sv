package jk_ubus_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  `include "jk_ubus_transfer.sv"
  `include "jk_ubus_slave_sequencer.sv"
  `include "jk_ubus_slave_sequence.sv"
  `include "jk_ubus_slave_driver.sv"
  `include "jk_ubus_slave_monitor.sv"
  `include "jk_ubus_agent.sv"
  `include "jk_ubus_slave_env.sv"
  `include "jk_ubus_slave_test.sv"
endpackage
