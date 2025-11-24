 
 
 
 
 
 
 
 
 
 
 
 
 

 
class top_reset_sequencer extends uvm_sequencer;
  `uvm_component_utils(top_reset_sequencer)

  typedef uvm_sequencer#(reset_tr) reset_sequencer;
  typedef uvm_sequencer#(packet)   packet_sequencer;

  reset_sequencer  r_sqr;
  packet_sequencer pkt_sqr[$];

  function new(string name, uvm_component parent);
    super.new(name, parent);    
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new
endclass: top_reset_sequencer

