transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/lance/Desktop/wsp\ (1)/lab2 {C:/Users/lance/Desktop/wsp (1)/lab2/lab2.v}

vlog -vlog01compat -work work +incdir+C:/Users/lance/Desktop/wsp\ (1)/lab2/simulation/modelsim {C:/Users/lance/Desktop/wsp (1)/lab2/simulation/modelsim/lab2.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  lab2_vlg_tst

add wave *
view structure
view signals
run -all
