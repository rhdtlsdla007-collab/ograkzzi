`include "packet.sv"


class simple_driver extends uvm_driver#(packet);
    `uvm_component_utils(simple_driver)


    function new(string name = "simple_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            `uvm_info("DRV_RUN", req.sprint(), UVM_MEDIUM);
            seq_item_port.item_done();
        end
    endtask : run_phase
endclass : simple_driver