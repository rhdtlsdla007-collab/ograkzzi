verdiSetActWin -dock widgetDock_<Message>
simSetSimulator "-vcssv" -exec \
           "/DATA/home/edu031/UVM/hub_test/ograkzzi/jk/JK_vip/sim/simv" -args \
           "+ntb_random_seed=1 +UVM_TESTNAME=jk_ubus_virtual_sequence_test +UVM_VERBOSITY=UVM_HIGH +UVM_COMPONENT_TRACE + + +UVM_TR_RECORD +UVM_LOG_RECORD"
debImport "-dbdir" \
          "/DATA/home/edu031/UVM/hub_test/ograkzzi/jk/JK_vip/sim/simv.daidir"
debLoadSimResult /DATA/home/edu031/UVM/hub_test/ograkzzi/jk/JK_vip/sim/test.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "985" "266" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiWindowResize -win $_Verdi_1 "0" "23" "1440" "829"
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "jk_ubus_tb_top.master_if" -win $_nTrace1
srcHBSelect "jk_ubus_tb_top.master_if" -win $_nTrace1
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBSelect "jk_ubus_tb_top.slave_if" -win $_nTrace1
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
verdiDockWidgetMaximize -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
debExit
