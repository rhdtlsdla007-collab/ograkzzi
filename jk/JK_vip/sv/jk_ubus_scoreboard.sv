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

function void write_master(jk_ubus_master_transfer trans);
    memory_verify_master(trans);
endfunction

// Master Monitor에서 오는 트랜잭션 처리
protected function void memory_verify_master(jk_ubus_master_transfer trans);
    `uvm_info("SCOREBOARD", $sformatf("MASTER: read=%0d, write=%0d, addr=0x%0h, size=%0d", 
        trans.read, trans.write, trans.addr, trans.data.size()), UVM_MEDIUM)
    
    for(int i = 0; i < trans.data.size(); i++) begin
        int unsigned addr = trans.addr + i;
        int unsigned data = trans.data[i];  
        if (trans.write) begin
            m_mem_expected[addr] = data;
            num_writes++;
            `uvm_info("SCOREBOARD", 
                $sformatf("MASTER Write: addr=0x%0h, data=0x%0h", addr, data), UVM_HIGH)
        end
        if (trans.read) begin
                num_reads++;
                if (m_mem_expected[addr] == data) 
                        `uvm_info("SCOREBOARD", 
                            $sformatf("[MASTER] Read Check PASS: addr=0x%0h, data=0x%0h", addr, data), UVM_HIGH)
                     else begin
                        `uvm_error("SCOREBOARD", 
                            $sformatf("[MASTER] Read Check FAIL: addr=0x%0h, Expected 0x%0h, Got 0x%0h", 
                            addr, m_mem_expected[addr], data))
                    end
                end
        
    end
        
endfunction


function void write_slave(jk_ubus_master_transfer trans);
    memory_verify_slave(trans);
endfunction

protected function void memory_verify_slave(jk_ubus_master_transfer trans);
    `uvm_info("SCOREBOARD", $sformatf("MASTER: read=%0d, write=%0d, addr=0x%0h, size=%0d", 
        trans.read, trans.write, trans.addr, trans.data.size()), UVM_MEDIUM)
        for(int i = 0; i < trans.data.size(); i++) begin
        int unsigned addr = trans.addr + i;
        int unsigned data = trans.data[i];
        if (trans.write) begin
           if(m_mem_expected[addr] == data) begin
            `uvm_info("SCOREBOARD", 
                $sformatf("SLAVE Write PASS : addr=0x%0h, data=0x%0h", addr, data), UVM_HIGH)
		end
	  else begin `uvm_error("SCOREBOARD", $sformatf("SLAVE Write Data MISMATCH at addr 0x%0h: Expected 0x%0h, Got 0x%0h", addr, m_mem_expected[addr], data))
		end
        end

        if (trans.read) begin
           m_mem_expected[addr] = data;
	`uvm_info("SCOREBOARD", 
                $sformatf("SLAVE READ: addr=0x%0h, data=0x%0h", addr, data), UVM_HIGH)
        end
    end
endfunction

    virtual function void report_phase(uvm_phase phase);
        `uvm_info("SCOREBOARD", $sformatf("Final Report: %0d writes, %0d reads", num_writes, num_reads), UVM_LOW)
    endfunction
endclass
