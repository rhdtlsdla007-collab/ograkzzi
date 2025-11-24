class transaction;

    parameter RW_REGION = 8;
    parameter DATA_WIDTH = 32;

    rand bit [RW_REGION-1:0] addr;
    rand bit is_write;
    rand bit [DATA_WIDTH-1:0] data;


    bit pslverr;
    function void print(string tag = "");

        $display("[%s] Transaction = %p", tag, this);
    
    endfunction

    function bit [DATA_WIDTH-1:0] pop_data();
        return (data);
    endfunction

    task copy(transaction cp_tr);
        cp_tr.addr = this.addr;
        cp_tr.data = this.data;
        cp_tr.is_write = this.is_write;
    endtask
endclass
