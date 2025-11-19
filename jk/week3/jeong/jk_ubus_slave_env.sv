class jk_ubus_slave_env extends uvm_env;
    `uvm_component_utils(jk_ubus_slave_env)

    jk_ubus_slave_agent slave_agent;

    function new(string name = "jk_ubus_slave_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        slave_agent = jk_ubus_slave_agent::type_id::create("slave_agent", this);
    endfunction



endclass: jk_ubus_slave_env
