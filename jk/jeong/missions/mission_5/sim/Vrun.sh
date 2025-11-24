#!/bin/bash

# clean
    rm -rf csrc *.log simv.daidir ucli.key verdi_config_file verdiLog *sim* cov_db* *.h novas*

# compile
    verilator --binary -Mdir Vsim -f filelist.f -Wno-lint -Wno-MULTIDRIVEN \
    -o Vsimv --top tb_top -timescale 1ns/1ps -error-limit 100 --trace \
    2>&1 | tee Vcomp.log

# run Simulation
    # ./Vsim/Vsimv +num=16 +USE_VALID_ADDR 2>&1 | tee Vsim.log

    # ./Vsim/Vsimv +num=16 2>&1 | tee Vsim.log

    ./Vsim/Vsimv 2>&1 | tee Vsim.log

# run Verdi
    # vcd2fsdb sv_sim.vcd -o sv_sim.fsdb

    # verdi -ssf sv_sim.fsdb