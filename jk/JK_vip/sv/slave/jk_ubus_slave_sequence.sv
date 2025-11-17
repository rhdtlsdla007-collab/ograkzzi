class jk_ubus_slave_sequence extends uvm_sequence #(jk_ubus_master_transfer);
  `uvm_object_utils(jk_ubus_slave_sequence)
  `uvm_declare_p_sequencer(jk_ubus_slave_sequencer)

  int unsigned m_mem[int unsigned];

  jk_ubus_master_transfer req;
  jk_ubus_master_transfer rsp;


  function new(string name = "jk_ubus_slave_sequence");
    super.new(name);
    req = jk_ubus_master_transfer::type_id::create("req");
    rsp = jk_ubus_master_transfer::type_id::create("rsp");
  endfunction : new

  virtual task body();
    jk_ubus_master_transfer req, rsp;
    int data_beats;
    forever begin
      p_sequencer.request_fifo.get(req);
      rsp = jk_ubus_master_transfer::type_id::create("rsp");
      rsp.addr = req.addr;
      rsp.size = req.size;
      rsp.read = req.read;
      rsp.write = req.write;

      data_beats = size_to_beats(req.size);
      rsp.data = new[data_beats];
      rsp.error = 0;
      rsp.wait_state = new[data_beats];

      for (int i = 0; i < data_beats; i++) begin
        rsp.wait_state[i] = 1;
        if (req.write) begin
          m_mem[req.addr + i] = req.data[i];
          rsp.data[i] = req.data[i];
                              `uvm_info("SLAVE_MON", $sformatf("SEQaddr=0x%0h size=%0d read=%0b write=%0b data=%p", 
                  req.addr, req.size, req.read, req.write, req.data[i]), UVM_MEDIUM)
        end
        if (req.read) begin
         // if (!m_mem.exists(req.addr + i)) begin
            m_mem[req.addr + i] = $urandom_range(8'h10, 8'hFF);
            rsp.data[i] = m_mem[req.addr + i];
          `uvm_info("SLAVE_SEQ", $sformatf("SEQ_rsp.data = %p", rsp.data[i]), UVM_LOW)
          //end
        end
      end
      
      start_item(rsp);
      finish_item(rsp);
      rsp.print();
    end
  endtask : body

  function automatic int unsigned size_to_beats(bit [1:0] size_value);
    case (size_value)
      2'b00: return 1;
      2'b01: return 2;
      2'b10: return 4;
      default: return 8;
    endcase
  endfunction
endclass : jk_ubus_slave_sequence
