 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

class driver extends uvm_driver #(packet);

   
  `uvm_component_utils(driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);
  endfunction: new

   
   
   
   
   
   
   
   
   
   

  virtual task run_phase(uvm_phase phase);
    `uvm_info("TRACE", $sformatf("%m"), UVM_HIGH);

    forever begin
      seq_item_port.get_next_item(req);

       
       

      send(req);

       
       
       
       
       

      seq_item_port.item_done();
    end
  endtask: run_phase

  virtual task send(packet pkt);

     
     
     
     
     
     
     
     

    `uvm_info("DRV_RUN", {"\n", req.sprint()}, UVM_MEDIUM);
  endtask: send

endclass: driver

