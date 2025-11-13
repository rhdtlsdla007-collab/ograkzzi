`include "master/jk_ubus_master_if.sv"
`include "jk_ubus_slave_if.sv"
module jk_ubus_tb_top;
  import uvm_pkg::*;
  
  `include "master/jk_ubus_master_transfer.sv"
  `include "master/jk_ubus_master_sequence.sv"
  `include "master/jk_ubus_master_sequencer.sv"
  `include "master/jk_ubus_master_driver.sv"
  `include "master/jk_ubus_master_monitor.sv"
  `include "master/jk_ubus_master_agent.sv"
  `include "jk_ubus_slave_transfer.sv"
  `include "jk_ubus_slave_sequencer.sv"
  `include "jk_ubus_slave_sequence.sv"
  `include "jk_ubus_slave_driver.sv"
  `include "jk_ubus_slave_monitor.sv"
  `include "jk_ubus_slave_agent.sv"
  `include "jk_ubus_env.sv"
  `include "jk_ubus_test_collection.sv"
 
  jk_ubus_master_if master_vif();
  jk_ubus_slave_if slave_vif();

  initial master_vif.clk = 0;
  initial slave_vif.clk = 0;
  always #5 master_vif.clk = ~master_vif.clk;
  always #5 slave_vif.clk = ~slave_vif.clk;
  // 기본 초기화 및 리셋 시퀀스 추가: X 제거 및 파형 관찰 용

    // 리셋 유지 후 해제

  initial begin
    $fsdbDumpfile("test.fsdb");
    $fsdbDumpvars(0, jk_ubus_tb_top);

    uvm_config_db#(virtual jk_ubus_master_if)::set(null, "*", "master_vif", master_vif);
    uvm_config_db#(virtual jk_ubus_slave_if)::set(null, "*", "slave_vif", slave_vif);
    run_test();
  end

  assign slave_vif.addr = master_vif.addr;
  assign slave_vif.size = master_vif.size;
  assign slave_vif.read = master_vif.read;
  assign slave_vif.write = master_vif.write;
  assign slave_vif.bip = master_vif.bip;
  assign slave_vif.data = master_vif.data;

endmodule : jk_ubus_tb_top

