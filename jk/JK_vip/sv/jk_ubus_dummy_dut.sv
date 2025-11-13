module jk_ubus_dummy_dut (
    jk_ubus_master_if master_if,
    jk_ubus_slave_if slave_if
);

  initial begin
    slave_if.wait_state = 1'b0;
    slave_if.error      = 1'b0;
  end

  // assign으로 작성
  assign slave_if.clk   = master_if.clk;
  assign slave_if.reset = master_if.reset;
  assign slave_if.addr  = master_if.addr;
  assign slave_if.size  = master_if.size;
  assign slave_if.read  = master_if.read;
  assign slave_if.write = master_if.write;
  assign slave_if.bip   = master_if.bip;

  // WRITE 데이터
  assign slave_if.data = (master_if.write) ? master_if.data : 'hz;

  // READ 데이터
  assign master_if.data = (master_if.read) ? slave_if.data : 'hz;

  // 응답 신호
  assign master_if.wait_state = slave_if.wait_state;
  assign master_if.error      = slave_if.error;

endmodule