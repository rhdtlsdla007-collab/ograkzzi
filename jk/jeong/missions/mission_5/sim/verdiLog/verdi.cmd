verdiSetActWin -dock widgetDock_<Message>
simSetSimulator "-vcssv" -exec "simv" -args "+num=20"
debImport "-dbdir" "simv.daidir"
debLoadSimResult /DATA/home/edu031/UVM/UVM_TB/missions/mission_5/sim/sv_sim.fsdb
wvCreateWindow
verdiWindowResize -win $_Verdi_1 "266" "115" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcSignalView -on
verdiSetActWin -dock widgetDock_<Signal_List>
srcSignalViewSelect "tb_top.clk_period"
srcSignalViewSelect "tb_top.clk_period" "tb_top.pclk"
srcSignalViewSelect "tb_top.clk_period" "tb_top.pclk" "tb_top.presetn"
srcSignalViewSelect "tb_top.clk_period" "tb_top.pclk" "tb_top.presetn" \
           "tb_top.pre_reset"
srcSignalViewAddSelectedToWave -clipboard
wvDrop -win $_nWave2
srcHBSelect "tb_top" -win $_nTrace1
srcSetScope "tb_top" -delim "." -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_top" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Signal_List>
srcSignalViewSelect "tb_top.clk_period"
srcSignalViewSelect "tb_top.pclk"
srcSignalViewSelect "tb_top.presetn"
srcSignalViewSelect "tb_top.pre_reset"
srcSignalViewSelect "tb_top.pre_reset" "tb_top.clk_period"
srcSignalViewSelect "tb_top.pre_reset" "tb_top.clk_period" "tb_top.pclk"
srcSignalViewSelect "tb_top.pre_reset" "tb_top.clk_period" "tb_top.pclk" \
           "tb_top.presetn"
srcSignalViewAddSelectedToWave -clipboard
wvDrop -win $_nWave2
wvSelectSignal -win $_nWave2 {( "G1" 1 )} 
verdiSetActWin -win $_nWave2
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSelectSignal -win $_nWave2 {( "G1" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSelectSignal -win $_nWave2 {( "G1" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 1)}
wvSelectSignal -win $_nWave2 {( "G1" 1 )} 
wvCut -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G1" 0)}
srcHBSelect "tb_top.u0" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_top.u0.unnamed\$\$_0" -win $_nTrace1
srcHBSelect "tb_top.u0.unnamed\$\$_0" -win $_nTrace1
srcSetScope "tb_top.u0.unnamed\$\$_0" -delim "." -win $_nTrace1
srcHBSelect "tb_top.u0.unnamed\$\$_0" -win $_nTrace1
srcHBSelect "tb_top.apb_if.dut_if" -win $_nTrace1
srcSetScope "tb_top.apb_if.dut_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.apb_if.dut_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Signal_List>
srcHBSelect "tb_top.apb_if.tb_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_top.apb_if.tb_if" -win $_nTrace1
srcSetScope "tb_top.apb_if.tb_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.apb_if.tb_if" -win $_nTrace1
srcHBSelect "tb_top.apb_if.cb" -win $_nTrace1
srcSetScope "tb_top.apb_if.cb" -delim "." -win $_nTrace1
srcHBSelect "tb_top.apb_if.cb" -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
srcSetScope "tb_top.prog.apb_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Signal_List>
srcHBSelect "tb_top" -win $_nTrace1
srcHBSelect "tb_top" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcSetScope "tb_top" -delim "." -win $_nTrace1
srcHBSelect "tb_top" -win $_nTrace1
srcSignalViewSelect "tb_top.clk_period"
verdiSetActWin -dock widgetDock_<Signal_List>
srcSignalViewSelect "tb_top.presetn"
srcSignalViewSelect "tb_top.presetn"
srcSignalViewSelect "tb_top.pclk"
srcSignalViewSelect "tb_top.clk_period"
srcSignalViewSelect "tb_top.clk_period"
srcSignalViewSelect "tb_top.pre_reset"
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -signal "apb_if.paddr" -line 9 -pos 1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -signal "apb_if.paddr" -line 9 -pos 1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -signal "apb_if.paddr" -line 9 -pos 1
srcAction -pos 8 4 5 -win $_nTrace1 -name "apb_if.paddr" -ctrlKey off
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -range {30 40 1 1 1 1}
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_<Signal_List>
srcHBSelect "tb_top" -win $_nTrace1
srcSetScope "tb_top" -delim "." -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_top" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -signal "apb_if.paddr" -line 9 -pos 1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcAction -pos 18 1 11 -win $_nTrace1 -name "apb_interface" -ctrlKey off
srcDeselectAll -win $_nTrace1
srcAction -pos 18 1 8 -win $_nTrace1 -name "apb_interface" -ctrlKey off
srcDeselectAll -win $_nTrace1
srcSelect -signal "presetn" -line 21 -pos 1 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -word -line 18 -pos 3 -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -win $_nTrace1 -signal "apb_if.paddr" -line 9 -pos 1
srcAction -pos 8 4 7 -win $_nTrace1 -name "apb_if.paddr" -ctrlKey off
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
srcSetScope "tb_top.prog.apb_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Signal_List>
srcSignalViewSelect "tb_top.prog.apb_if.pclk"
srcSignalViewSelect "tb_top.prog.apb_if.pclk" "tb_top.prog.apb_if.presetn"
srcSignalViewSelect "tb_top.prog.apb_if.pclk" "tb_top.prog.apb_if.presetn" \
           "tb_top.prog.apb_if.paddr\[7:0\]"
srcSignalViewSelect "tb_top.prog.apb_if.pclk" "tb_top.prog.apb_if.presetn" \
           "tb_top.prog.apb_if.paddr\[7:0\]" "tb_top.prog.apb_if.pselx"
srcSignalViewSelect "tb_top.prog.apb_if.pclk" "tb_top.prog.apb_if.presetn" \
           "tb_top.prog.apb_if.paddr\[7:0\]" "tb_top.prog.apb_if.pselx" \
           "tb_top.prog.apb_if.penable"
srcSignalViewSelect "tb_top.prog.apb_if.pclk" "tb_top.prog.apb_if.presetn" \
           "tb_top.prog.apb_if.paddr\[7:0\]" "tb_top.prog.apb_if.pselx" \
           "tb_top.prog.apb_if.penable" "tb_top.prog.apb_if.pwrite"
srcSignalViewSelect "tb_top.prog.apb_if.pclk" "tb_top.prog.apb_if.presetn" \
           "tb_top.prog.apb_if.paddr\[7:0\]" "tb_top.prog.apb_if.pselx" \
           "tb_top.prog.apb_if.penable" "tb_top.prog.apb_if.pwrite" \
           "tb_top.prog.apb_if.pwdata\[31:0\]"
srcSignalViewSelect "tb_top.prog.apb_if.pclk" "tb_top.prog.apb_if.presetn" \
           "tb_top.prog.apb_if.paddr\[7:0\]" "tb_top.prog.apb_if.pselx" \
           "tb_top.prog.apb_if.penable" "tb_top.prog.apb_if.pwrite" \
           "tb_top.prog.apb_if.pwdata\[31:0\]" \
           "tb_top.prog.apb_if.prdata\[31:0\]"
srcSignalViewSelect "tb_top.prog.apb_if.pclk" "tb_top.prog.apb_if.presetn" \
           "tb_top.prog.apb_if.paddr\[7:0\]" "tb_top.prog.apb_if.pselx" \
           "tb_top.prog.apb_if.penable" "tb_top.prog.apb_if.pwrite" \
           "tb_top.prog.apb_if.pwdata\[31:0\]" \
           "tb_top.prog.apb_if.prdata\[31:0\]" "tb_top.prog.apb_if.pready"
srcSignalViewSelect "tb_top.prog.apb_if.pclk" "tb_top.prog.apb_if.presetn" \
           "tb_top.prog.apb_if.paddr\[7:0\]" "tb_top.prog.apb_if.pselx" \
           "tb_top.prog.apb_if.penable" "tb_top.prog.apb_if.pwrite" \
           "tb_top.prog.apb_if.pwdata\[31:0\]" \
           "tb_top.prog.apb_if.prdata\[31:0\]" "tb_top.prog.apb_if.pready" \
           "tb_top.prog.apb_if.pslverr"
srcSignalViewAddSelectedToWave -clipboard
wvDrop -win $_nWave2
verdiWindowResize -win $_Verdi_1 "0" "23" "1440" "829"
verdiSetActWin -win $_nWave2
wvScrollUp -win $_nWave2 2
wvSetCursor -win $_nWave2 33230.889142 -snap {("G2" 0)}
srcHBSelect "tb_top" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_top" -win $_nTrace1
srcSetScope "tb_top" -delim "." -win $_nTrace1
srcHBSelect "tb_top" -win $_nTrace1
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcDeselectAll -win $_nTrace1
wvSetCursor -win $_nWave2 29387.861146
verdiSetActWin -win $_nWave2
wvSetCursor -win $_nWave2 29839.982086
wvZoom -win $_nWave2 29839.982086 49507.243007
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvScrollDown -win $_nWave2 0
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 24752.770230 -snap {("G1" 1)}
wvSetCursor -win $_nWave2 49768.867802 -snap {("G1" 1)}
srcDeselectAll -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if.dut_if" -win $_nTrace1
srcSetScope "tb_top.prog.apb_if.dut_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if.dut_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Signal_List>
srcHBSelect "tb_top.prog.apb_if.tb_if" -win $_nTrace1
srcSetScope "tb_top.prog.apb_if.tb_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if.tb_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
verdiSetActWin -dock widgetDock_<Signal_List>
srcHBSelect "tb_top.prog.apb_if.cb" -win $_nTrace1
srcSetScope "tb_top.prog.apb_if.cb" -delim "." -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_top.prog.apb_if.cb" -win $_nTrace1
srcHBSelect "_vcs_unit__674512512" -win $_nTrace1
srcSetScope "_vcs_unit__674512512" -delim "." -win $_nTrace1
srcHBSelect "_vcs_unit__674512512" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Signal_List>
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "tb_top.apb_if.dut_if" -win $_nTrace1
srcHBSelect "tb_top.apb_if" -win $_nTrace1
srcSetScope "tb_top.apb_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.apb_if" -win $_nTrace1
srcHBSelect "tb_top.apb_if.dut_if" -win $_nTrace1
srcSetScope "tb_top.apb_if.dut_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.apb_if.dut_if" -win $_nTrace1
srcHBSelect "tb_top.apb_if.tb_if" -win $_nTrace1
srcSetScope "tb_top.apb_if.tb_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.apb_if.tb_if" -win $_nTrace1
srcHBSelect "tb_top.prog" -win $_nTrace1
srcSetScope "tb_top.prog" -delim "." -win $_nTrace1
srcHBSelect "tb_top.prog" -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
srcSetScope "tb_top.prog.apb_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if" -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if.dut_if" -win $_nTrace1
srcSetScope "tb_top.prog.apb_if.dut_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if.dut_if" -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if.tb_if" -win $_nTrace1
srcSetScope "tb_top.prog.apb_if.tb_if" -delim "." -win $_nTrace1
srcHBSelect "tb_top.prog.apb_if.tb_if" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Signal_List>
debExit
