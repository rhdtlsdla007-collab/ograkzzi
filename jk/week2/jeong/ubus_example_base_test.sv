import uvm_pkg::*;

class ubus_example_base_test extends uvm_test;
    `uvm_component_utils(ubus_example_base_test)
    ubus_env env;

    function new(string name = "ubus_example_base_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = ubus_env::type_id::create("env", this);
    endfunction : build_phase

    virtual function void start_of_simulation_phase(uvm_phase phase);
        super.start_of_simulation_phase(phase);
        uvm_root::get().print_topology();
        if (env != null && env.tr != null) begin
            env.tr.randomize();
            env.tr.print();
        end
    endfunction : start_of_simulation_phase
endclass : ubus_example_base_test