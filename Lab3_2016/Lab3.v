module Lab3 (
	output [7:0] scan,
	output [6:0] seg7,
	output dp,
	output [12:0] money, distance，
	input clk20mhz, clk,
	input start, stop, pause,
	input [1:0] gears
);
	
	taxi 		T(money, distance, clk, start, stop, pause, gears);
	decoder  D(scan, seg7, dp, clk20mhz, money, distance, stop);

endmodule
