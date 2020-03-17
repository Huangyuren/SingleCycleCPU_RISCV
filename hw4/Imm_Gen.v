//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module Imm_Gen(
    instr_i,
    pc_i,
    signed_extend_o,
    pc_extend64_o
    );
               
//I/O ports
input   [32-1:0] instr_i;
input   [32-1:0] pc_i;
output  [64-1:0] signed_extend_o;
output  [64-1:0] pc_extend64_o;

//Internal Signals
reg     [64-1:0] signed_extend_o;
reg     [64-1:0] pc_extend64_o;

//Sign extended
always@( * )begin
    case (instr_i[6:0])
	7'b0010011:begin    //addi, slti
	    signed_extend_o <= { {52{instr_i[31]}}, {instr_i[31:20]} };
        pc_extend64_o <= 64'd0;
        end
    7'b0100011:begin    //sd
	    signed_extend_o <= { {52{instr_i[31]}}, {instr_i[31:25]}, {instr_i[11:7]} };
        pc_extend64_o <= 64'd0;
        end
    7'b1100011:begin    //beq
        signed_extend_o <= { {52{instr_i[31]}}, {instr_i[31]}, {instr_i[7]}, {instr_i[30:25]}, {instr_i[11:8]}};
        pc_extend64_o <= 64'd0;
        end
    7'b1101111:begin    //jal
        signed_extend_o <= { {52{instr_i[31]}}, {instr_i[19:12]}, {instr_i[20]}, {instr_i[30:21]}, {1'b0}};
        pc_extend64_o <= { {32{pc_i[31]}}, {pc_i[31:0]} };
        end
    endcase
end
          
endmodule      
     
