//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct3_i,
		  funct7_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [3-1:0] funct3_i;
input      [7-1:0] funct7_i;
input      [2-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter

//Select exact operation
always@( *  )begin
    $display("This is ALU Control, Your ALU OP input is: %b", ALUOp_i);
    if (ALUOp_i == 2'b10)begin
		$display("Function7 field: %b", funct7_i);
        case (funct7_i)
			7'b0000000:begin
                case (funct3_i)
                    3'b000:begin
                        ALUCtrl_o = 4'b0010;//add
                        $display("ALU_Ctrl = %b, add", ALUCtrl_o);
                        end
                    3'b111:begin
                        ALUCtrl_o = 4'b0000;//and
                        $display("ALU_Ctrl = %b, and", ALUCtrl_o);
                        end
                    3'b110:begin
                        ALUCtrl_o = 4'b0001;//or
                        $display("ALU_Ctrl = %b, or", ALUCtrl_o);
                        end
                    3'b010:begin
                        ALUCtrl_o = 4'b0111;//slt
                        $display("ALU_Ctrl = %b, slt", ALUCtrl_o);
                        end
            	endcase
			end
	    	7'b0100000:begin
                ALUCtrl_o = 4'b0110;//sub
                $display("ALU_Ctrl = %b, sub", ALUCtrl_o);
            end
        endcase
    end
    else if(ALUOp_i == 2'b00)begin
		$display("Function3 field: %b", funct3_i);
        case (funct3_i)
            3'b000:begin
                ALUCtrl_o = 4'b0010;//addi
                $display("ALU_Ctrl = %b, addi", ALUCtrl_o);
            end
            3'b010:begin
                ALUCtrl_o = 4'b0111;//slti
                $display("ALU_Ctrl = %b, slti", ALUCtrl_o);
            end
	        3'b011:begin
                ALUCtrl_o = 4'b0010;//ld & sd
                $display("ALU_Ctrl = %b, ld or sd", ALUCtrl_o);
            end
	    endcase
    end
    else begin
        ALUCtrl_o = 4'b0110;//beq
        $display("ALU OP input: %b, ALU_Ctrl = %d, beq", ALUOp_i, ALUCtrl_o);
    end
end
endmodule     





                    
                    
