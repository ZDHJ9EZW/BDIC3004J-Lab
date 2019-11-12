`timescale 1ps/1ps
module t_lab2();
reg [3:0] Data;
reg [2:0] Opcode;
reg Go;
reg clk,reset;
wire Led_idle,Led_wait,Led_rdy;
wire [4:0] ALU_out;


reg [2:0] count;

Lab2 u1(ALU_out,Led_idle,Led_wait,Led_rdy,Data,Opcode,Go,clk,reset);

initial 
begin
	#5 clk = ~clk;
	Go = 0;
	reset =0;
	Data = 4'b0;
	Opcode = 3'b0;
end	

initial
begin
	for(count = 3'b0 ; count<= 3'b111 ;count = count+1)
	begin
		Data = 4'b0010;
		#5 Go = 1;
		#50 Go = 0;
		#10 Opcode= Opcode + count;
		end
end
