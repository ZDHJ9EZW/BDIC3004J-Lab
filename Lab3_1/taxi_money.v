module taxi_money(distance, low_time, clk, stop_state, distance_out, money);
	input [16:0] distance, low_time;
	input clk, stop_state;
	output reg [16:0] distance_out, money;
	reg [16:0] money_low, distance_50, money_50;
	
	initial begin
		distance_out = 0;
		money = 0;
		money_low = 0;
	end
	
	always@(posedge clk or posedge stop_state)begin
		if(stop_state)begin
			distance_out = 0;
			money = 0;
			money_low = 0;
		end
		else begin
			money_low = low_time*23;
			distance_out = distance;
			if(distance <= 3000)begin
				money = 130 + money_low;
			end
			else begin
				if(money < 500)begin
					money = (23*((distance-3000)/1000)) + 130 + money_low;
					distance_50 = distance;
					money_50 = (23*((distance-3000)/1000)) + 130;
				end
				else begin
					money = money_50 + (33*((distance-distance_50)/1000))+ money_low; 
				end
			end
		end
	end
endmodule
