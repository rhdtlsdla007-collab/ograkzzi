import uvm_pkg::*;

class ubus_env extends uvm_env;
    ubus_transfer tr;
    `uvm_component_utils(ubus_env)
    function new(string name = "ubus_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr = ubus_transfer::type_id::create("tr", this);
    endfunction : build_phase
endclass : ubus_env