class jk_ubus_slave_sequence extends uvm_sequence #(jk_ubus_transfer);
  `uvm_object_utils(jk_ubus_slave_sequence)
  `uvm_declare_p_sequencer(jk_ubus_slave_sequencer)

  jk_ubus_transfer req;
  jk_ubus_transfer rsp;

  function new(string name = "jk_ubus_slave_sequence");
    super.new(name);
    req = jk_ubus_transfer::type_id::create("req");
    rsp = jk_ubus_transfer::type_id::create("rsp");
  endfunction : new

  task body();
    
    forever begin
      p_sequencer.request_fifo.get(req);
      start_item(req);
      rsp.copy(req);
      finish_item(rsp);
      rsp.print();
    end
  endtask : body
endclass : jk_ubus_slave_sequence
