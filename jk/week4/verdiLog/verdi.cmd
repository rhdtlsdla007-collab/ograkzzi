verdiSetActWin -dock widgetDock_<Watch>
simSetSimulator "-vcssv" -exec "/DATA/home/edu002/0_work/uvm/JK/week5/simv" -args \
           "+UVM_TESTNAME=jk_ubus_write_test +UVM_VERBOSITY=UVM_MEDIUM"
debImport "-dbdir" "/DATA/home/edu002/0_work/uvm/JK/week5/simv.daidir"
debLoadSimResult /DATA/home/edu002/0_work/uvm/JK/week5/test.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "510" "190" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBSelect "jk_ubus_tb_top" -win $_nTrace1
srcHBSelect "jk_ubus_tb_top.master_vif" -win $_nTrace1 -add
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBSelect "jk_ubus_tb_top" -win $_nTrace1
srcHBSelect "jk_ubus_tb_top.master_vif" -win $_nTrace1 -add
srcHBSelect "jk_ubus_tb_top.slave_vif" -win $_nTrace1 -add
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
srcHBAddObjectToWave -clipboard
wvDrop -win $_nWave2
wvScrollDown -win $_nWave2 1
verdiSetActWin -win $_nWave2
wvScrollDown -win $_nWave2 1
wvScrollDown -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvResizeWindow -win $_nWave2 0 25 1272 398
wvResizeWindow -win $_nWave2 0 25 1272 398
verdiWindowBeWindow -win $_nWave2
wvResizeWindow -win $_nWave2 0 31 1663 937
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvScrollUp -win $_nWave2 1
wvSetCursor -win $_nWave2 1332.876154 -snap \
           {("slave_vif(jk_ubus_slave_if)#43" 6)}
