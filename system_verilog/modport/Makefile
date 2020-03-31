
all:create_lib compile simulate

create_lib:
	vlib work

compile:
	vlog -sv +define+ASSERT modport.sv -l sim.log

simulate:
	vsim -novopt -c -l sim.log interface modports -do "log -r * ; run -all; quit -f"

clean:
	rm -rf work mti_lib transcript modelsim.ini *.log vsim.wlf 
