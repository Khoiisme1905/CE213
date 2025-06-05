onerror {quit -f}
vlib work
vlog -work work Lab2_22520696_DuongAnhKhoi.vo
vlog -work work Lab2_22520696_DuongAnhKhoi.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Lab2_22520696_DuongAnhKhoi_vlg_vec_tst
vcd file -direction Lab2_22520696_DuongAnhKhoi.msim.vcd
vcd add -internal Lab2_22520696_DuongAnhKhoi_vlg_vec_tst/*
vcd add -internal Lab2_22520696_DuongAnhKhoi_vlg_vec_tst/i1/*
add wave /*
run -all
