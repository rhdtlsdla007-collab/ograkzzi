class jk_ubus_env extends uvm_env;
    `uvm_component_utils(jk_ubus_env)

    jk_ubus_virtual_sequencer virtual_sequencer;
    jk_ubus_slave_agent slave_agent;
    jk_ubus_master_agent master_agent;
    jk_ubus_scoreboard scoreboard;
    coverage_sb ubus_coverage;

    function new(string name = "jk_ubus_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        slave_agent = jk_ubus_slave_agent::type_id::create("slave_agent", this);
        master_agent = jk_ubus_master_agent::type_id::create("master_agent", this);
	    virtual_sequencer = jk_ubus_virtual_sequencer::type_id::create("virtual_suencer", this);
       scoreboard = jk_ubus_scoreboard::type_id::create("scoreboard", this);
       ubus_coverage = coverage_sb::type_id::create("ubus_coverage", this);
    endfunction

    function void connect_phase(uvm_phase phase);
       master_agent.monitor.item_collected_port.connect(scoreboard.master_item_collected_export);
     //  master_agent.monitor.item_collected_port.connect(ubus_coverage.master_analysis_export); 
       slave_agent.monitor.item_collected_port.connect(scoreboard.slave_item_collected_export);
     //  slave_agent.monitor.item_collected_port.connect(ubus_coverage.slave_analysis_export); 
       virtual_sequencer.master_sequencer = master_agent.sequencer;
       virtual_sequencer.slave_sequencer = slave_agent.sequencer;
       master_agent.monitor.item_collected_port.connect(ubus_coverage.analysis_export);
    endfunction



endclass: jk_ubus_env
