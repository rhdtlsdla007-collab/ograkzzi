class jk_ubus_virtual_sequence extends uvm_sequence;
 `uvm_object_utils(jk_ubus_virtual_sequence)
 `uvm_declare_p_sequencer(jk_ubus_virtual_sequencer)

 incr_read_byte_seq	m_incr_read_seq;
 incr_write_byte_seq	m_incr_write_seq;
 incr_read_write_read_seq m_incr_rwr_seq;
 //read_modify_write_seq 	m_rmw_seq;
 ubus_slave_sequence	s_slave_seq;

 function new(string name = "jk_ubus_virtual_sequence");
	super.new(name);
 endfunction

 virtual task body();
 	m_incr_read_seq = incr_read_byte_seq::type_id::create("m_incr_read_seq");
	m_incr_write_seq = incr_write_byte_seq::type_id::create("m_incr_write_seq");
	m_incr_rwr_seq = incr_read_write_read_seq::type_id::create("m_incr_rwr_seq");
	m_rmw_seq = read_modify_write_seq::type_id::create("m_rmw_seq");
	s_slave_seq = ubus_slave_sequence::type_id::create("s_slave_seq");
 fork
	s_slave_seq.start(p_sequencer.slave_sequencer);
 join_none

 m_incr_read_seq.start(p_sequencer.master_sequencer);
 m_incr_write_seq.start(p_sequencer.master_sequencer);
 m_incr_rwr_seq.start(p_sequencer.master_sequencer);
 //m_rmw_seq.start(p_sequencer.master_sequencer);
 endtask

endclass

