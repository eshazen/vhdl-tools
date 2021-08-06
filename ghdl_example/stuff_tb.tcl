#
# default top-level display for tdc_chan_tb
#
gtkwave::addSignalsFromList [list {top.stuff_tb.clk}]
gtkwave::addSignalsFromList [list {top.stuff_tb.rst}]
gtkwave::addSignalsFromList [list {top.stuff_tb.q}]

gtkwave::/Time/Zoom/Zoom_Full

