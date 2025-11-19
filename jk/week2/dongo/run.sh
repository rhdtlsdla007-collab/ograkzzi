rm -rf *.log simv* *.key csrc *.h

vcs -full64 -sverilog -timescale="1ns/100ps" -l comp.log -ntb_opts uvm-1.2 -l comp.log ./ubus_transfer.sv ./ubus_env.sv ./ubus_test_base.sv ./ubus_tb_top.sv

./simv -l simv.log  +UVM_TESTNAME=ubus_test_base +UVM_VERBOSITY=UVM_MEDIUM

