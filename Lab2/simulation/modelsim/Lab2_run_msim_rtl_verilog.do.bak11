transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ziyang/Documents/Stage3_Semester1/BDIC3004J\ Digital\ System\ Design/Lab2 {C:/Users/ziyang/Documents/Stage3_Semester1/BDIC3004J Digital System Design/Lab2/Lab2.v}
vlog -vlog01compat -work work +incdir+C:/Users/ziyang/Documents/Stage3_Semester1/BDIC3004J\ Digital\ System\ Design/Lab2 {C:/Users/ziyang/Documents/Stage3_Semester1/BDIC3004J Digital System Design/Lab2/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/ziyang/Documents/Stage3_Semester1/BDIC3004J\ Digital\ System\ Design/Lab2 {C:/Users/ziyang/Documents/Stage3_Semester1/BDIC3004J Digital System Design/Lab2/Register.v}
vlog -vlog01compat -work work +incdir+C:/Users/ziyang/Documents/Stage3_Semester1/BDIC3004J\ Digital\ System\ Design/Lab2 {C:/Users/ziyang/Documents/Stage3_Semester1/BDIC3004J Digital System Design/Lab2/Toggle_Button.v}

vlog -vlog01compat -work work +incdir+C:/Users/ziyang/Documents/Stage3_Semester1/BDIC3004J\ Digital\ System\ Design/Lab2/simulation/modelsim {C:/Users/ziyang/Documents/Stage3_Semester1/BDIC3004J Digital System Design/Lab2/simulation/modelsim/Lab2.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  Lab2_vlg_tst

add wave *
view structure
view signals
run 20 sec
