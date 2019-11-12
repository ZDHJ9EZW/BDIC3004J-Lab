module ALU (output reg [4:0] ALU_out, input [3:0] Data_A, Data_B, input [2:0] Opcode);
	parameter	Add		= 3'b000,	//	A + B
					Subtract	= 3'b001,	//	A - B
					Or_AB		= 3'b010,	//	A | B
					And_AB	= 3'b011,	//	A & B
					Not_A		= 3'b100,	//	~ A
					Exor		= 3'b101,	//	A ^ B
					Exnor		= 3'b110,	//	A ~ ^ B
					Ror_A		= 3'b111;	//	| A

	always@(*)
	
	case(Opcode)
		Add:			ALU_out =  Data_A + Data_B;
		Subtract:	ALU_out =  Data_A - Data_B;
		Or_AB:		ALU_out =  Data_A | Data_B;
		And_AB:		ALU_out =  Data_A & Data_B;
		Not_A:		ALU_out =  ~ Data_A;
		Exor:			ALU_out =  Data_A ^ Data_B;
		Exnor:		ALU_out =  Data_A ~^ Data_B;
		Ror_A:		ALU_out <= {Data_A[0],Data_A[3:1]};
	endcase
endmodule