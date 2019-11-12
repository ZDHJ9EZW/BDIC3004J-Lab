module Lab3(money,distance,scan,seg7,dp,clk20mhz,clk,start,stop,pause,gears);
	output [7:0] scan;
	output [6:0] seg7;
	output dp;
	input clk20mhz,clk;
	input start,stop,pause;
	input [1:0] gears;
	
	output [12:0] money,distance;
	taxi T(money,distance,clk,start,stop,pause,gears);
	//decoder D(scan,seg7,dp,clk20mhz,money,distance);
	decoder D(scan,seg7,dp,clk20mhz,money,distance,stop);
endmodule