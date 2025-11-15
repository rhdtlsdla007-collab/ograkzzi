class jk_ubus_scoreboard extends uvm_scoreboard;
`uvm_component_utils_begin(jk_ubus_scoreboard)
    `uvm_field_int(num_writes, UVM_DEFAULT|UVM_DEC)
    `uvm_field_int(num_reads, UVM_DEFAULT|UVM_DEC)
`uvm_connect_utils_end

uvm_analysis_imp#(jk_ubus_transfer, jk_ubus_scoreboard) item_collected_export;

protected int num_writes = 0;
protected int num_reads = 0;
protected int unsigned m_mem_expected[int unsigned];

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    item_collected_export= new("item_collected_export", this);
endfunction

function void write(jk_ubus_transfer trans);
    memory_verify(trans);
endfunction

protected function void memory_verify(input jk_ubus_transfer trans);
    for(int i = 0; i < trans.size; i++) begin
        int unsigned addr = trans.addr + i;
        int unsigned data = trans.data[i];
        if (trans.read) begin
            if (m_mem_expected.exists(addr)) begin
                assert(m_mem_expected[addr] == data) else
                `uvm_error("SCOREBOARD", "Data mismatch!")
            end else begin
                m_mem_expected[addr] = data; //첫  READ는 저장
            end
        end
        if (trans.write) begin
            m_mem_expected[addr] = data;
        end
    end
endfunction

virtual function void report_phase(uvm_phase phase);
`uvm_info("SCOREBOARD", $sformatf("Final Report: %d writes, %d reads", num_writes, num_reads), UVM_LOW)
endfunction
endclass