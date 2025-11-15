class jk_ubus_scoreboard extends uvm_scoreboard;
`uvm_component_utils_begin(jk_ubus_scoreboard)
    `uvm_field_int(num_writes, UVM_DEFAULT|UVM_DEC)
    `uvm_field_int(num_reads, UVM_DEFAULT|UVM_DEC)
`uvm_component_utils_end

uvm_analysis_imp#(jk_ubus_master_transfer, jk_ubus_scoreboard) master_item_collected_export;
uvm_analysis_imp#(jk_ubus_master_transfer, jk_ubus_scoreboard) slave_item_collected_export;

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


function void write(jk_ubus_master_transfer trans);
    if (trans.read) begin 
        num_reads++;
        for(int i = 0; i < trans.data.size(); i++) begin
            int unsigned addr = trans.addr + i;
            int unsigned data = trans.data[i];
            if (m_mem_expected.exists(addr)) begin
                assert(m_mem_expected[addr] == data) else
                `uvm_error("SCOREBOARD", $sformatf("Master Read Data mismatch at addr 0x%0h: Expected 0x%0h, Got 0x%0h", addr, m_mem_expected[addr], data))
            end
        end
    end
endfunction


function void slave_write(jk_ubus_master_transfer trans);
    if (trans.write) begin 
        num_writes++;
        for(int i = 0; i < trans.data.size(); i++) begin
            int unsigned addr = trans.addr + i;
            int unsigned data = trans.data[i];
            m_mem_expected[addr] = data;
        end
    end else if (trans.read) begin 
        for(int i = 0; i < trans.data.size(); i++) begin
            int unsigned addr = trans.addr + i;
            int unsigned data = trans.data[i];
            if (m_mem_expected.exists(addr)) begin
                assert(m_mem_expected[addr] == data) else
                `uvm_error("SCOREBOARD", $sformatf("Slave Read Data mismatch at addr 0x%0h: Expected 0x%0h, Got 0x%0h", addr, m_mem_expected[addr], data))
            end
        end
    end
endfunction

virtual function void report_phase(uvm_phase phase);
`uvm_info("SCOREBOARD", $sformatf("Final Report: %d writes, %d reads", num_writes, num_reads), UVM_LOW)
endfunction
endclass
