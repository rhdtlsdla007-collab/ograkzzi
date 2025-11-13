import uvm_pkg::*;

class ubus_transfer extends uvm_sequence_item;
    rand bit [15:0] addr;
    rand bit [7:0] data;
    rand bit read;
    rand bit write;
    rand bit [1:0] size;
    rand bit wait_state;
    rand bit error;

    function new(string name = "ubus_transfer");
        super.new(name);
    endfunction : new

    `uvm_object_utils_begin(ubus_transfer)
        `uvm_field_int(addr, UVM_ALL_ON)
        `uvm_field_int(data, UVM_ALL_ON)
        `uvm_field_int(read, UVM_ALL_ON)
        `uvm_field_int(write, UVM_ALL_ON)
        `uvm_field_int(size, UVM_ALL_ON)
        `uvm_field_int(wait_state, UVM_ALL_ON)
        `uvm_field_int(error, UVM_ALL_ON)
    `uvm_object_utils_end
endclass