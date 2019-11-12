module taxi(money,distance,clk,start,stop,pause,gears);
	output reg [12:0] money;
	output reg [12:0] distance;
	input clk,start,stop,pause;
	input [1:0] gears;
	
	reg [12:0] money_register;
	reg [12:0] distance_register;
	reg [3:0] num;
	reg [12:0] dis;
	reg d;
	
	always @(posedge clk)
		begin
		if(stop)
			begin
			money_register <= 600;
			distance_register <= 0;
			num <= 1;
			dis <= 0;
			end
		else if(start)
			begin
			money_register <= 600;
			distance_register <= 0;
			num <= 1;
			dis <= 0;
			end
		else
			begin
			if(!start && !gears && !pause && !stop)
				begin
				if(num == 9)
					begin
					num <= 0;
					distance_register <= distance_register+1;
					dis <= dis+1;
					end
				else
					begin
					num <= num+1;
					end
				end
			else if(!start && gears==2'b01 && !pause && !stop)
				begin
				if(num == 9)
					begin
					num <= 0;
					distance_register <= distance_register+2;
					dis <= dis+2;
					end
				else
					begin
					num <= num+1;
					end
				end
			else if(!start && gears==2'b10 && !pause && !stop)
				begin
				if(num == 9)
					begin
					num <= 0;
					distance_register <= distance_register+3;
					dis <= dis+3;
					end
				else
					begin
					num <= num+1;
					end
				end
			else if(!start && gears==2'b11 && !pause && !stop)
				begin
				if(num == 9)
					begin
					num <= 0;
					distance_register <= distance_register+4;
					dis <= dis+4;
					end
				else
					begin
					num <= num+1;
					end
				end
			end
		if(dis >= 100)
			begin
			d <= 1;
			dis <= 0;
			end
		else
			begin
			d <= 0;
			end
		if(distance_register >= 300)
			begin
			if(money_register < 2000 && d==1)
				begin
				money_register <= money_register+120;
				end
			else if(money_register >= 2000 && d==1)
				begin
				money_register <= money_register+180;
				end
			end
		money <= money_register;
		distance <= distance_register;
		end
endmodule