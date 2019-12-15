module Lab3(pause, start, stop, clk, wheel_clk, clk2, display, scan, dp);
	input pause, start, stop, clk, wheel_clk, clk2;
	output [6:0] display;
	output [8:0] scan;
	output dp;
	wire low_speed, high_speed, pause_state, stop_state;
	wire [16:0] low_time, distance, distance_out, money;
	
	taxi_control T1 (.pause(pause), .start(start), .stop(stop), .clk(clk), .wheel_clk(wheel_clk), 
	.low_speed(low_speed), .high_speed(high_speed), .pause_state(pause_state), .stop_state(stop_state));
	
	taxi_distance_ptime T2 (.low_speed(low_speed), .high_speed(high_speed), .pause_state(pause_state), .stop_state(stop_state),
	.clk(clk), .wheel_clk(wheel_clk), .low_time(low_time), .distance(distance));
	
	taxi_money T3 (.stop_state(stop_state), .distance(distance), .low_time(low_time), .clk(clk),
	.distance_out(distance_out), .money(money));
	
	LED2s L1 (.distance_out(distance_out), .money(money), .display(display), .scan(scan), .dp(dp), .clk(clk), .clk2(clk2));

endmodule
