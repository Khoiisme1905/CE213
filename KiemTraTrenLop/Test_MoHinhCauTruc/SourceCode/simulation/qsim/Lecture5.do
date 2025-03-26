onerror {quit -f}
vlib work
vlog -work work Lecture5.vo
vlog -work work Lecture5.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Lecture5_vlg_vec_tst
vcd file -direction Lecture5.msim.vcd
vcd add -internal Lecture5_vlg_vec_tst/*
vcd add -internal Lecture5_vlg_vec_tst/i1/*
add wave /*
run -all
