class jk_ubus_slave_agent extends uvm_agent;
    `uvm_component_utils(jk_ubus_slave_agent)

    jk_ubus_slave_sequencer sequencer;
    jk_ubus_slave_driver driver;
    jk_ubus_slave_monitor monitor;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sequencer = jk_ubus_slave_sequencer::type_id::create("sequencer", this);
        driver = jk_ubus_slave_driver::type_id::create("driver", this);
        monitor = jk_ubus_slave_monitor::type_id::create("monitor", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
        monitor.request_aport.connect(sequencer.request_fifo.analysis_export);  
    endfunction
endclass: jk_ubus_slave_agent
