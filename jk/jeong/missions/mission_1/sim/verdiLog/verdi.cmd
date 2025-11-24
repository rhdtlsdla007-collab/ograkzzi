verdiSetActWin -dock widgetDock_<Message>
simSetSimulator "-vcssv" -exec \
           "/DATA/home/edu031/UVM/UVM_TB/missions/mission_1/sim/simv" -args
debImport "-dbdir" \
          "/DATA/home/edu031/UVM/UVM_TB/missions/mission_1/sim/simv.daidir"
debLoadSimResult \
           /DATA/home/edu031/UVM/UVM_TB/missions/mission_1/sim/verilog_sim.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "180" "47" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 46652.780083
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_verilog"
wvGetSignalSetScope -win $_nWave2 "/tb_verilog/u0"
wvGetSignalSetScope -win $_nWave2 "/tb_verilog/u0/unnamed\$\$_0"
wvGetSignalSetScope -win $_nWave2 "/tb_verilog/u0"
wvGetSignalSetScope -win $_nWave2 "/tb_verilog/unnamed\$\$_0"
wvGetSignalSetScope -win $_nWave2 "/tb_verilog/u0"
wvGetSignalSetScope -win $_nWave2 "/tb_verilog"
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb_verilog/paddr\[7:0\]} \
{/tb_verilog/pclk} \
{/tb_verilog/penable} \
{/tb_verilog/pready} \
{/tb_verilog/pselx} \
{/tb_verilog/pwdata\[31:0\]} \
{/tb_verilog/pwrite} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 3 4 5 6 7 )} 
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb_verilog/paddr\[7:0\]} \
{/tb_verilog/pclk} \
{/tb_verilog/penable} \
{/tb_verilog/pready} \
{/tb_verilog/pselx} \
{/tb_verilog/pwdata\[31:0\]} \
{/tb_verilog/pwrite} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 3 4 5 6 7 )} 
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/tb_verilog/paddr\[7:0\]} \
{/tb_verilog/pclk} \
{/tb_verilog/penable} \
{/tb_verilog/pready} \
{/tb_verilog/pselx} \
{/tb_verilog/pwdata\[31:0\]} \
{/tb_verilog/pwrite} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 3 4 5 6 7 )} 
wvSetPosition -win $_nWave2 {("G1" 7)}
wvGetSignalClose -win $_nWave2
verdiDockWidgetMaximize -dock windowDock_nWave_2
schCreateWindow -delim "." -win $_nSchema1 -scope "tb_verilog"
verdiWindowResize -win $_Verdi_1 "626" "104" "945" "700"
schCreateWindow -delim "." -win $_nSchema1 -scope "tb_verilog"
verdiDockWidgetSetCurTab -dock windowDock_nSchema_3
verdiSetActWin -win $_nSchema_3
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
verdiDockWidgetSetCurTab -dock windowDock_nSchema_3
verdiSetActWin -win $_nSchema_3
schSelect -win $_nSchema3 -inst "tb_verilog\(@1\):Init1:131:136:Init"
schPushViewIn -win $_nSchema3
srcSelect -win $_nTrace1 -range {131 136 1 2 1 1}
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {132 136 1 2 1 1} -backward
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
verdiDockWidgetSetCurTab -dock windowDock_nSchema_4
verdiSetActWin -win $_nSchema_4
schCloseWindow -win $_nSchema4
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiDockWidgetSetCurTab -dock windowDock_nSchema_3
verdiSetActWin -win $_nSchema_3
schSelect -win $_nSchema3 -inst "tb_verilog\(@1\):Always0:43:43:Combo"
schPushViewIn -win $_nSchema3
srcSelect -win $_nTrace1 -range {43 43 1 17 1 1}
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiDockWidgetSetCurTab -dock windowDock_nSchema_3
verdiSetActWin -win $_nSchema_3
schSelect -win $_nSchema3 -inst "u0"
schSelect -win $_nSchema3 -instport "u0" "pclk"
schSelect -win $_nSchema3 -instport "u0" "pclk"
schPushViewIn -win $_nSchema3
schSelect -win $_nSchema3 -inst "apb_completer\(@1\):FSM0:48:89:FSM"
schPushViewIn -win $_nSchema3
fsmSetCurrentWindow -win $_nState5
fsmResizeWindow 0 25 945 574 -win $_nState5
fsmResizeWindow 0 25 945 574 -win $_nState5
verdiSetActWin -win $_nState_5
verdiDockWidgetSetCurTab -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiDockWidgetSetCurTab -dock windowDock_nSchema_3
verdiSetActWin -win $_nSchema_3
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
verdiDockWidgetSetCurTab -dock windowDock_nSchema_3
verdiSetActWin -win $_nSchema_3
verdiDockWidgetSetCurTab -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiDockWidgetSetCurTab -dock windowDock_nSchema_3
verdiSetActWin -win $_nSchema_3
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
verdiDockWidgetSetCurTab -dock windowDock_nSchema_3
verdiSetActWin -win $_nSchema_3
schCloseWindow -win $_nSchema3
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiDockWidgetSetCurTab -dock windowDock_nWave_2
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 41913.113506 -snap {("G2" 0)}
wvSetCursor -win $_nWave2 71319.894756 -snap {("G2" 0)}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 3 4 5 6 7 )} 
wvSetRadix -win $_nWave2 -format Bin
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/tb_verilog"
wvGetSignalSetScope -win $_nWave2 "/tb_verilog/u0"
wvGetSignalSetScope -win $_nWave2 "/tb_verilog"
wvGetSignalClose -win $_nWave2
wvDisplayGridCount -win $_nWave2 -off
wvCloseGetStreamsDialog -win $_nWave2
wvAttrOrderConfigDlg -win $_nWave2 -close
wvCloseDetailsViewDlg -win $_nWave2
wvCloseDetailsViewDlg -win $_nWave2 -streamLevel
wvCloseFilterColorizeDlg -win $_nWave2
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvSetCursor -win $_nWave2 79770.119253 -snap {("G2" 0)}
wvSelectGroup -win $_nWave2 {G2}
wvSetCursor -win $_nWave2 76728.038434 -snap {("G2" 0)}
wvDisplayGridCount -win $_nWave2 -off
wvCloseGetStreamsDialog -win $_nWave2
wvAttrOrderConfigDlg -win $_nWave2 -close
wvCloseDetailsViewDlg -win $_nWave2
wvCloseDetailsViewDlg -win $_nWave2 -streamLevel
wvCloseFilterColorizeDlg -win $_nWave2
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
wvSetCursor -win $_nWave2 65235.733118 -snap {("G2" 0)}
wvSetCursor -win $_nWave2 55940.486171 -snap {("G2" 0)}
wvDisplayGridCount -win $_nWave2 -off
wvCloseGetStreamsDialog -win $_nWave2
wvAttrOrderConfigDlg -win $_nWave2 -close
wvCloseDetailsViewDlg -win $_nWave2
wvCloseDetailsViewDlg -win $_nWave2 -streamLevel
wvCloseFilterColorizeDlg -win $_nWave2
wvGetSignalClose -win $_nWave2
wvReloadFile -win $_nWave2
debExit
