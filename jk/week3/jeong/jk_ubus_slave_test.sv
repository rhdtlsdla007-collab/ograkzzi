class jk_ubus_slave_test extends uvm_test;
    `uvm_component_utils(jk_ubus_slave_test)
    jk_ubus_slave_env env;
    jk_ubus_slave_sequence seq;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction


    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = jk_ubus_slave_env::type_id::create("env", this);
        seq = jk_ubus_slave_sequence::type_id::create("seq", this);

    endfunction

    function void start_of_simulation_phase(uvm_phase phase);
	super.start_of_simulation_phase(phase);
	uvm_root::get().print_topology();

    endfunction

    function void end_of_elaboration_phase(uvm_phase phase);
	    uvm_config_db#(uvm_object_wrapper)::set(this,"env.slave_agent.sequencer.run_phase","default_sequence",jk_ubus_slave_sequence::type_id::get());
    endfunction


    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        for (int i = 0; i < 1; i++) begin
            jk_ubus_transfer tr = jk_ubus_transfer::type_id::create($sformatf("tr_%0d", i));
            assert(tr.randomize());
            env.slave_agent.sequencer.request_fifo.put(tr);
        end
        
        #100;
        phase.drop_objection(this);
    endtask
endclass
