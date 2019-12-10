# Lab 3 Report - Design of the Taxi Meter

## Lab Targets

This lab will design a taxi meter. The detailed functions are following.

The initial money is 6 yuan.

When the distance is bigger than 3km, the money adds 1.2yuan every kilometre. 

When the money is bigger than 20yuan, the money of every kilometre added 50%, i.e.1.8yuna /km.

There are three states. ‘start’, ‘stop’ and ‘pause’. ‘start’ means money sets to initial state and distance increases from zero. ‘stop’ means that money return back to initial state and distance is eliminated. When the car pauses, do not count money and distance for this time.

The car has 4 different blocks of speed.

After simulations in the computer, the results ought to be showed in the hardware requirements: show the varying values in the eight 7-segments.

## Code & Comments

### Top Module – Lab3.v

```verilog
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
```

This model named Lab3, has five output and six input,

1. One 8-bit reg output, **scan**, assign the monitor the address of the segments.
2. One 7-bit output, **seg7**, for the display of the 7-segment.
3. One 1-bit output, **dp**, for display the decimal point in the segments.
4. Two 1-bit inputs, **clk20mhz & clk**, which represent the frequency in the hardware equipment and the frequency in the simulation on the computer respectively.
5. Three 3-bit inputs, **start & stop & pause**, to control the states of the car.
6. One 2-bit input, **gears**, for controlling and changing the speed of the car.
7. Two 12-bit outputs, **money & distance**, indicating the value of money and distance respectively.

### Taxi – taxi.v

```verilog
module taxi(
	output reg [12:0] money,
	output reg [12:0] distance,
	input clk,start,stop,pause,
	input [1:0] gears
);
	
	reg [12:0] money_register;
	reg [12:0] distance_register;
	reg [3:0] num;
	reg [12:0] dis;
	reg d;
	
	always @(posedge clk) begin
		if(stop) begin
			money_register <= 600;
			distance_register <= 0;
			num <= 1;
			dis <= 0;
		end else if(start) begin
			money_register <= 600;
			distance_register <= 0;
			num <= 1;
			dis <= 0;
		end else begin
			if(!start && !gears && !pause && !stop) begin
				if(num == 9) begin
					num <= 0;
					distance_register <= distance_register+1;
					dis <= dis+1;
				end else num <= num+1;
			end
			
			else if(!start && gears==2'b01 && !pause && !stop) begin
				if(num == 9) begin
					num <= 0;
					distance_register <= distance_register+2;
					dis <= dis+2;
				end else num <= num+1;
			end
			
			else if(!start && gears==2'b10 && !pause && !stop) begin
				if(num == 9) begin
					num <= 0;
					distance_register <= distance_register+3;
					dis <= dis+3;
				end else num <= num+1;
			end
			
			else if(!start && gears==2'b11 && !pause && !stop) begin
				if(num == 9) begin
					num <= 0;
					distance_register <= distance_register+4;
					dis <= dis+4;
				end else num <= num+1;
			end
		end
		
		if(dis >= 100) begin
			d <= 1;
			dis <= 0;
		end else d <= 0;
		
		if(distance_register >= 300) begin
			if(money_register < 2000 && d==1) money_register <= money_register+120;
			else if(money_register >= 2000 && d==1) money_register <= money_register+180;
		end
		
		money <= money_register;
		distance <= distance_register;
	end
endmodule
```

This model has two output and five input,

1. Two 12-bit outputs, **money & distance**, indicating the value of money and distance respectively.
2. One 1-bit input, **clk**, representing the frequency in the simulation on the compute.
3. Three 3-bit inputs, **start & stop & pause**, to control the states of the car.
4. One 2-bit input, **gears**, for controlling and changing the speed of the car.

Line 8 to Line 9 are declare two 13-bit reg type intermediate variable, **money_register** & **distance_register**, for storing the value of money and distance in these registers.

Line 10 declare a 4-bit reg type intermediate variable, **num**, increasing 1 each time for raising the distance. 

Line 11 are declare a 13-bit reg type intermediate variable, **dis**, which equals to the value of distance_register and help to determine the state of d.

Line 12 are declare a 1-bit reg type intermediate variable, **d**, which indicates the decimal point and would be HIGH when the value of distance_register is bigger than 100.

Line 15 to Line 19: In ‘stop’ condition. When the stop signal is HIGH, money_register returns back to initial state and distance is eliminated. Furthermore, num equals one and dis is cleared up for next counting.

Line 20 to Line 24: The ‘start’ condition. When the start signal is HIGH, the car begins to run. In this condition, the initial value of money_register becomes to 6 yuan; meanwhile, the distance_register is still zero that is ready to record the distance. num equals one and dis signal is zero, ready to count.

Line 25: This part implementing different distance record relating with different gears (i.e. with different speeds) is shown blow. 

Line 26 to Line 32: The First Gear condition. When num is below nine, num increases one once clock cycle and the distance does not change. When num achieves nine, the distance increases one and the number backs to zero. In other words, the speed of this gear is 0.1 km/10 cycles.

Line 34 to Line 40: The Second Gear condition. Similar as the first gear condition, when num is below nine, num increases one once clock cycle and the distance does not change. When num achieves nine, the distance increases two and the number backs to zero. In other words, the speed of this gear is 0.2 km/10 cycles.

Line 42 to Line 48: The Third Gear condition. Similar as the previous gear conditions, when num is below nine, num increases one once clock cycle and the distance does not change. When num achieves nine, the distance increases three and the number backs to zero. In other words, the speed of this gear is 0.3 km/10 cycles.

Line 50 to Line 56: The Fourth Gear condition. Similar as the previous gear conditions, when num is below nine, num increases one once clock cycle and the distance does not change. When num achieves nine, the distance increases four and the number backs to zero. In other words, the speed of this gear is 0.4 km/10 cycles.

Line 59 to Line 62: When dis is greater than 100, d, decimal point, should be HIGH and clear dis. Otherwise, the decimal point signal should be LOW.

Line 64 to Line 67: Implement money change when distance is bigger than 3km. When distance is greater than 3km besides money is under 20yuan, the price of every kilometre is 1.2yuan. Therefore,money_register adds 120 each cycle. When money is over 20yuan, the price of every kilometre is 1.8yuan (I have discussed the reason in Lab Target.). Therefore, money_register adds 180 each cycle.

### Decoder - decoder.v

```verilog
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
										scan <= 8'b00000001;
									end
									
			case2:				begin
										data <= m_ten;
										dp <= 0;
										scan <= 8'b00000010;
									end
									
			case3:				begin
										data <= m_hun;
										dp <= 1;
										scan <= 8'b00000100;
									end
									
			case4:				begin
										data <= m_tho;
										dp <= 0;
										scan <= 8'b00001000;
									end
									
			case5:				begin
										data <= d_one;
										dp <= 0;
										scan <= 8'b00010000;
									end
									
			case6:				begin
										data <= d_ten;
										dp <= 0;
										scan <= 8'b00100000;
									end
									
			case7:				begin
										data <= d_hun;
										dp <= 1;
										scan <= 8'b01000000;
									end
									
			case8:				begin
										data <= d_tho;
										dp <= 0;
										scan <= 8'b10000000;
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
```

This model has three output ports and four input ports.

1. One 8-bit reg output, **scan**, assign the monitor the address of the segments.
2. One 7-bit output, **seg7**, for the display of the 7-segment (abcdefg).
3. One 1-bit output, **dp**, for display the decimal point in the segments.
4. Two 1-bit inputs, **clk20mhz**, which represent the frequency in the hardware equipment.
5. Two 12-bit inputs, **money & distance**, indicating the value of money and distance respectively.

Line 10 to Line 19: Declare some intermediate variables.

- **clk1khz**: This is a clock for scanning tube code address.
- **data**: Storing the values of every digit and as the control signal for determining what displays on seg7 later.
- **m_one** & **m_ten** & **m_hun** & **m_tho**: Storing the values of each bit of money_in with 4-bit decimal form.
- **d_one** & **d_ten** & **d_hun** & **d_tho**: Storing the values of every bit of distance_in with 4-bit decimal form.
- **count**: Helping to define clk1khz signal.
- **comb1**: This variable will store the value of money_in finally and be used in changing money to 4-bit decimal programming.
- **comb1_a** & **comb1_b** & **comb1_c** & **comb1_d**: These variables will store the values of each digit of money_in finally and be used in changing money to 4-bit decimal programming.
- **comb2**: This variable will store the value of distance_in finally and be used in changing distance to 4-bit decimal programming.
- **comb2_a** & **comb2_b** & **comb2_c** & **comb2_d**: These variables will store the values of each digit of distance_in finally and be used in changing distance to 4-bit decimal programming.
- **cnt**: As the control signal for scanning tube code address.

Line 21 to Line 28: Declare 8 3-bit parameters for identifying 8 operations respectively.

| **Name** | **Operation** | **Opcode** | **Nmae** | **Operation** | **Opcode** |
| :------: | :-----------: | :--------: | :------: | :-----------: | :--------: |
|  case1   | Scan   m_one  |    000     |  case5   | Scan   d_one  |    100     |
|  case2   | Scan   m_ten  |    001     |  case6   | Scan   d_ten  |    101     |
|  case3   | Scan   m_hun  |    010     |  case7   | Scan   d_hun  |    110     |
|  case4   | Scan   m_tho  |    011     |  case8   | Scan   d_tho  |    111     |

Line 30 to Line 39: Declare 8 7-bit parameters for identifying 8 displays of the 7-segment respectively. The following figure is a seven-segment LED display.

<img src="Lab3.assets/fig22.png" alt="fig22" style="zoom: 33%;" />

| **Display** | **Binary Code** | **Hexadecimal Code** | **Opcode** | **Display** | **Binary Code** | **Hexadecimal Code** | **Opcode** |
| :---------: | :-------------: | :------------------: | :--------: | :---------: | :-------------: | :------------------: | :--------: |
|    zero     |     1111110     |          7e          |    0000    |    five     |     1011011     |          5b          |    0101    |
|     one     |     0110000     |          30          |    0001    |     six     |     1011111     |          5f          |    0110    |
|     two     |     1101101     |          6d          |    0010    |    seven    |     1110000     |          70          |    0111    |
|    three    |     1111001     |          79          |    0011    |    eight    |     1111111     |          7f          |    1000    |
|    four     |     0110011     |          33          |    0100    |    nine     |     1111011     |          7b          |    1001    |

Line 43 to Line 46: Define the clock, clk1khz. Every 3 cycles of clk20mhz, clk1khz will changed.

Line 49 to Line 75: Changing money_in to 4-bit decimal. When comb1 is less than money_in. comb1_a & comb1_b & comb1_c & comb1_d will increase step by step. There are three types of carry-overs in total. The methods are similar. If the digit not big enough (not reach 10 in decimal), then just increments itself 1. Else if is enough, the digit backs to zero, and the next digit increments one. No matter whether carry in or not, comb1 always increments one for recording the value of money.

Line 77 to Line 82: Assign the values of each digit to m_one & m_ten & m_hun & m_tho respectively.

Line 84 to Line 109: Changing distance_in to 4-bit decimal. When comb2 is less than distance_in. comb2_a & comb2_b & comb2_c & comb2_d will increase step by step. There are three types of carry-overs in total. The methods are similar. If the digit not big enough (not reach 10 in decimal), then just increments itself 1. Else if is enough, the digit backs to zero, and the next digit increments one. No matter whether carry in or not, comb2 always increments one for recording the value of distance.

Line 111 to Line 116: Assign the values of each digit to d_one & d_ten & d_hun & d_tho respectively.

Line 119 to Line 122: If stop signal is low, cnt increments one every cycle of clk1khz as the control signal for scanning tube code address. Otherwise, cnt should be cleared up.

Line 125 to Line 173:Appoint the values to determine which segment will be displayed. Statement *case* is used to define the operations of each case in detail. In these eight cases, we need to transfer the value from m_one & m_ten & m_hun & m_tho & d_one & d_ten & d_hun & d_tho to data respectively. In case3 and case7, dp changes to HIGH because there is a decimal point after hundred digit which means the decimal point before decimal fraction actually, while dp is LOW in other cases. scan is an 8-bit output. Every bit of it is shown in the following form. Which bit is HIGH, which segment will display.

| bit 7 | bit 6 | bit 5 | bit 4 | bit 3 | bit 2 | bit 1 | bit 0 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| d_tho | d_hun | d_ten | d_one | m_tho | m_hun | m_ten | m_one |

Line 176 to Line 188: Define the performance of the 7-segments to make them display the values in decimal numbers. Statement *case* is used to define the corresponding binary codes of each case in detail. In these ten cases, we just assign the corresponding binary codes to segments. Note that statement *case* requires the key word ‘endcase’ to indicate case is finished.

## Testbench - Lab3.vt

```verilog
module Lab3_vlg_tst();
// constants                                           
// general purpose registers
reg eachvec;
// test vector input registers
reg clk;
reg clk20mhz;
reg [1:0] gears;
reg pause;
reg start;
reg stop;
// wires                                               
wire [12:0]  distance;
wire dp;
wire [12:0]  money;
wire [7:0]  scan;
wire [6:0]  seg7;

// assign statements (if any)                          
Lab3 i1 (
// port map - connection between master ports and signals/registers   
	.clk(clk),
	.clk20mhz(clk20mhz),
	.distance(distance),
	.dp(dp),
	.gears(gears),
	.money(money),
	.pause(pause),
	.scan(scan),
	.seg7(seg7),
	.start(start),
	.stop(stop)
);

	initial 
		begin
		//The test finishes after one hour.
		#3600000000 $finish;
		end

	initial 
		begin
		//The period of the clock, clk, is 4ns.
		//Every 2ns, clk changes from HIGH to LOW or from LOW to HIGH.
		clk = 1'b1;
		forever #2 clk = ~clk;
		end
	
	initial
		begin
		//The period of the clock, clk20mhz, is 2ns.
		//Every 1ns, clk changes from HIGH to LOW or from LOW to HIGH.
		//Therefore, the period of clk1khz is 4ns. 
		clk20mhz = 1'b1;
		forever #1 clk20mhz = ~clk20mhz;
		end
	
	initial
		begin
		//At the begining, the car is stationary.
		//Therefore, set start, stop and pause to LOW.
		start = 1'b1;
		stop = 1'b0;
		pause = 1'b0;
		//Start the car.
		#5 start = 1'b0;
		//Test the first gear condition.
		gears = 2'b00;
		//Assume that this journey is ending at 175ns 
		//for testing whether stop signal works.
		#170 stop = 1'b1;
		#10 stop = 1'b0;
		//Start the car and assume that pause occurs at 245ns
		//for testing wheather pause signal works.
		#10 start = 1'b1;
		#10 start = 1'b0;
		#40 pause = 1'b1;
		#10 pause = 1'b0;

		//Test the second gear condition.
		#60500 stop = 1'b1;
		#10 stop = 1'b0;
		#2 start = 1'b1;
		#5 start = 1'b0;
		#2 gears = 2'b01;

		//Test the third gear condition.
		#30500 stop = 1'b1;
		#10 stop = 1'b0;
		#2 start = 1'b1;
		#5 start = 1'b0;
		#2 gears = 2'b10;

		//Test the fourth gear condition.
		#20500 stop = 1'b1;
		#10 stop = 1'b0;
		#2 start = 1'b1;
		#5 start = 1'b0;
		#2 gears = 2'b11;
		end
endmodule
```

