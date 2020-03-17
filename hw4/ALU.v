`timescale 1ns/1ps
`include "alu_top.v"

module ALU(
            src1_i,          // 64 bits source 1          (input)
            src2_i,          // 64 bits source 2          (input)
            ctrl_i,   // 4 bits ALU control input  (input)
            result_o,        // 64 bits result            (output)
            zero_o,          // 1 bit when the output is 0, zero must be set (output)
            );

input  [64-1:0] src1_i;
input  [64-1:0] src2_i;
input   [4-1:0] ctrl_i;

output [64-1:0] result_o;
output          zero_o;

wire            zero_o;
wire     [64-1:0] carry;
wire 			cin;

reg [1:0] operation;
reg a_in;
reg b_in;

assign cin = (ctrl_i==4'b0110 || ctrl_i==4'b0111) ? 1: 0;
assign zero_o = (result_o==0) ? 1: 0;


always @(*) begin
    case (ctrl_i)
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

alu_top alu0( .src1_i(src1_i[0]), .src2_i(src2_i[0]), .A_invert(a_in), .B_invert(b_in),
				  .cin(cin), .operation(operation), .result_o(result_o[0]), .cout(carry[0]) );

alu_top alu1( .src1_i(src1_i[1]), .src2_i(src2_i[1]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[0]), .operation(operation), .result_o(result_o[1]), .cout(carry[1]) );
				  
alu_top alu2( .src1_i(src1_i[2]), .src2_i(src2_i[2]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[1]), .operation(operation), .result_o(result_o[2]), .cout(carry[2]) );
				  
alu_top alu3( .src1_i(src1_i[3]), .src2_i(src2_i[3]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[2]), .operation(operation), .result_o(result_o[3]), .cout(carry[3]) );
				  
alu_top alu4( .src1_i(src1_i[4]), .src2_i(src2_i[4]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[3]), .operation(operation), .result_o(result_o[4]), .cout(carry[4]) );
				  
alu_top alu5( .src1_i(src1_i[5]), .src2_i(src2_i[5]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[4]), .operation(operation), .result_o(result_o[5]), .cout(carry[5]) );
				  
alu_top alu6( .src1_i(src1_i[6]), .src2_i(src2_i[6]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[5]), .operation(operation), .result_o(result_o[6]), .cout(carry[6]) );
				  
alu_top alu7( .src1_i(src1_i[7]), .src2_i(src2_i[7]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[6]), .operation(operation), .result_o(result_o[7]), .cout(carry[7]) );
				  
alu_top alu8( .src1_i(src1_i[8]), .src2_i(src2_i[8]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[7]), .operation(operation), .result_o(result_o[8]), .cout(carry[8]) );
				  
alu_top alu9( .src1_i(src1_i[9]), .src2_i(src2_i[9]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[8]), .operation(operation), .result_o(result_o[9]), .cout(carry[9]) );
				  
alu_top alu10( .src1_i(src1_i[10]), .src2_i(src2_i[10]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[9]), .operation(operation), .result_o(result_o[10]), .cout(carry[10]) );	
					
alu_top alu11( .src1_i(src1_i[11]), .src2_i(src2_i[11]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[10]), .operation(operation), .result_o(result_o[11]), .cout(carry[11]) );
					
alu_top alu12( .src1_i(src1_i[12]), .src2_i(src2_i[12]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[11]), .operation(operation), .result_o(result_o[12]), .cout(carry[12]) );
					
alu_top alu13( .src1_i(src1_i[13]), .src2_i(src2_i[13]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[12]), .operation(operation), .result_o(result_o[13]), .cout(carry[13]) );
					
alu_top alu14( .src1_i(src1_i[14]), .src2_i(src2_i[14]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[13]), .operation(operation), .result_o(result_o[14]), .cout(carry[14]) );
					
alu_top alu15( .src1_i(src1_i[15]), .src2_i(src2_i[15]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[14]), .operation(operation), .result_o(result_o[15]), .cout(carry[15]) );
					
alu_top alu16( .src1_i(src1_i[16]), .src2_i(src2_i[16]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[15]), .operation(operation), .result_o(result_o[16]), .cout(carry[16]) );
					
alu_top alu17( .src1_i(src1_i[17]), .src2_i(src2_i[17]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[16]), .operation(operation), .result_o(result_o[17]), .cout(carry[17]) );
					
alu_top alu18( .src1_i(src1_i[18]), .src2_i(src2_i[18]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[17]), .operation(operation), .result_o(result_o[18]), .cout(carry[18]) );
					
alu_top alu19( .src1_i(src1_i[19]), .src2_i(src2_i[19]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[18]), .operation(operation), .result_o(result_o[19]), .cout(carry[19]) );
					
alu_top alu20( .src1_i(src1_i[20]), .src2_i(src2_i[20]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[19]), .operation(operation), .result_o(result_o[20]), .cout(carry[20]) );
					
alu_top alu21( .src1_i(src1_i[21]), .src2_i(src2_i[21]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[20]), .operation(operation), .result_o(result_o[21]), .cout(carry[21]) );
					
alu_top alu22( .src1_i(src1_i[22]), .src2_i(src2_i[22]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[21]), .operation(operation), .result_o(result_o[22]), .cout(carry[22]) );
					
alu_top alu23( .src1_i(src1_i[23]), .src2_i(src2_i[23]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[22]), .operation(operation), .result_o(result_o[23]), .cout(carry[23]) );
					
alu_top alu24( .src1_i(src1_i[24]), .src2_i(src2_i[24]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[23]), .operation(operation), .result_o(result_o[24]), .cout(carry[24]) );
					
alu_top alu25( .src1_i(src1_i[25]), .src2_i(src2_i[25]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[24]), .operation(operation), .result_o(result_o[25]), .cout(carry[25]) );
					
alu_top alu26( .src1_i(src1_i[26]), .src2_i(src2_i[26]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[25]), .operation(operation), .result_o(result_o[26]), .cout(carry[26]) );
					
alu_top alu27( .src1_i(src1_i[27]), .src2_i(src2_i[27]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[26]), .operation(operation), .result_o(result_o[27]), .cout(carry[27]) );
					
alu_top alu28( .src1_i(src1_i[28]), .src2_i(src2_i[28]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[27]), .operation(operation), .result_o(result_o[28]), .cout(carry[28]) );
					
alu_top alu29( .src1_i(src1_i[29]), .src2_i(src2_i[29]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[28]), .operation(operation), .result_o(result_o[29]), .cout(carry[29]) );
					
alu_top alu30( .src1_i(src1_i[30]), .src2_i(src2_i[30]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[29]), .operation(operation), .result_o(result_o[30]), .cout(carry[30]) );

alu_top alu31( .src1_i(src1_i[31]), .src2_i(src2_i[31]), .A_invert(a_in), .B_invert(b_in),
				  .cin(carry[30]), .operation(operation), .result_o(result_o[31]), .cout(carry[31]) );

alu_top alu32( .src1_i(src1_i[32]), .src2_i(src2_i[32]), .A_invert(a_in), .B_invert(b_in),
				  .cin(carry[31]), .operation(operation), .result_o(result_o[32]), .cout(carry[32]) );

alu_top alu33( .src1_i(src1_i[33]), .src2_i(src2_i[33]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[32]), .operation(operation), .result_o(result_o[33]), .cout(carry[33]) );
				  
alu_top alu34( .src1_i(src1_i[34]), .src2_i(src2_i[34]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[33]), .operation(operation), .result_o(result_o[34]), .cout(carry[34]) );
				  
alu_top alu35( .src1_i(src1_i[35]), .src2_i(src2_i[35]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[34]), .operation(operation), .result_o(result_o[35]), .cout(carry[35]) );
				  
alu_top alu36( .src1_i(src1_i[36]), .src2_i(src2_i[36]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[35]), .operation(operation), .result_o(result_o[36]), .cout(carry[36]) );
				  
alu_top alu37( .src1_i(src1_i[37]), .src2_i(src2_i[37]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[36]), .operation(operation), .result_o(result_o[37]), .cout(carry[37]) );
				  
alu_top alu38( .src1_i(src1_i[38]), .src2_i(src2_i[38]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[37]), .operation(operation), .result_o(result_o[38]), .cout(carry[38]) );
				  
alu_top alu39( .src1_i(src1_i[39]), .src2_i(src2_i[39]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[38]), .operation(operation), .result_o(result_o[39]), .cout(carry[39]) );
				  
alu_top alu40( .src1_i(src1_i[40]), .src2_i(src2_i[40]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[39]), .operation(operation), .result_o(result_o[40]), .cout(carry[40]) );
				  
alu_top alu41( .src1_i(src1_i[41]), .src2_i(src2_i[41]), .A_invert(a_in), .B_invert(b_in),
	 		     .cin(carry[40]), .operation(operation), .result_o(result_o[41]), .cout(carry[41]) );
				  
alu_top alu42( .src1_i(src1_i[42]), .src2_i(src2_i[42]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[41]), .operation(operation), .result_o(result_o[42]), .cout(carry[42]) );	
					
alu_top alu43( .src1_i(src1_i[43]), .src2_i(src2_i[43]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[42]), .operation(operation), .result_o(result_o[43]), .cout(carry[43]) );
					
alu_top alu44( .src1_i(src1_i[44]), .src2_i(src2_i[44]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[43]), .operation(operation), .result_o(result_o[44]), .cout(carry[44]) );
					
alu_top alu45( .src1_i(src1_i[45]), .src2_i(src2_i[45]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[44]), .operation(operation), .result_o(result_o[45]), .cout(carry[45]) );
					
alu_top alu46( .src1_i(src1_i[46]), .src2_i(src2_i[46]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[45]), .operation(operation), .result_o(result_o[46]), .cout(carry[46]) );
					
alu_top alu47( .src1_i(src1_i[47]), .src2_i(src2_i[47]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[46]), .operation(operation), .result_o(result_o[47]), .cout(carry[47]) );
					
alu_top alu48( .src1_i(src1_i[48]), .src2_i(src2_i[48]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[47]), .operation(operation), .result_o(result_o[48]), .cout(carry[48]) );
					
alu_top alu49( .src1_i(src1_i[49]), .src2_i(src2_i[49]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[48]), .operation(operation), .result_o(result_o[49]), .cout(carry[49]) );
					
alu_top alu50( .src1_i(src1_i[50]), .src2_i(src2_i[50]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[49]), .operation(operation), .result_o(result_o[50]), .cout(carry[50]) );
					
alu_top alu51( .src1_i(src1_i[51]), .src2_i(src2_i[51]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[50]), .operation(operation), .result_o(result_o[51]), .cout(carry[51]) );
					
alu_top alu52( .src1_i(src1_i[52]), .src2_i(src2_i[52]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[51]), .operation(operation), .result_o(result_o[52]), .cout(carry[52]) );
					
alu_top alu53( .src1_i(src1_i[53]), .src2_i(src2_i[53]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[52]), .operation(operation), .result_o(result_o[53]), .cout(carry[53]) );
					
alu_top alu54( .src1_i(src1_i[54]), .src2_i(src2_i[54]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[53]), .operation(operation), .result_o(result_o[54]), .cout(carry[54]) );
					
alu_top alu55( .src1_i(src1_i[55]), .src2_i(src2_i[55]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[54]), .operation(operation), .result_o(result_o[55]), .cout(carry[55]) );
					
alu_top alu56( .src1_i(src1_i[56]), .src2_i(src2_i[56]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[55]), .operation(operation), .result_o(result_o[56]), .cout(carry[56]) );
					
alu_top alu57( .src1_i(src1_i[57]), .src2_i(src2_i[57]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[56]), .operation(operation), .result_o(result_o[57]), .cout(carry[57]) );
					
alu_top alu58( .src1_i(src1_i[58]), .src2_i(src2_i[58]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[57]), .operation(operation), .result_o(result_o[58]), .cout(carry[58]) );
					
alu_top alu59( .src1_i(src1_i[59]), .src2_i(src2_i[59]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[58]), .operation(operation), .result_o(result_o[59]), .cout(carry[59]) );
					
alu_top alu60( .src1_i(src1_i[60]), .src2_i(src2_i[60]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[59]), .operation(operation), .result_o(result_o[60]), .cout(carry[60]) );
					
alu_top alu61( .src1_i(src1_i[61]), .src2_i(src2_i[61]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[60]), .operation(operation), .result_o(result_o[61]), .cout(carry[61]) );
					
alu_top alu62( .src1_i(src1_i[62]), .src2_i(src2_i[62]), .A_invert(a_in), .B_invert(b_in),
	 		      .cin(carry[61]), .operation(operation), .result_o(result_o[62]), .cout(carry[62]) );

alu_top alu63( .src1_i(src1_i[63]), .src2_i(src2_i[63]), .A_invert(a_in), .B_invert(b_in),
				  .cin(carry[62]), .operation(operation), .result_o(result_o[63]), .cout(carry[63]) );
endmodule