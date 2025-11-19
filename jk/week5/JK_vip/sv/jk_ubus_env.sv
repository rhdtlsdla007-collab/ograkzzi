import jk_ubus_master_pkg::*;

class jk_ubus_env extends uvm_env;
    `uvm_component_utils(jk_ubus_env)

    jk_ubus_slave_agent slave_agent;
    jk_ubus_master_agent master_agent;
    // jk_ubus_scoreboard scoreboard;

    function new(string name = "jk_ubus_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        slave_agent = jk_ubus_slave_agent::type_id::create("slave_agent", this);
        master_agent = jk_ubus_master_agent::type_id::create("master_agent", this);
        // scoreboard = jk_ubus_scoreboard::type_id::create("scoreboard", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        // master_agent.monitor.item_collected_port.connect(scoreboard.item_collected_export);
    endfunction



endclass: jk_ubus_env
