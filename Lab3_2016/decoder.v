module decoder(
	output reg [7:0] scan,
	output reg [6:0] seg7,
	output reg dp,
	input clk20mhz,stop,
	input [12:0] money_in,
	input [12:0] distance_in
);
	
	reg clk1khz=0;
	reg [3:0] data=0;
	reg [3:0] m_one=4'b0000,m_ten=4'b0000,m_hun=4'b0110,m_tho=4'b0000;
	reg [3:0] d_one=0,d_ten=0,d_hun=0,d_tho=0;
	reg [15:0] count=0;
	reg [15:0] comb1=0;
	reg [3:0] comb1_a=0,comb1_b=0,comb1_c=0,comb1_d=0;
	reg [15:0] comb2=0;
	reg [3:0] comb2_a=0,comb2_b=0,comb2_c=0,comb2_d=0;
	reg [2:0] cnt=0;
	
	parameter	case1 = 3'b000,
					case2 = 3'b001,
					case3 = 3'b010,
					case4 = 3'b011,
					case5 = 3'b100,
					case6 = 3'b101,
					case7 = 3'b110,
					case8 = 3'b111;
					
	parameter	zero = 4'b0000,
					one = 4'b0001,
					two = 4'b0010,
					three = 4'b0011,
					four = 4'b0100,
					five = 4'b0101,
					six = 4'b0110,
					seven = 4'b0111,
					eight = 4'b1000,
					nine = 4'b1001;
	
	//1kHz
	always@(posedge clk20mhz) begin
		if(count == 2) begin
			clk1khz <= ~clk1khz;
			count <= 0;
		end else count <= count+1;
			
		//change money to 4'd
		if(comb1<money_in) begin
			if(comb1_a==9 && comb1_b==9 &&comb1_c==9) begin
				comb1_a <= 4'b0000;
				comb1_b <= 4'b0000;
				comb1_c <= 4'b0000;
				comb1_d <= comb1_d+1;
				comb1 <= comb1+1;
			end
			
			else if(comb1_a==9 && comb1_b==9) begin
				comb1_a <= 4'b0000;
				comb1_b <= 4'b0000;
				comb1_c <= comb1_c+1;
				comb1 <= comb1+1;
			end
			
			else if(comb1_a==9) begin
				comb1_a <= 4'b0000;
				comb1_b <= comb1_b+1;
				comb1 <= comb1+1;
			end
			
			else begin
				comb1_a <= comb1_a+1;
				comb1 <= comb1+1;
			end
		end
		
		else if(comb1 == money_in) begin
			m_one <= comb1_a;
			m_ten <= comb1_b;
			m_hun <= comb1_c;
			m_tho <= comb1_d;
		end
		//distance changes to 4'd
		if(comb2 < distance_in) begin
			if(comb2_a==9 && comb2_b==9 &&comb2_c==9) begin
				comb2_a <= 4'b0000;
				comb2_b <= 4'b0000;
				comb2_c <= 4'b0000;
				comb2_d <= comb2_d+1;
				comb2 <= comb2+1;
			end
			
			else if(comb2_a==9 && comb2_b==9) begin
				comb2_a <= 4'b0000;
				comb2_b <= 4'b0000;
				comb2_c <= comb2_c+1;
				comb2 <= comb2+1;
			end
			
			else if(comb2_a==9) begin
				comb2_a <= 4'b0000;
				comb2_b <= comb2_b+1;
				comb2 <= comb2+1;
			end
			
			else begin
				comb2_a <= comb2_a+1;
				comb2 <= comb2+1;
			end
		end
		else if(comb2 == distance_in) begin
			d_one <= comb2_a;
			d_ten <= comb2_b;
			d_hun <= comb2_c;
			d_tho <= comb2_d;
		end
	end
	
	always@(posedge clk1khz) begin
		if(!stop) cnt <= cnt+1;
		else cnt <= 0;
	end

	always@(cnt) begin
		case(cnt)
			case1:				begin
										data <= m_one;
										dp <= 0;
										scan <= 8'b0000_0001;
									end
									
			case2:				begin
										data <= m_ten;
										dp <= 0;
										scan <= 8'b0000_0010;
									end
									
			case3:				begin
										data <= m_hun;
										dp <= 1;
										scan <= 8'b0000_0100;
									end
									
			case4:				begin
										data <= m_tho;
										dp <= 0;
										scan <= 8'b0000_1000;
									end
									
			case5:				begin
										data <= d_one;
										dp <= 0;
										scan <= 8'b0001_0000;
									end
									
			case6:				begin
										data <= d_ten;
										dp <= 0;
										scan <= 8'b0010_0000;
									end
									
			case7:				begin
										data <= d_hun;
										dp <= 1;
										scan <= 8'b0100_0000;
									end
									
			case8:				begin
										data <= d_tho;
										dp <= 0;
										scan <= 8'b1000_0000;
									end
		endcase
	end

	always@(data) begin
		case(data)
			zero:			seg7 <= 7'b1111110;
			one:			seg7 <= 7'b0110000;
			two:			seg7 <= 7'b1101101;
			three:		seg7 <= 7'b1111001;
			four:			seg7 <= 7'b0110011;
			five:			seg7 <= 7'b1011011;
			six:			seg7 <= 7'b1011111;
			seven:		seg7 <= 7'b1110000;
			eight:		seg7 <= 7'b1111111;
			nine:			seg7 <= 7'b1111011;
		endcase
	end
endmodule
