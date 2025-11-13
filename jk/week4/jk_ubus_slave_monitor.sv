class jk_ubus_slave_monitor extends uvm_monitor;
  `uvm_component_utils(jk_ubus_slave_monitor)

  virtual jk_ubus_slave_if slave_vif;

  uvm_analysis_port#(jk_ubus_slave_transfer) item_collected_port;
  uvm_analysis_port#(jk_ubus_slave_transfer) request_aport;
  
  // Master monitor로부터 받은 트랜잭션을 받기 위한 분석 임포트
  uvm_analysis_imp#(jk_ubus_slave_transfer, jk_ubus_slave_monitor) master_req_imp;

  typedef enum {IDLE, ADDR_PHASE, DATA_PHASE, COMPLETE} monitor_state_e;
  monitor_state_e current_state = IDLE;
  int data_beat_count = 0;
  jk_ubus_slave_transfer current_trans;


  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
    request_aport = new("request_aport", this);
    master_req_imp = new("master_req_imp", this);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual jk_ubus_slave_if)::get(this, "", "slave_vif", slave_vif)) begin
      `uvm_fatal("NOVIF", "virtual interface not set for monitor")
    end
  endfunction

  // Master monitor로부터 트랜잭션을 받았을 때 호출되는 함수
  function void write(jk_ubus_slave_transfer t);
    `uvm_info("SLAVE_MON", $sformatf("<<< Master에서 수신한 트랜잭션 >>> addr=0x%0h size=%0d read=%0b write=%0b", 
              t.addr, t.size, t.read, t.write), UVM_MEDIUM)
    `uvm_info("SLAVE_MON", $sformatf("Master 트랜잭션 데이터: %p", t.data), UVM_MEDIUM)
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      jk_ubus_slave_transfer req;
      bit transaction_started = 0;

      @(posedge slave_vif.clk);
      if (slave_vif == null) begin
        continue;
      end
      
      // Master로부터 읽기/쓰기 요청 감지
      if ((slave_vif.read || slave_vif.write) && !transaction_started) begin
        transaction_started = 1;
        req = new("req");
        req.addr = slave_vif.addr;
        case (slave_vif.size)
          2'b00: req.size = 1;
          2'b01: req.size = 2;
          2'b10: req.size = 4;
          2'b11: req.size = 8;
        endcase
        req.read  = slave_vif.read;
        req.write = slave_vif.write;
        req.data  = new[req.size];
        req.wait_state = new[req.size];
        
        `uvm_info("SLAVE_MON", $sformatf(">>> Slave 인터페이스에서 Master 요청 감지 <<< addr=0x%0h size=%0d read=%0b write=%0b", 
                  req.addr, req.size, req.read, req.write), UVM_MEDIUM)
        
        request_aport.write(req);
        
        // 데이터 수집
        if (req.read) begin
          // Read: slave가 데이터를 드라이브할 때까지 대기
          // master driver는 read 후 bip=0으로 시작하고, read/write를 0으로 만듦
          @(posedge slave_vif.clk);  // 주소/컨트롤 사이클 다음
          for (int i = 0; i < req.size; i++) begin
            // slave driver가 wait_state를 해제하고 데이터를 드라이브할 때까지 대기
            while (slave_vif.wait_state && (slave_vif.read || slave_vif.write)) @(posedge slave_vif.clk);
            req.data[i] = slave_vif.data;
            req.wait_state[i] = slave_vif.wait_state;
            `uvm_info("SLAVE_MON", $sformatf("Read 데이터 수집[%0d]: 0x%02h wait_state=%0b", i, req.data[i], req.wait_state[i]), UVM_HIGH)
            if (i < req.size - 1) @(posedge slave_vif.clk);
          end
        end else if (req.write) begin
          // Write: master가 데이터를 드라이브하는 동안 수집
          // master driver는 write 후 다음 사이클부터 데이터를 전송
          @(posedge slave_vif.clk);  // 주소/컨트롤 사이클 다음
          for (int i = 0; i < req.size; i++) begin
            // master가 드라이브하는 데이터를 수집
            req.data[i] = slave_vif.data;
            req.wait_state[i] = slave_vif.wait_state;
            `uvm_info("SLAVE_MON", $sformatf("Write 데이터 수집[%0d]: 0x%02h wait_state=%0b bip=%0b", 
                      i, req.data[i], req.wait_state[i], slave_vif.bip), UVM_HIGH)
            if (i < req.size - 1) @(posedge slave_vif.clk);
          end
          // Write 완료 후 error 신호 확인
          @(posedge slave_vif.clk);
        end
        
        req.error = slave_vif.error;
        item_collected_port.write(req);
        
        `uvm_info("SLAVE_MON", $sformatf(">>> Slave Monitor 트랜잭션 완료 <<< addr=0x%0h size=%0d read=%0b write=%0b error=%0b", 
                  req.addr, req.size, req.read, req.write, req.error), UVM_MEDIUM)
        `uvm_info("SLAVE_MON", $sformatf("수집된 데이터: %p", req.data), UVM_MEDIUM)
        
        // 다음 트랜잭션을 위해 대기 (read/write 신호가 해제될 때까지)
        while (slave_vif.read || slave_vif.write) @(posedge slave_vif.clk);
        transaction_started = 0;
      end
    end
  endtask
endclass : jk_ubus_slave_monitor
