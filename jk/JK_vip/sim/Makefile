test = jk_ubus_virtual_sequence_test
program_path = ../sv
slave_path = ../sv/slave
master_path = ../sv/master
PROGRAM_TOP = ${program_path}/top.sv
SLAVE_INTERFACE = ${program_path}/slave/jk_ubus_slave_if.sv
MASTER_INTERFACE = ${program_path}/master/jk_ubus_master_if.sv
common_path = ../sv/common
COMMON_FILES = ${common_path}/jk_ubus_common_pkg.sv

TEST_TOP = ${SLAVE_INTERFACE} ${MASTER_INTERFACE} ${COMMON_FILES} ${PROGRAM_TOP}
log = simv.log
verbosity = UVM_HIGH
uvm_ver = uvm-1.2
seed = 1
uvm_defines = UVM_NO_DEPRECATED+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR
option = UVM_TR_RECORD +UVM_LOG_RECORD

CES64 = TRUE

compile_switches = -sverilog -lca -debug_access+all+reverse -kdb +vcs+vcdpluson -timescale="1ns/100ps" -l comp.log -ntb_opts ${uvm_ver} +incdir+${program_path}+${master_path}+${slave_path}+${common_path} ${TEST_TOP} +define+${uvm_defines}+${defines} -q -cm line+cond+fsm+tgl+branch+assert -cm_dir simv.vdb
runtime_switches = -l ${log} +UVM_TESTNAME=${test} +UVM_VERBOSITY=${verbosity} +UVM_COMPONENT_TRACE +${plus} +${trace} +${option}

all: clean simv run

simv compile: ${TEST_TOP}
ifeq ($(CES64),TRUE)
	vcs -full64 ${compile_switches}
	@echo "Compiled in 64-bit mode"
else
	vcs ${compile_switches}
	@echo "Compiled in 32-bit mode"
endif

run:
	./simv +ntb_random_seed=${seed} ${runtime_switches}

random: simv
	./simv +ntb_random_seed_automatic ${runtime_switches}

clean:
	rm -rf simv* csrc* *.tmp *.vpd *.key log *.h temp *.log .vcs* *.txt DVE* *.hvp urg* .inter.vpd.uvm .restart* .synopsys* novas.* *.dat *.fsdb verdi*
	
cover:
	urg -dir simv.vdb
	urg -dir simv.vdb -format text

help:
	@echo =======================================================================
	@echo  " 								       "
	@echo  " USAGE: make target <seed=xxx> <verbosity=YYY> <test=ZZZ>              "
	@echo  " 								       "
	@echo  "  xxx is the random seed.  Can be any integer except 0. Defaults to 1  "
	@echo  "  YYY sets the verbosity filter.  Defaults to UVM_MEDIUM               "
	@echo  "  ZZZ selects the uvm test.       Defaults to test_base                "
	@echo  " 								       "
	@echo  " ------------------------- Test TARGETS ------------------------------ "
	@echo  " all             => Compile TB and DUT files and run the simulation    "
	@echo  " uvm-1.1         => Compile TB and DUT files and run the simulation    "
	@echo  " uvm-1.2         => Compile TB and DUT files and run the simulation    "
	@echo  " compile         => Compile TB and DUT files                           "
	@echo  " run             => Run the simulation with seed                       "
	@echo  " random          => Run the simulation with random seed                "
	@echo  "                                                                       "
	@echo  " -------------------- ADMINISTRATIVE TARGETS ------------------------- "
	@echo  " help       => Displays this message                                   "
	@echo  " clean      => Remove all intermediate simv and log files              "
	@echo  " nuke       => Remove all source code and debug files                  "
	@echo  " original   => Return content of lab back to original state            "
	@echo  " copy       => Copy all necessary files for starting lab               "
	@echo  " solution   => Copy files from solutions directory for lab             "
	@echo  "								       "
	@echo  " ---------------------- EMBEDDED SETTINGS -----------------------------"
	@echo  " -timescale=\"1ns/100ps\"                                              "
	@echo  " -debug_all                                                            "
	@echo =======================================================================
