# clean
    rm -rf csrc *.log simv.daidir ucli.key verdi_config_file verilog_sim.* simv

# compile
    vcs -full64 -kdb -f filelist.f -sverilog -lca -debug_access+all+reverse -kdb +vcs+vcdpluson -timescale="1ns/100ps" -l comp.log -ntb_opts uvm-1.2

# run Simulation
    #./simv +num=16 +USE_VALID_ADDR -l sim.log

    #./simv +num=16 -l sim.log

    ./simv +UVM_TESTNAME=ubus_example_base_test +UVM_VERBOSITY=UVM_MEDIUM -l sim.log