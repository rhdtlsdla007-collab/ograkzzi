class jk_ubus_scoreboard extends uvm_scoreboard;

uvm_analysis_imp#(jk_ubus_master_transfer, jk_ubus_scoreboard) item_collected_export;

protected int num_mismatches = 0;
protected int num_writes = 0;
protected int num_reads = 0;
protected int unsigned m_mem_expected[int unsigned];

`uvm_component_utils_begin(jk_ubus_scoreboard)
    `uvm_field_int(num_writes, UVM_DEFAULT|UVM_DEC)
    `uvm_field_int(num_reads, UVM_DEFAULT|UVM_DEC)
`uvm_component_utils_end

function new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void build_phase(uvm_phase phase);
    item_collected_export= new("item_collected_export", this);
endfunction

function void write(jk_ubus_master_transfer trans);
    memory_verify(trans);
endfunction

protected function void memory_verify(input jk_ubus_master_transfer trans);
    int data_yam = size_to_beats(trans.size);
    for(int i = 0; i < data_yam ; i++) begin
        int unsigned addr = trans.addr + i;
        int unsigned data = trans.data[i];

        if (trans.read) begin
            num_reads++;
            if (m_mem_expected.exists(addr)) begin
                assert(m_mem_expected[addr] == data) else
                `uvm_error("SCOREBOARD", "Data mismatch!")
            end else begin
                m_mem_expected[addr] = data; //첫  READ는 저장
            end
        end
        if (trans.write) begin
            num_writes++;
            m_mem_expected[addr] = data;
        end
    end
endfunction

virtual function void report_phase(uvm_phase phase);
`uvm_info("SCOREBOARD", $sformatf("Final Report: %d writes, %d reads", num_writes, num_reads), UVM_LOW)
endfunction

function automatic int unsigned size_to_beats(bit [1:0] size_value);
    case (size_value)
      2'b00: return 1;
      2'b01: return 2;
      2'b10: return 4;
      default: return 8;
    endcase
  endfunction

endclass