`timescale 1ns/1ps
`include "alu_last.v"
`include "alu_top.v"

module alu(
            rst_n,         // negative reset            (input)
            src1,          // 32 bits source 1          (input)
            src2,          // 32 bits source 2          (input)
            ALU_control,   // 4 bits ALU control input  (input)
            result,        // 32 bits result            (output)
            zero,          // 1 bit when the output is 0, zero must be set (output)
            cout,          // 1 bit carry out           (output)
            overflow       // 1 bit overflow            (output)
            );

input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

wire            zero;
wire            cout;
wire            overflow;
wire     [31:0] carry;
wire            set;

reg [1:0] operation;
reg a_in;
reg b_in;
reg less_sig;

assign carry[0] = (ALU_control==4'b0110 || ALU_control==4'b0111) ? 1: 0;
assign zero = (result==0) ? 1: 0;
// assign overflow = carry[31] ^ cout;
// assign overflow = ( (ALU_control==4'b0000) & src1[31] & src2[31] & ~result[31]) ? 1 
// 					  :( (ALU_control==4'b0000) & ~src1[31] & ~src2[31] & result[31]) ? 1 
// 					  :( (ALU_control==4'b0110) & src1[31] & ~src2[31] & ~(result[31])) ? 1 
// 					  :( (ALU_control==4'b0110) & ~src1[31] & src2[31] & result[31]) ? 1 
// 					  : 0;

always @(*) begin
    if(rst_n==1)begin
        less_sig = 1'b0;
        
        case (ALU_control)
            4'b0000:begin//and
                a_in <= 0;
                b_in <= 0;
                operation <= 2'b00;
                end
            4'b0001:begin//or
                a_in <= 0;
                b_in <= 0;
                operation <= 2'b01;
                end
            4'b0010:begin//add
                a_in <= 0;
                b_in <= 0;
                operation <= 2'b10;
                end
            4'b0110:begin//sub
                a_in <= 0;
                b_in <= 1;
                operation <= 2'b10;
                end
            4'b1100:begin//nor
                a_in <= 1;
                b_in <= 1;
                operation <= 2'b00; 
                end
            4'b0111:begin//slt
                a_in <= 0;
                b_in <= 1;
                operation <= 2'b11;
                end
            default: ;
        endcase
    end    
end

alu_top alu0( .src1(src1[0]), .src2(src2[0]), .less(set), .A_invert(a_in), .B_invert(b_in),
				  .cin(carry[0]), .operation(operation), .result(result[0]), .cout(carry[1]) );

alu_top alu1( .src1(src1[1]), .src2(src2[1]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[1]), .operation(operation), .result(result[1]), .cout(carry[2]) );
				  
alu_top alu2( .src1(src1[2]), .src2(src2[2]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[2]), .operation(operation), .result(result[2]), .cout(carry[3]) );
				  
alu_top alu3( .src1(src1[3]), .src2(src2[3]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[3]), .operation(operation), .result(result[3]), .cout(carry[4]) );
				  
alu_top alu4( .src1(src1[4]), .src2(src2[4]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[4]), .operation(operation), .result(result[4]), .cout(carry[5]) );
				  
alu_top alu5( .src1(src1[5]), .src2(src2[5]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[5]), .operation(operation), .result(result[5]), .cout(carry[6]) );
				  
alu_top alu6( .src1(src1[6]), .src2(src2[6]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[6]), .operation(operation), .result(result[6]), .cout(carry[7]) );
				  
alu_top alu7( .src1(src1[7]), .src2(src2[7]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[7]), .operation(operation), .result(result[7]), .cout(carry[8]) );
				  
alu_top alu8( .src1(src1[8]), .src2(src2[8]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[8]), .operation(operation), .result(result[8]), .cout(carry[9]) );
				  
alu_top alu9( .src1(src1[9]), .src2(src2[9]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[9]), .operation(operation), .result(result[9]), .cout(carry[10]) );
				  
alu_top alu10( .src1(src1[10]), .src2(src2[10]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[10]), .operation(operation), .result(result[10]), .cout(carry[11]) );	
					
alu_top alu11( .src1(src1[11]), .src2(src2[11]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[11]), .operation(operation), .result(result[11]), .cout(carry[12]) );
					
alu_top alu12( .src1(src1[12]), .src2(src2[12]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[12]), .operation(operation), .result(result[12]), .cout(carry[13]) );
					
alu_top alu13( .src1(src1[13]), .src2(src2[13]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[13]), .operation(operation), .result(result[13]), .cout(carry[14]) );
					
alu_top alu14( .src1(src1[14]), .src2(src2[14]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[14]), .operation(operation), .result(result[14]), .cout(carry[15]) );
					
alu_top alu15( .src1(src1[15]), .src2(src2[15]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[15]), .operation(operation), .result(result[15]), .cout(carry[16]) );
					
alu_top alu16( .src1(src1[16]), .src2(src2[16]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[16]), .operation(operation), .result(result[16]), .cout(carry[17]) );
					
alu_top alu17( .src1(src1[17]), .src2(src2[17]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[17]), .operation(operation), .result(result[17]), .cout(carry[18]) );
					
alu_top alu18( .src1(src1[18]), .src2(src2[18]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[18]), .operation(operation), .result(result[18]), .cout(carry[19]) );
					
alu_top alu19( .src1(src1[19]), .src2(src2[19]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[19]), .operation(operation), .result(result[19]), .cout(carry[20]) );
					
alu_top alu20( .src1(src1[20]), .src2(src2[20]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[20]), .operation(operation), .result(result[20]), .cout(carry[21]) );
					
alu_top alu21( .src1(src1[21]), .src2(src2[21]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[21]), .operation(operation), .result(result[21]), .cout(carry[22]) );
					
alu_top alu22( .src1(src1[22]), .src2(src2[22]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[22]), .operation(operation), .result(result[22]), .cout(carry[23]) );
					
alu_top alu23( .src1(src1[23]), .src2(src2[23]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[23]), .operation(operation), .result(result[23]), .cout(carry[24]) );
					
alu_top alu24( .src1(src1[24]), .src2(src2[24]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[24]), .operation(operation), .result(result[24]), .cout(carry[25]) );
					
alu_top alu25( .src1(src1[25]), .src2(src2[25]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[25]), .operation(operation), .result(result[25]), .cout(carry[26]) );
					
alu_top alu26( .src1(src1[26]), .src2(src2[26]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[26]), .operation(operation), .result(result[26]), .cout(carry[27]) );
					
alu_top alu27( .src1(src1[27]), .src2(src2[27]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[27]), .operation(operation), .result(result[27]), .cout(carry[28]) );
					
alu_top alu28( .src1(src1[28]), .src2(src2[28]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[28]), .operation(operation), .result(result[28]), .cout(carry[29]) );
					
alu_top alu29( .src1(src1[29]), .src2(src2[29]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[29]), .operation(operation), .result(result[29]), .cout(carry[30]) );
					
alu_top alu30( .src1(src1[30]), .src2(src2[30]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[30]), .operation(operation), .result(result[30]), .cout(carry[31]) );

alu_last alu31( .src1(src1[31]), .src2(src2[31]), .less(less_sig), .A_invert(a_in), .B_invert(b_in),
				  .cin(carry[31]), .operation(operation), .result(result[31]), .cout(cout), 
                  .set(set), .overflow(overflow));
endmodule