class jk_ubus_write_test extends uvm_test;
    `uvm_component_utils(jk_ubus_write_test)
    jk_ubus_env env;

    function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = jk_ubus_env::type_id::create("env", this);
        uvm_config_db#(uvm_object_wrapper)::set(this, "env.master_agent.sqr.run_phase", "default_sequence", jk_ubus_master_sequence::type_id::get());
        uvm_config_db#(uvm_object_wrapper)::set(this, "env.slave_agent.sequencer.run_phase", "default_sequence", jk_ubus_slave_sequence::type_id::get());
    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            #1000ns;
        phase.drop_objection(this);
    endtask
endclass : jk_ubus_write_test

class jk_ubus_read_test extends jk_ubus_write_test;
    `uvm_component_utils(jk_ubus_read_test)

    jk_ubus_env env;

    function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = jk_ubus_env::type_id::create("env", this);
        uvm_config_db#(uvm_object_wrapper)::set(this, "env.master_agent.sequencer.run_phase", "default_sequence", jk_ubus_master_sequence::type_id::get());
        uvm_config_db#(uvm_object_wrapper)::set(this, "env.slave_agent.sequencer.run_phase", "default_sequence", jk_ubus_slave_sequence::type_id::get());
    endfunction 

    function void end_of_elaboration_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
            #1000ns;
        phase.drop_objection(this);
    endtask
endclass : jk_ubus_read_test
