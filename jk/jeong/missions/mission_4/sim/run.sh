#!/bin/bash

# clean
    rm -rf csrc *.log simv.daidir ucli.key verdi_config_file *sim*

# compile
    vcs -full64 -kdb -debug_access+all -f filelist.f -l comp.log -o simv -sverilog -timescale="1ns/1ps" +define+VCS

# run Simulation
    # ./simv +USE_VALID_ADDR -l sim.log

    ./simv -l sim.log

# run Verdi
   #  verdi -ssf sv_sim.fsdb -dbdir simv.daidir
