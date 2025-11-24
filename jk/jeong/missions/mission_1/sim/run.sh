#!/bin/bash

# clean
    rm -rf csrc *.log simv.daidir ucli.key verdi_config_file verilog_sim.* simv

# compile
    vcs -full64 -kdb -debug_access+all -f filelist.f -l comp.log -o simv -sverilog -timescale="1ns/1ps" +define+VCS

# run Simulation
    #./simv +num=16 +USE_VALID_ADDR -l sim.log

    #./simv +num=16 -l sim.log

    ./simv -l sim.log

# run Verdi
#     verdi -ssf verilog_sim.fsdb