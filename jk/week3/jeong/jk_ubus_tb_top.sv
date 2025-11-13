module jk_ubus_tb_top;
  import uvm_pkg::*;
  import jk_ubus_pkg::*;

  jk_ubus_if vif();

  initial vif.ubus_clock = 0;
  always #5 vif.ubus_clock = ~vif.ubus_clock;

  initial begin
    $fsdbDumpfile("test.fsdb");
    $fsdbDumpvars(0, jk_ubus_tb_top);

    uvm_config_db#(virtual jk_ubus_if)::set(null, "*", "vif", vif);
    run_test("jk_ubus_slave_test");
  end
endmodule : jk_ubus_tb_top
