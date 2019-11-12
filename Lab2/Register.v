module Register (output reg [3:0] Reg_out, input [3:0] Data, input Load, clk, reset);
	always @(posedge clk)
	begin
		if(reset) Reg_out = 4'b0;
		else begin
			if(Load) Reg_out <= Data ;
			end
	end
endmodule
