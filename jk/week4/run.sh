rm -rf *.log simv* *.key csrc *.h *.fsdb

vcs -full64 -sverilog -kdb -lca -debug_access+all -timescale="1ns/100ps" -l comp.log -ntb_opts uvm-ieee-2020-2.0 -l comp.log ./top.sv
 
./simv -l simv.log  +UVM_TESTNAME=jk_ubus_write_test  +UVM_VERBOSITY=UVM_MEDIUM

