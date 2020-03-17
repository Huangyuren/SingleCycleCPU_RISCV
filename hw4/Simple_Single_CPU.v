//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
`include "ProgramCounter.v"
`include "Instr_Memory.v"
`include "Data_Memory.v"
`include "Reg_File.v"
`include "Decoder.v"
`include "ALU_Ctrl.v"
`include "ALU.v"
`include "ALU_TA.v"
`include "Adder.v"
`include "Shift_Left_One_64.v"
`include "Imm_Gen.v"
`include "MUX_2to1.v"
// `include "Jal_reg.v"


module Simple_Single_CPU(
        clk_i,
		nrst_i
		);
		
//I/O port
input			clk_i;
input			nrst_i;  // negative reset

//Internal signals
wire    [32-1:0] adder_1_o;
wire    [32-1:0] adder_2_o;
wire    [32-1:0] mux_pc_o;
wire    [64-1:0] mux_alu_source_o;
wire    [64-1:0] mux_wb_o;      //will be dmemory output or alu result
wire    [64-1:0] wb_o;  //final write back to rd reg
wire    [32-1:0] pc_get;
wire    [32-1:0] instrMem_o;
// wire    [7-1:0] instr_ctrl;
// wire    [5-1:0] instr_read_1;
// wire    [5-1:0] instr_read_2;
// wire    [5-1:0] instr_write_reg;
wire    [64-1:0] reg_read_1_o;
wire    [64-1:0] reg_read_2_o;
wire    [64-1:0] dataMem_o;
// wire    [32-1:0] immGen_i;
wire    [64-1:0] immGen_o;
wire    [64-1:0] immGenPC_o;
wire    [64-1:0] shift_o;
// wire    [3-1:0] aluCtrl_funct3_i;
// wire    [7-1:0] aluCtrl_funct7_i;
wire    [4-1:0] aluCtrl_o;
wire    [64-1:0] alu_result;
wire    zeroSig;
wire    [2-1:0] aluOpSig;
wire    branchSig;
wire    memReadSig;
wire    mem2RegSig;
wire    memWriteSig;
wire    aluSrcSig;
wire    jalSig;
wire    regWriteSig;


// decoder


//create componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .nrst_i (nrst_i),     
	    .pc_in_i(mux_pc_o) ,   
	    .pc_out_o(pc_get) 
	    );

// adder for program counter
Adder Adder1(
        .src1_i(pc_get),     
	    .src2_i(32'd4),     
	    .sum_o(adder_1_o)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_get),  
	    .instr_o(instrMem_o)    
	    );

Reg_File Registers(
        .clk_i(clk_i),      
	    .nrst_i(nrst_i) ,     
        .RSaddr_i(instrMem_o[19:15]) ,  
        .RTaddr_i(instrMem_o[24:20]) ,  
        .RDaddr_i(instrMem_o[11:7]) ,  
        .RDdata_i(wb_o)  , 
        .RegWrite_i(regWriteSig),
        .RSdata_o(reg_read_1_o) ,  
        .RTdata_o(reg_read_2_o)   
        );
	
Decoder Decoder(
        .instr_op_i(instrMem_o[6:0]), 
	    .RegWrite_o(regWriteSig), 
	    .ALU_op_o(aluOpSig),   
	    .ALUSrc_o(aluSrcSig), 
		.Branch_o(branchSig),
		.MemRead_o(memReadSig),
		.MemWrite_o(memWriteSig),
		.MemtoReg_o(mem2RegSig),
                .Jal_o(jalSig)
	    );

ALU_Ctrl AC(
        .funct3_i(instrMem_o[14:12]),
		.funct7_i(instrMem_o[31:25]),		
        .ALUOp_i(aluOpSig),   
        .ALUCtrl_o(aluCtrl_o) 
        );
	
Imm_Gen IG(
    .instr_i(instrMem_o),
    .pc_i(adder_1_o),
    .signed_extend_o(immGen_o),
    .pc_extend64_o(immGenPC_o)
    );

MUX_2to1 #(.size(64)) Mux_WBSrc(
        .data0_i(mux_wb_o),
        .data1_i(immGenPC_o),
        .select_i(jalSig),
        .data_o(wb_o)
        );

MUX_2to1 #(.size(64)) Mux_ALUSrc(
        .data0_i(reg_read_2_o),
        .data1_i(immGen_o),
        .select_i(aluSrcSig),
        .data_o(mux_alu_source_o)
        );	
		
ALUTA ALU(
        .src1_i(reg_read_1_o),
	    .src2_i(mux_alu_source_o),
	    .ctrl_i(aluCtrl_o),
	    .result_o(alu_result),
		.zero_o(zeroSig)
	    );
	
Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(alu_result),
	.data_i(reg_read_2_o),
	.MemRead_i(memReadSig),
	.MemWrite_i(memWriteSig),
	.data_o(dataMem_o)
	);
	
Adder Adder2(
        .src1_i(pc_get),     
	    .src2_i(shift_o[31:0]),     
	    .sum_o(adder_2_o)      
	    );
		
Shift_Left_One_64 Shifter(
        .data_i(immGen_o),
        .data_o(shift_o)
        ); 		


		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(adder_1_o),
        .data1_i(adder_2_o),
        .select_i((branchSig && zeroSig) || jalSig),
        .data_o(mux_pc_o)
        );	

MUX_2to1 #(.size(64)) Mux_Write_Back(
        .data0_i(alu_result),
        .data1_i(dataMem_o),
        .select_i(mem2RegSig),
        .data_o(mux_wb_o)
        );	

endmodule
		  


