#!/bin/bash

# clean
    rm -rf csrc *.log simv.daidir ucli.key verdi_config_file verdiLog *sim* cov_db* *.h novas*

# compile
    vcs -full64 -kdb -debug_access+all -f filelist.f -l comp.log -o simv -sverilog -timescale="1ns/1ps" +define+VCS \
    -cm line+cond+tgl+fsm+branch -cm_name test1

# run Simulation
    #./simv +num=16 +USE_VALID_ADDR -l sim.log

     ./simv +num=20 -l sim.log

   # ./simv -l sim.log

# run Verdi
    # verdi -ssf verilog_sim.fsdb

# check Coverage
     urg -full64 -dir simv.vdb
     firefox urgReport/dashboard.html

    #  verdi -cov -covdir simv.vdb
     verdi -ssf sv_sim.fsdb -dbdir simv.daidir
