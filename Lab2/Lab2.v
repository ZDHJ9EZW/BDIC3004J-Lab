module Lab2 (
	output [4:0] ALU_out,
	output Led_idle, Led_wait, Led_rdy,
	input [3:0] Data,
	input [2:0] Opcode,
	input Go,
	input clk,reset
);
	wire [3:0] Reg_out;
	
	ALU				M1 (ALU_out, Data, Reg_out, Opcode);
	Register			M2 (Reg_out, Data, Load, clk, reset);
	Toggle_Button	M3 (Load, Led_idle, Led_wait, Led_rdy, Go, clk, reset);
	
endmodule
