class jk_ubus_slave_sequence extends uvm_sequence #(jk_ubus_slave_transfer);
  `uvm_object_utils(jk_ubus_slave_sequence)
  `uvm_declare_p_sequencer(jk_ubus_slave_sequencer)

  int unsigned m_mem[int unsigned];

  jk_ubus_slave_transfer req;
  jk_ubus_slave_transfer rsp;


  function new(string name = "jk_ubus_slave_sequence");
    super.new(name);
    req = jk_ubus_slave_transfer::type_id::create("req");
    rsp = jk_ubus_slave_transfer::type_id::create("rsp");
  endfunction : new

  virtual task body();
    jk_ubus_slave_transfer req, rsp;
    forever begin
      p_sequencer.request_fifo.get(req);
      rsp = jk_ubus_slave_transfer::type_id::create("rsp");
      rsp.addr = req.addr;
      rsp.size = req.size;
      rsp.read = req.read;
      rsp.write = req.write;
      rsp.data = new[req.size];
      rsp.error = 0;
      rsp.wait_state = new[req.size];

      for (int i = 0; i < req.size; i++) begin
        rsp.wait_state[i] = 1;
        if (req.write) begin
          m_mem[req.addr + i] = $urandom_range(8'h10, 8'hFF);
          rsp.data[i] = m_mem[req.addr + i];
      end
    end
    end
    start_item(rsp);
    finish_item(rsp);
    rsp.print();
  endtask : body
endclass : jk_ubus_slave_sequence
