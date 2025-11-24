 
 
 
 

class top_reset_sequence extends uvm_sequence;
  `uvm_object_utils(top_reset_sequence)

   
   
   
   
   
   
   
   
  `uvm_declare_p_sequencer(top_reset_sequencer)


   
   
   
   
   
   
   
   
   
   
   
   
  reset_sequence                    r_seq;
  router_input_port_reset_sequence  i_seq;


   
   
   
   
   
   
   
  uvm_event reset_event = uvm_event_pool::get_global("reset");

  function new(string name="virtual_reset_sequence");
    super.new(name);    
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    `ifndef UVM_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction: new

  virtual task body();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
 


     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     

 


     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     

     
     
    `ifndef UVM_VERSION
      fork
        `uvm_do_on(r_seq, p_sequencer.r_sqr);
        foreach (p_sequencer.pkt_sqr[i]) begin
          fork
            int j = i;
            begin
              reset_event.wait_on();
              `uvm_do_on(i_seq, p_sequencer.pkt_sqr[j]);
            end
          join_none
        end
      join
     
     
     
    `else
      fork
        `uvm_do(r_seq, p_sequencer.r_sqr);
        foreach (p_sequencer.pkt_sqr[i]) begin
          fork
            int j = i;
            begin
              reset_event.wait_on();
              `uvm_do(i_seq, p_sequencer.pkt_sqr[j]);
            end
          join_none
        end
      join
    `endif

  endtask: body

  `ifdef UVM_VERSION_1_1
  virtual task pre_start();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if ((get_parent_sequence() == null) && (starting_phase != null)) begin
      starting_phase.raise_objection(this);
    end
  endtask: pre_start

  virtual task post_start();
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
    if ((get_parent_sequence() == null) && (starting_phase != null)) begin
      starting_phase.drop_objection(this);
    end
  endtask: post_start
  `endif

endclass: top_reset_sequence
