rm -rf *.log simv* *.key csrc *.h

vcs -full64 -sverilog -timescale="1ns/100ps" -l comp.log -ntb_opts uvm-ieee-2020-2.0 -l comp.log ./jk_ubus_interface.sv ./jk_ubus_transfer.sv ./jk_ubus_master_sequence.sv ./jk_ubus_master_sequencer.sv ./jk_ubus_master_driver.sv ./jk_ubus_master_monitor.sv ./jk_ubus_master_agent.sv ./jk_ubus_master_env.sv ./jk_ubus_master_test.sv ./jk_ubus_tb_top.sv

./simv -l simv.log  +UVM_TESTNAME=jk_ubus_master_test  +UVM_VERBOSITY=UVM_MEDIUM

