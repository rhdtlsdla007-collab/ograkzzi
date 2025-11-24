class input_agent extends uvm_agent;
  `uvm_component_utils(input_agent)

   
   
   
   
   
   
   

  typedef uvm_sequencer#(packet) packet_sequencer;

   

  packet_sequencer sqr;
  driver drv;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

     
     
     

    sqr = packet_sequencer::type_id::create("sqr", this);
    drv = driver::type_id::create("drv", this);
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

     
     

    drv.seq_item_port.connect(sqr.seq_item_export);
  endfunction: connect_phase

endclass: input_agent
