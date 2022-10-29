###############################################################################
## Simulator Makefile
###############################################################################
VERILATOR_SRC ?= /usr/share/verilator/include

# Target
TARGET	   ?= riscv-sim
TARGET_ISA_LIB ?= libisa_sim.a
TARGET_VARILATED_LIB ?= verilated
TARGET_VARILATED_TOP ?= Vriscv_tcm_top
TARGET_INI ?= modelsim.ini

# Source Files
SRC_DIR = ./top_tcm_axi/tb
ISA_SRC_DIR = ./isa_sim
VSRC_DIR    = ./core/riscv
TCM_SRC_DIR = ./top_tcm_axi/src_v

# Additional include directories
INCLUDE_PATH ?=
INCLUDE_PATH += ./
INCLUDE_PATH += $(SRC_DIR)
INCLUDE_PATH += $(ISA_SRC_DIR)
INCLUDE_PATH += ./verilated
INCLUDE_PATH += ./isa_sim
INCLUDE_PATH += $(VERILATOR_SRC)
INCLUDE_PATH += $(VERILATOR_SRC)/vltstd

VSRC_TOP    = $(TARGET_VARILATED_TOP).h

LDFLAGS     = 
LIBS        = -lelf -lbfd
# Flags
CFLAGS       ?= -fpic -O2
CFLAGS       += $(patsubst %,-I%,$(INCLUDE_PATH))
CFLAGS       += -DVM_TRACE=0
LDFLAGS      ?= -O2
LDFLAGS      += -L$(SYSTEMC_HOME)/lib-linux64 
LDFLAGS      += $(patsubst %,-L%,$(LIB_PATH))

#########################################Y######################################
# Variables
###############################################################################
LIB_DIR    ?= lib
OBJ_DIR    ?= obj

###############################################################################
# Variables: Lists of objects, source and deps
###############################################################################
# SRC / Object list
src2obj       = $(OBJ_DIR)$(patsubst %$(suffix $(1)),%.o,$(notdir $(1)))

VERILOG_SRC  ?= $(foreach src,$(VSRC_DIR),$(wildcard $(src)/*.v))
VERILOG_TCM_SRC  ?= $(foreach src,$(TCM_SRC_DIR),$(wildcard $(src)/*.v))
SRC          ?= $(foreach src,$(SRC_DIR),$(wildcard $(src)/*.cpp))
ISA_SRC      ?= $(foreach src,$(ISA_SRC_DIR),$(wildcard $(src)/*.cpp))
OBJ          ?= $(foreach src,$(SRC),$(call src2obj,$(src)))
LIB_OBJ      ?= $(foreach src,$(filter-out main.cpp,$(SRC)),$(call src2obj,$(src)))

###############################################################################
# Rules: Compilation macro
###############################################################################
define template_cpp
$(call src2obj,$(1)): $(1) | $(OBJ_DIR)
	@echo "# Compiling $(notdir $(1))"
	@sccom $(CFLAGS) -c $$< -work $$@
endef

###############################################################################
# Rules
###############################################################################
$(foreach src,$(SRC),$(eval $(call template_cpp,$(src))))

lib:
#	mkdir -p $(LIB_DIR)
#	vlib $(LIB_DIR)/$(TARGET_ISA_LIB)
#	vmap $(TARGET_ISA_LIB) $(LIB_DIR)/$(TARGET_ISA_LIB)
	sccom $(ISA_SRC) $(LDFLAGS) $(LIBS) -work $(TARGET_ISA_LIB)

verilated:
	vlog $(VERILOG_SRC) -l vlog_riscv.log -work $(TARGET_VARILATED_LIB)
	vlog $(VERILOG_TCM_SRC) -l vlog_top_tcm_axi.log -work $(TARGET_VARILATED_LIB)
	scgenmod -bool -sc_uint -lib $(TARGET_VARILATED_LIB) -o $(VSRC_TOP) $(TARGET_VARILATED_TOP)

build:
	sccom $(SRC) $(CFLAGS) $(LDFLAGS) $(LIBS) -work work
	sccom -link -lib libisa_sim.a -lib verilated

run:
	vsim -c testbench -wlf vsim.wlf -l vsim.log -do "add wave -r /*; run -all; quit"

clean:
	rm -rf $(TARGET_ISA_LIB) vlog_riscv.log vlog_top_tcm_axi.log $(TARGET_VARILATED_LIB) $(VSRC_TOP) work