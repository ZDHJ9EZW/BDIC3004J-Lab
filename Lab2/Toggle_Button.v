module Toggle_Button (output reg Load, Led_idle, Led_wait, Led_rdy, input Go, clk, reset);
	reg [1:0] state = 0;
	
	always @(posedge clk) begin
	
		if(reset) state = 0;
		else begin
			if(Go && state == 0) state = 2'b1;
			else if(state == 1) state = 2'b10;
			else if(!Go && state == 2'b10) state = 2'b11; 
			else if (Go && state == 2'b11) begin
				state = 2'b1;
				Led_rdy = 0;
			end
		end

		case(state)
			2'b0:				begin
									Led_idle = 1;
									Led_wait = 0;
									Led_rdy = 0;
									Load = 0;
								end

			2'b1: 			begin
									Led_idle = 0;
									Load = 1;
								end

			2'b10:			begin
									Load = 0;
									Led_wait = 1;
								end

			2'b11:			begin
									Led_wait = 0;
									Led_rdy = 1;
								end
		endcase
	end
endmodule
