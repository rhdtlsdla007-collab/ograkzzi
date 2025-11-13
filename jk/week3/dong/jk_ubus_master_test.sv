class jk_ubus_master_test extends uvm_test;
 `uvm_component_utils(jk_ubus_master_test)

 jk_ubus_master_env env;
 jk_ubus_master_sequence seq;

 function new(name = "jk_ubus_master_test", uvm_component parent);
	super.new(name, parent);
 endfunction

 function void build_phase(uvm_phase phase);
 	super.build_phase(phase);
	env=jk_ubus_master_env::type_id::create("env", this);
	seq=jk_ubus_master_sequence::type_id::create("seq", this);
 endfunction

 task run_phase(uvm_phase phase);
	phase.raise_objection(this);
	seq.start(env.agt.sqr);
	phase.drop_objection(this);
 endtask

endclass
	
