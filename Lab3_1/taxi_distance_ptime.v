module taxi_distance_ptime(high_speed, low_speed, pause_state, stop_state, wheel_clk, clk, distance, low_time);
	input high_speed, low_speed, pause_state, stop_state, wheel_clk, clk;
	output reg [31:0] low_time, distance;
	
	reg [4:0] wheel_counter2;
	reg [10:0] clk_counter2; //low speed time

	initial begin
		low_time = 0;
		distance = 0;
		wheel_counter2 = 0;
		clk_counter2 = 0;
	end
	
	//distance
	always@(posedge wheel_clk or posedge stop_state)begin
		if(stop_state) begin 
			distance = 0;
			wheel_counter2 = 0;
		end
		else begin
			if(!pause_state)begin
				wheel_counter2 = wheel_counter2 + 1;
				if(wheel_counter2 == 10)begin //10圈轮子7米
					distance = distance + 7;
					wheel_counter2 = 0;
				end
			end
		end
		
	end
	
	//low speed time
	always@(posedge clk or posedge stop_state)begin
		if(stop_state)begin
			low_time = 0;
			clk_counter2 = 0;
		end
		else begin
			if(low_speed) clk_counter2 = clk_counter2 + 1;
			low_time = clk_counter2/100; //100个cycle是1分钟
		end
	end
endmodule
