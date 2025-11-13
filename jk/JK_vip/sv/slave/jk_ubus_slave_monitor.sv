class jk_ubus_slave_monitor extends uvm_monitor;
  `uvm_component_utils(jk_ubus_slave_monitor)

  virtual jk_ubus_slave_if slave_if;

  uvm_analysis_port#(jk_ubus_master_transfer) item_collected_port;
  uvm_analysis_port#(jk_ubus_master_transfer) request_aport;
  
  // Master monitor로부터 받은 트랜잭션을 받기 위한 분석 임포트
  uvm_analysis_imp#(jk_ubus_master_pkg::jk_ubus_master_transfer, jk_ubus_slave_monitor) master_req_imp;

  typedef enum {IDLE, ADDR_PHASE, DATA_PHASE, COMPLETE} monitor_state_e;
  monitor_state_e current_state = IDLE;
  int data_beat_count = 0;
  int data_size = 0;
  bit transaction_started = 0;


  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
    request_aport = new("request_aport", this);
    master_req_imp = new("master_req_imp", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual jk_ubus_slave_if)::get(this, "", "vif", slave_if)) begin
      `uvm_fatal("NOVIF", "virtual interface not set for monitor")
    end
  endfunction

  // Master monitor로부터 트랜잭션을 받았을 때 호출되는 함수
  function void write(jk_ubus_master_pkg::jk_ubus_master_transfer t);
    `uvm_info("SLAVE_MON", $sformatf("<<< Master에서 수신한 트랜잭션 >>> addr=0x%0h size=%0d read=%0b write=%0b", 
              t.addr, t.size, t.read, t.write), UVM_MEDIUM)
    `uvm_info("SLAVE_MON", $sformatf("Master 트랜잭션 데이터: %p", t.data), UVM_MEDIUM)
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      jk_ubus_master_transfer req;

      @(posedge slave_if.clk);
      
      if ((slave_if.read || slave_if.write)) begin
        transaction_started = 1;
        req = new("req");
        req.addr = slave_if.addr;
        
        case (slave_if.size)
          2'b00: begin req.size = 0; data_size = 1; end
          2'b01: begin req.size = 1; data_size = 2; end
          2'b10: begin req.size = 2; data_size = 4; end
          2'b11: begin req.size = 3; data_size = 8; end
        endcase
        
        req.read  = slave_if.read;
        req.write = slave_if.write;
        req.data  = new[data_size];
        req.wait_state = new[data_size];
        
        `uvm_info("SLAVE_MON", 
          $sformatf(">>> 요청 감지 <<< addr=0x%0h size=%0d read=%0b write=%0b", 
                    req.addr, req.size, req.read, req.write), UVM_MEDIUM)
        
        request_aport.write(req);
        
        // ===== READ/WRITE 동일 구조 =====
        if (req.read) begin
          //@(posedge slave_if.clk);  // ✅ 첫 beat 대기
          
          for (int i = 0; i < data_size; i++) begin
            req.data[i] = slave_if.data;
            req.wait_state[i] = slave_if.wait_state;
            
            `uvm_info("SLAVE_MON", 
              $sformatf("Read [%0d]: 0x%02h wait=%0b", 
                        i, req.data[i], req.wait_state[i]), UVM_HIGH)
            
          end
        end 
        else if (req.write) begin
          @(posedge slave_if.clk);  // ✅ 첫 beat 대기
          
          for (int i = 0; i < data_size; i++) begin
            req.data[i] = slave_if.data;
            req.wait_state[i] = slave_if.wait_state;
            
            `uvm_info("SLAVE_MON", 
              $sformatf("Write [%0d]: 0x%02h wait=%0b", 
                        i, req.data[i], req.wait_state[i]), UVM_MEDIUM)
            
            // ✅ 다음 beat로 이동
            if (i < data_size - 1) @(posedge slave_if.clk);
          end
        end
        
        req.error = slave_if.error;
        item_collected_port.write(req);
        
        `uvm_info("SLAVE_MON", 
          $sformatf(">>> 완료 <<< addr=0x%0h data=%p", 
                    req.addr, req.data), UVM_MEDIUM)
        
        // 다음 트랜잭션 대기
        while (slave_if.read || slave_if.write) @(posedge slave_if.clk);
        transaction_started = 0;
      end
    end
  endtask
endclass : jk_ubus_slave_monitor
