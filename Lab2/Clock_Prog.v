module Clock_Prog (output reg clock);
	parameter Latency = 100;
	parameter Offest = 75;
	parameter Pulse_Width = 25;
	
	initial begin
		#0 clock = 0;
		#Latency forever
			begin
				#Offest clock = ~clock;
				#Pulse_Width clock = ~clock;
			end
	end
endmodule

module t_Clock_Prog();
	wire clock;
	
	initial #100 $finish;
	Clock_Prog M1 (clk);
endmodule

module annotate_Clock_Prog();
	defparam t_Clock_Prog.M1.Latency = 10;
	defparam t_Clock_Prog.M1.Offest = 5;
	defparam t_Clock_Prog.M1.Pulse_Width = 5;
endmodule
