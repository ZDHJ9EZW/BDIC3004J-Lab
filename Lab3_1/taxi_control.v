module taxi_control(clk, wheel_clk, stop, start, pause, low_speed, high_speed, pause_state, stop_state);
	input clk, wheel_clk, stop, start, pause;
	output reg low_speed, high_speed, pause_state, stop_state;
	
	reg [4:0]clk_counter, wheel_counter;
	reg control;//判断是否经过固定时间
	reg [4:0]judge;

	initial begin
		clk_counter = 0;
		wheel_counter = 0;
		judge = 0;
		control = 0;
	end

	always@(posedge clk)begin
		if(control) control = 0;
		clk_counter = clk_counter + 1;
		if(clk_counter == 10)begin 
			control = 1;
			clk_counter = 0;
			judge = wheel_counter;
		end	
		
	end


	always@(posedge wheel_clk, posedge control)begin
		if(control) wheel_counter = 0;
		else wheel_counter = wheel_counter +1 ;
	end

	always@(posedge clk)begin
		if(stop)begin
			low_speed = 0;
			high_speed = 0;
			pause_state = 0;
			stop_state = 1;
		end
		else if(start)begin
			stop_state = 0;
			if(pause)begin
				high_speed = 0;
				low_speed = 0;
				pause_state = 1;
			end
			else begin
				pause_state = 0;
				if(judge >= 10)begin
					low_speed = 0;
					high_speed = 1;
				end
				else begin
					high_speed = 0;
					low_speed = 1;
				end
			end
		end
	end
endmodule
