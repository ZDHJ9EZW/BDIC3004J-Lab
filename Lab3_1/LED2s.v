module LED2s(distance_out, money, display, scan, clk2, clk, dp);
	input [16:0] distance_out, money;
	input clk2, clk;//clk2 用来扫描 clk2要远远快于clk
	output reg [6:0] display;
	output reg [8:0] scan;
	output reg dp;
	reg [10:0] X1_distance, X2_distance, G_distance, S_distance,B_distance;
	reg [10:0] X1_money, G_money, S_money, B_money;
	reg [3:0] chos, data;
	
	parameter BLANK = 7'b0000000;
	parameter ZERO  = 7'b1111110;    
	parameter ONE   = 7'b0110000;    
	parameter TWO   = 7'b1101101;    
	parameter THREE = 7'b1111001;    
	parameter FOUR  = 7'b0110011;    
	parameter FIVE  = 7'b1011011;    
	parameter SIX   = 7'b1011111;    
	parameter SEVEN = 7'b1110000;    
	parameter EIGHT = 7'b1111111;    
	parameter NINE  = 7'b1111011;

	initial begin
		chos = 10;
		scan = 'b000000000;
		display = BLANK;
	end
    
	always@(posedge clk)begin
		X2_distance = distance_out%100/10;
		X1_distance = distance_out%1000/100;
		G_distance =  distance_out%10000/1000; //distance 米，要变成千米
		S_distance =  distance_out%100000/10000;
		B_distance =  distance_out%1000000/100000;
		
		X1_money = money%10;
		G_money = money%100/10;
		S_money = money%1000/100;
		B_money = money%10000/1000;
	end
	
	always@(data)begin
		case(data)
			0:begin display = ZERO; end
			1:begin display = ONE;  end
			2:begin display = TWO;  end
			3:begin display = THREE; end
			4:begin display = FOUR; end
			5:begin display = FIVE; end
			6:begin display = SIX;  end
			7:begin display = SEVEN;end
			8:begin display = EIGHT;end
			9:begin display = NINE; end
			default:begin display = BLANK; end
		endcase	
	end
	
	
	
	always@(posedge clk2)begin
		if(chos < 8) chos = chos + 1;
		else chos = 0;
	end
	
	always@(chos)begin
		case(chos)
			0:begin data = X2_distance;dp = 0;scan = 'b000000001; end 
			1:begin data = X1_distance;dp = 0;scan = 'b000000010; end
			2:begin data = G_distance;dp = 1;scan = 'b000000100;  end
			3:begin data = S_distance;dp = 0;scan = 'b000001000;  end
			4:begin data = B_distance;dp = 0;scan = 'b000010000;  end
			5:begin data = X1_money;dp = 0;scan = 'b000100000;    end
			6:begin data = G_money;dp = 1;scan = 'b001000000;     end
			7:begin data = S_money;dp = 0;scan = 'b010000000;     end
			8:begin data = B_money;dp = 0;scan = 'b100000000;     end
			default:begin data = 10;dp = 0;scan = 'b000000000;     end
		endcase
	end
endmodule
