 
 
 
 
 
 
 

class packet_sequence_base extends uvm_sequence #(packet);
  `uvm_object_utils(packet_sequence_base)

  function new(string name = "packet_sequence_base");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    `ifndef UVM_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction: new

  `ifdef UVM_VERSION_1_1
  virtual task pre_start();
    if ((get_parent_sequence() == null) && (starting_phase != null)) begin
      starting_phase.raise_objection(this);
    end
  endtask: pre_start

  virtual task post_start();
    if ((get_parent_sequence() == null) && (starting_phase != null)) begin
      starting_phase.drop_objection(this);
    end
  endtask: post_start
  `endif
endclass: packet_sequence_base

class packet_sequence extends packet_sequence_base;

   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   

  int       item_count = 10;
  int       port_id    = -1;
  int       valid_da[$];

   
   
  typedef int int_q_t[$];

   
  `uvm_object_utils_begin(packet_sequence)
    `uvm_field_int(item_count, UVM_ALL_ON)
    `uvm_field_queue_int(valid_da, UVM_ALL_ON)
    `uvm_field_int(port_id, UVM_ALL_ON)
  `uvm_object_utils_end

   
   
   
   
  virtual task pre_start();
    super.pre_start();

    uvm_config_db#(int)::get(get_sequencer(), get_type_name(), "item_count", item_count);
    uvm_config_db#(int_q_t)::get(get_sequencer(), get_type_name(), "valid_da", valid_da);
    uvm_config_db#(int)::get(get_sequencer().get_parent(), "", "port_id",port_id);
    if (!(port_id inside {-1, [0:15]})) begin
      `uvm_fatal("CFGERR", $sformatf("Illegal port_id value of %0d", port_id));
    end
  endtask: pre_start

  function new(string name = "packet_sequence");
    super.new(name);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    for (int i=0; i<16; i++) begin
      valid_da.push_back(i);     
    end
  endfunction: new

  virtual task body();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

     
     
    repeat(item_count) begin

       
       
       
       
       
       
       
       
       
       
      `ifndef UVM_VERSION
        `uvm_do_with(req, {if (port_id == -1) sa inside {[0:15]}; else sa == port_id; da inside valid_da;});
       
      `else
        `uvm_do(req,,, {if (port_id == -1) sa inside {[0:15]}; else sa == port_id; da inside valid_da;});
      `endif

    end
 endtask: body

endclass: packet_sequence
