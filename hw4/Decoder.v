//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	Branch_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o,
	Jal_o
	);
     
//I/O ports
input	[7-1:0]	instr_op_i;

output			RegWrite_o;
output	[2-1:0]	ALU_op_o;
output			ALUSrc_o;
output			Branch_o;
output			MemRead_o;
output			MemWrite_o;
output			MemtoReg_o;
output			Jal_o;
 
//Internal Signals
reg	[2-1:0]		ALU_op_o;
reg				ALUSrc_o;
reg				RegWrite_o;
reg				Branch_o;
reg				MemRead_o;
reg				MemWrite_o;
reg				MemtoReg_o;
reg 			Jal_o;

//Parameter


//Main function
always@( instr_op_i )begin
	// $display("Element Decoder, Your instruction OP code is: %b", instr_op_i);
    case (instr_op_i)
		7'b0110011:begin		//R-type
			$display("R-type");
			RegWrite_o <= 1'b1;
			ALU_op_o <= 2'b10;
			ALUSrc_o <= 1'b0; 
			Branch_o <= 1'b0;
			MemRead_o <= 1'b0;
			MemWrite_o <= 1'b0;
			MemtoReg_o <= 1'b0;
			Jal_o <= 1'b0;
			end
		7'b0010011:begin		//I-type
			$display("I-type");
			RegWrite_o <= 1'b1;
			ALU_op_o <= 2'b00;
			ALUSrc_o <= 1'b1; 
			Branch_o <= 1'b0;
			MemRead_o <= 1'b0;
			MemWrite_o <= 1'b0;
			MemtoReg_o <= 1'b0;
			Jal_o <= 1'b0;
			end
		7'b0000011:begin		//for ld
			$display("load d");
			RegWrite_o <= 1'b1;
			ALU_op_o <= 2'b00;
			ALUSrc_o <= 1'b1; 
			Branch_o <= 1'b0;
			MemRead_o <= 1'b1;
			MemWrite_o <= 1'b0;
			MemtoReg_o <= 1'b1;
			Jal_o <= 1'b0;
			end
		7'b0100011:begin		//S-type
			$display("S-type");
			RegWrite_o <= 1'b0;
			ALU_op_o <= 2'b00;
			ALUSrc_o <= 1'b1;
			Branch_o <= 1'b0;
			MemRead_o <= 1'b0;
			MemWrite_o <= 1'b1;
			MemtoReg_o <= 1'b0;
			Jal_o <= 1'b0;
			end
		7'b1100011:begin		//B-type
			$display("B-type");
			RegWrite_o <= 1'b0;
			ALU_op_o <= 2'b01;
			ALUSrc_o <= 1'b0;
			Branch_o <= 1'b1;
			MemRead_o <= 1'b0;
			MemWrite_o <= 1'b0;
			MemtoReg_o <= 1'b0;
			Jal_o <= 1'b0;
			end
		7'b1101111:begin		//J-type
			$display("J-type");
			Jal_o <= 1'b1;
			RegWrite_o <= 1'b1; //write back to rd reg
			ALU_op_o <= 2'b10; //NOP
			ALUSrc_o <= 1'b1; //chose pc extended 64
			Branch_o <= 1'b0; //NOP
			MemRead_o <= 1'b0; //NOP
			MemWrite_o <= 1'b0; //NOP
			MemtoReg_o <= 1'b0; //write back alu result
			end
		default:begin
			$display("Non type, error.");
			RegWrite_o <= 1'b0;
			ALU_op_o <= 2'b00;
			ALUSrc_o <= 1'b0;
			Branch_o <= 1'b0;
			MemRead_o <= 1'b0;
			MemWrite_o <= 1'b0;
			MemtoReg_o <= 1'b0;
			Jal_o <= 1'b0;
			end
    endcase
end

endmodule





                    
                    
