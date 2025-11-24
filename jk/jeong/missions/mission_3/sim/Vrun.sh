#!/bin/bash

# clean
    rm -rf csrc *.log simv.daidir ucli.key verdi_config_file *sim*

# compile
    verilator --binary -Mdir Vsim -f filelist.f -Wno-lint -Wno-MULTIDRIVEN \
    -o Vsimv --top tb_top -timescale 1ns/1ps -error-limit 100 --trace \
    2>&1 | tee Vcomp.log

# run Simulation
    # ./Vsim/Vsimv +USE_VALID_ADDR 2>&1 | tee Vsim.log

    ./Vsim/Vsimv 2>&1 | tee Vsim.log
