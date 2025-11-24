class router_env extends uvm_env;  

   

  input_agent i_agt;  

  `uvm_component_utils(router_env)  

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);  
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);  

     

    i_agt = input_agent::type_id::create("i_agt", this);  


     
     
    uvm_config_db #(uvm_object_wrapper)::set(this, "i_agt.sqr.main_phase", "default_sequence", packet_sequence::get_type());
     
     
    


  endfunction: build_phase

endclass: router_env
