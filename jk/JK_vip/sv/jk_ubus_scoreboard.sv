`uvm_analysis_imp_decl(_master)
`uvm_analysis_imp_decl(_slave)

class jk_ubus_scoreboard extends uvm_scoreboard;
`uvm_component_utils_begin(jk_ubus_scoreboard)
    `uvm_field_int(num_writes, UVM_DEFAULT|UVM_DEC)
    `uvm_field_int(num_reads, UVM_DEFAULT|UVM_DEC)
`uvm_component_utils_end

uvm_analysis_imp_master#(jk_ubus_master_transfer, jk_ubus_scoreboard) master_item_collected_export;
uvm_analysis_imp_slave#(jk_ubus_master_transfer, jk_ubus_scoreboard) slave_item_collected_export;

protected int num_writes = 0;
protected int num_reads = 0;
protected int unsigned m_mem_expected[int unsigned];

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    master_item_collected_export = new("master_item_collected_export", this);
    slave_item_collected_export = new("slave_item_collected_export", this);
endfunction

// Master Monitor에서 오는 트랜잭션 처리
function void write_master(jk_ubus_master_transfer trans);
    `uvm_info("SCOREBOARD", $sformatf("MASTER: read=%0d, write=%0d, addr=0x%0h, size=%0d", 
        trans.read, trans.write, trans.addr, trans.data.size()), UVM_MEDIUM)
    
    // Master가 Write 요청을 보냄 → 예상 메모리에 저장
    if (trans.write) begin 
        num_writes++;
        for(int i = 0; i < trans.data.size(); i++) begin
            int unsigned addr = trans.addr + i;
            int unsigned data = trans.data[i];
            m_mem_expected[addr] = data;
            `uvm_info("SCOREBOARD", 
                $sformatf("MASTER Write: addr=0x%0h, data=0x%0h", addr, data), UVM_HIGH)
        end
    end
    
    // Master가 Read 요청을 보냄 → 나중에 Slave 응답과 비교할 것이므로 기록만
    if (trans.read) begin 
        num_reads++;
        `uvm_info("SCOREBOARD", 
            $sformatf("MASTER Read Request: addr=0x%0h, size=%0d", trans.addr, trans.data.size()), UVM_HIGH)
    end
endfunction

// Slave Monitor에서 오는 트랜잭션 처리
function void write_slave(jk_ubus_master_transfer trans);
    `uvm_info("SCOREBOARD", $sformatf("SLAVE: read=%0d, write=%0d, addr=0x%0h, size=%0d", 
        trans.read, trans.write, trans.addr, trans.data.size()), UVM_MEDIUM)
    
    // Slave가 Read 응답을 보냄 → 예상 메모리와 비교
    if (trans.read) begin 
        for(int i = 0; i < trans.data.size(); i++) begin
            int unsigned addr = trans.addr + i;
            int unsigned data = trans.data[i];
            
            if (m_mem_expected.exists(addr)) begin
                if (m_mem_expected[addr] != data) begin
                    `uvm_error("SCOREBOARD", 
                        $sformatf("SLAVE Read Data MISMATCH at addr 0x%0h: Expected 0x%0h, Got 0x%0h", 
                        addr, m_mem_expected[addr], data))
                end else begin
                    `uvm_info("SCOREBOARD", 
                        $sformatf("SLAVE Read Data PASS at addr 0x%0h: Data 0x%0h", addr, data), UVM_HIGH)
                end
            end else begin
                `uvm_warning("SCOREBOARD", 
                    $sformatf("SLAVE Read from uninitialized address 0x%0h (Got 0x%0h)", addr, data))
            end
        end
    end
    
    // Slave가 Write를 받음 → 이미 Master에서 저장했으므로 확인만
    if (trans.write) begin 
        for(int i = 0; i < trans.data.size(); i++) begin
            int unsigned addr = trans.addr + i;
            int unsigned data = trans.data[i];
            `uvm_info("SCOREBOARD", 
                $sformatf("SLAVE received Write: addr=0x%0h, data=0x%0h", addr, data), UVM_HIGH)
        end
    end
endfunction

virtual function void report_phase(uvm_phase phase);
    `uvm_info("SCOREBOARD", $sformatf("Final Report: %0d writes, %0d reads", num_writes, num_reads), UVM_LOW)
endfunction
endclass