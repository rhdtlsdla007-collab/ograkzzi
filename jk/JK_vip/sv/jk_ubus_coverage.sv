`ifndef JK_UBUS_COVERAGE_SV
`define JK_UBUS_COVERAGE_SV

class jk_ubus_coverage extends uvm_component;
  `uvm_component_utils(jk_ubus_coverage)


  uvm_analysis_imp #(jk_ubus_master_transfer, jk_ubus_coverage) master_analysis_export;
  uvm_analysis_imp #(jk_ubus_master_transfer, jk_ubus_coverage) slave_analysis_export;
  jk_ubus_master_transfer master_tr; 
  jk_ubus_master_transfer slave_tr;  

  
  covergroup fcov_master;
    coverpoint master_tr.addr; // sa에 해당
    coverpoint master_tr.data[0]; // da에 해당 
  endgroup : fcov_master

  covergroup fcov_slave;
    coverpoint slave_tr.addr;
    coverpoint slave_tr.data[0];
  endgroup : fcov_slave

  function new(string name = "jk_ubus_coverage", uvm_component parent = null);
    super.new(name, parent);
    master_analysis_export = new("master_analysis_export", this);
    slave_analysis_export = new("slave_analysis_export", this);
    fcov_master = new();
    fcov_slave = new();
  endfunction

  function void write(jk_ubus_master_transfer tr_in);
    this.master_tr = tr_in;
    if (master_tr.data.size() > 0) begin
      fcov_master.sample(); 
    end
    `uvm_info("COVERAGE", $sformatf("Master Coverage sampled: ADDR=0x%0h READ=%0b SIZE=%0b DATA=%p", 
               master_tr.addr, master_tr.read, master_tr.size, master_tr.data), UVM_LOW);
  endfunction

 
  function void slave_write(jk_ubus_master_transfer tr_in);
    this.slave_tr = tr_in;
    if (slave_tr.data.size() > 0) begin
      fcov_slave.sample(); 
    end
    `uvm_info("COVERAGE", $sformatf("Slave Coverage sampled: ADDR=0x%0h READ=%0b SIZE=%0b DATA=%p", 
               slave_tr.addr, slave_tr.read, slave_tr.size, slave_tr.data), UVM_LOW);
  endfunction

endclass : jk_ubus_coverage

`endif
