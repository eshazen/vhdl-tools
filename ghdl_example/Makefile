#
# build and run a GHDL simulation
#

# run GHDL
GHDLRUN = /usr/bin/ghdl
GTKWAVE = /usr/bin/gtkwave

GHDLOPT = --ieee=synopsys
GHDLA = $(GHDLRUN) -a $(GHDLOPT)
GHDLE = $(GHDLRUN) -e $(GHDLOPT)
GHDLR = $(GHDLRUN) -r $(GHDLOPT)

# list all VHDL source files here
VHDL =	stuff.vhd stuff_tb.vhd

all: stuff_tb.ghw

view: stuff_tb_view

stuff_tb.ghw: analyze.ready
	$(GHDLE) stuff_tb
	$(GHDLR) stuff_tb --stop-time=1us --wave=stuff_tb.ghw

stuff_tb_view: stuff_tb.ghw stuff_tb.tcl
	$(GTKWAVE) stuff_tb.ghw -S stuff_tb.tcl

#---- don't touch ----
define analyze_VHDL
  $(GHDLA) $(1);
endef

analyze.ready: $(VHDL)
	rm -f work-obj93.cf
	$(foreach vf,$(VHDL), $(call analyze_VHDL, $(vf)))
	touch analyze.ready

clean:
	rm -f *~ *.cf *.vcd *.ghw *.db *.ready
