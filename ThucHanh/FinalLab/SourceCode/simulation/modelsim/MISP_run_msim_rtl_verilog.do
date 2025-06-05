transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/alu32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/flopr_param.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/sl2.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/Controlunit.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/registerfile32.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/ram.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/signext.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/MISP.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/IF_ID_Register.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/ID_EX_Register.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/EX_MEM_Register.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/MEM_WB_Register.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/ForwardingUnit.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/Datapath_Pipeline.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/HazardUnit.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/bus.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/gpio.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/pwm.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/Top.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/rom.v}

vlog -vlog01compat -work work +incdir+C:/altera/13.0sp1/Verilog/FinalLab {C:/altera/13.0sp1/Verilog/FinalLab/Top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  Top_tb

add wave *
view structure
view signals
run -all
