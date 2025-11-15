`include "jk_ubus_dummy_dut.sv"

module jk_ubus_tb_top;
  import uvm_pkg::*;
 // import jk_ubus_slave_pkg::*;
 // import jk_ubus_master_pkg::*;
  import jk_ubus_common_pkg::*;

  jk_ubus_master_if master_if();
  jk_ubus_slave_if slave_if();

  jk_ubus_dummy_dut dut_bridge (
      .master_if(master_if),
      .slave_if(slave_if)
  );

  initial master_if.clk = 0;
  always #5 master_if.clk = ~master_if.clk;

  // 기본 초기화 및 리셋 시퀀스 추가: X 제거 및 파형 관찰 용이
  initial begin
    // 초기값 설정 (알려진 값으로 초기화)
    master_if.reset = 1'b1;
    master_if.addr  = '0;
    master_if.size  = '0;
    master_if.read  = 1'b0;
    master_if.write = 1'b0;
    master_if.bip   = 1'b0;

    // 리셋 유지 후 해제
    repeat (4) @(posedge master_if.clk);
    master_if.reset = 1'b0;
  end

  initial begin
    $fsdbDumpfile("test.fsdb");
    $fsdbDumpvars(0, jk_ubus_tb_top);

    uvm_config_db#(virtual jk_ubus_master_if)::set(null, "uvm_test_top.env.master_agent.*", "vif", master_if);
    uvm_config_db#(virtual jk_ubus_slave_if)::set(null, "uvm_test_top.env.slave_agent.*", "vif", slave_if);
    run_test();
  end
endmodule : jk_ubus_tb_top
