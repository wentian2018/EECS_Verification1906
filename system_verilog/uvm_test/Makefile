
RTL_PATH = ./rtl
UVM_HOME = ./uvm-1.2
TB_TOP = ./test.sv

TEST = test_base

VERBOSITY = UVM_MEDIUM

SEED = $(shell data +%s)
UVM_VER = uvm-1.2

defines = UVM_NO_DEPRECATED+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR

plus = 

#OPTION = UVM_OBJECTION_TRACE

SOLVER = 2

all: compile simulate 

create_lib:
	if [ -d work ]; then rm -rf work; fi
	vlib work

compile:
	vlog -sv test.sv top.sv -l sim.log


simulate:
	vsim   -t 1ns/1ns work.top  +UVM_TESTNAME=hello

clean:
	@rm -rf work *.log 
