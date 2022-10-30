###############################################################################
# Variables: Program ELF
###############################################################################
ELF_FILE ?= basic.elf

OBJCOPY ?= riscv32-unknown-elf-objcopy
ifeq ($(shell which $(OBJCOPY)),)
  ${error $(OBJCOPY) missing from PATH}
endif
ifeq ($(shell which vsim),)
  ${error vsim missing from PATH - Questa required}
endif


###############################################################################
# Variables: Defaults
###############################################################################
TRACE          ?= 1

SRC_V_DIR      ?= ../../src/core .
SRC_DIR        ?= .

#EXE            ?= output.out
EXE            ?= work

###############################################################################
# Variables: Verilog
###############################################################################
SRC_V       ?= $(foreach src,$(SRC_V_DIR),$(wildcard $(src)/*.v))

VFLAGS      += $(patsubst %,+incdir+%,$(SRC_V_DIR))
#VFLAGS      += -DTRACE=$(TRACE)
#VFLAGS      += -Dverilog_sim

TOP_MODULE  = tb_top

###############################################################################
# Variables: Lists of objects, source and deps
###############################################################################
BUILD_DIR      ?= build

###############################################################################
# Rules
###############################################################################
all: run

$(BUILD_DIR):
	@mkdir -p $@
#	@vlib $@/$(EXE)
#	@vmap $(EXE) $@/$(EXE)

$(BUILD_DIR)/tcm.bin: $(ELF_FILE) | $(BUILD_DIR)
	$(OBJCOPY) $< -O binary $@

$(BUILD_DIR)/$(EXE): $(SRC_V) | $(BUILD_DIR)
	@echo "# Compiling verilog"
#	iverilog $(VFLAGS) -o $@ $(SRC_V)
	vlog $(VFLAGS) $(SRC_V)

run: $(BUILD_DIR)/$(EXE) $(BUILD_DIR)/tcm.bin
	vsim -c $(TOP_MODULE) -work $(EXE) -voptargs="+acc" -wlf vsim.wlf -do "add wave -r /*; run 1000200ns; quit" -l vsim.log
#	vopt $(TOP_MODULE) -access=r+/. -cellaccess=r+/. -o optver
#	vsim -c optver -qwavedb=+signal+memory+assertion+cell+class -do "run 1000200ns; quit" -l vsim.log

view:
	gtkwave waveform.vcd gtksettings.sav  

clean:
	rm -rf $(BUILD_DIR) $(EXE) *.wlf modelsim.ini vsim.log transcript

