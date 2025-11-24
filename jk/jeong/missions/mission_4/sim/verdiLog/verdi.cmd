verdiSetActWin -dock widgetDock_<Message>
simSetSimulator "-vcssv" -exec \
           "/DATA/home/edu031/UVM/UVM_TB/missions/mission_4/sim/simv" -args
debImport "-dbdir" \
          "/DATA/home/edu031/UVM/UVM_TB/missions/mission_4/sim/simv.daidir"
debLoadSimResult /DATA/home/edu031/UVM/UVM_TB/missions/mission_4/sim/sv_sim.fsdb
wvCreateWindow
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "tb_top.prog" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcSetScope "tb_top.prog" -delim "." -win $_nTrace1
srcHBSelect "tb_top.prog" -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
srcSetScope "tb_top.prog.apb_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if.dut_if" -win $_nTrace1
srcSetScope "tb_top.prog.apb_if.dut_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if.dut_if" -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if.tb_if" -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
srcSetScope "tb_top.prog.apb_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
srcHBSelect "tb_top.prog" -win $_nTrace1
srcHBSelect "tb_top.apb_if" -win $_nTrace1
srcSetScope "tb_top.apb_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.apb_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
debExit
