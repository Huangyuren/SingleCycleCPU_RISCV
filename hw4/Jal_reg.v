module Jal_reg(
    clk_i,
	nrst_i,
    pc_source_i,
    RDaddr_i,
    JalSig
);

input           clk_i;
input           nrst_i;
input [32-1:0] pc_source_i;
input  [5-1:0]  RDaddr_i;
input           JalSig;

//Internal signals/registers           
reg  signed [32-1:0] REGISTER_BANK [0:32-1];     //32 word registers


always@( posedge clk_i )begin
    if(nrst_i == 0) begin
	    REGISTER_BANK[0]  <= 0; REGISTER_BANK[1]  <= 0; REGISTER_BANK[2]  <= 0; REGISTER_BANK[3]  <= 0;
	    REGISTER_BANK[4]  <= 0; REGISTER_BANK[5]  <= 0; REGISTER_BANK[6]  <= 0; REGISTER_BANK[7]  <= 0;
        REGISTER_BANK[8]  <= 0; REGISTER_BANK[9]  <= 0; REGISTER_BANK[10] <= 0; REGISTER_BANK[11] <= 0;
	    REGISTER_BANK[12] <= 0; REGISTER_BANK[13] <= 0; REGISTER_BANK[14] <= 0; REGISTER_BANK[15] <= 0;
        REGISTER_BANK[16] <= 0; REGISTER_BANK[17] <= 0; REGISTER_BANK[18] <= 0; REGISTER_BANK[19] <= 0;      
        REGISTER_BANK[20] <= 0; REGISTER_BANK[21] <= 0; REGISTER_BANK[22] <= 0; REGISTER_BANK[23] <= 0;
        REGISTER_BANK[24] <= 0; REGISTER_BANK[25] <= 0; REGISTER_BANK[26] <= 0; REGISTER_BANK[27] <= 0;
        REGISTER_BANK[28] <= 0; REGISTER_BANK[29] <= 0; REGISTER_BANK[30] <= 0; REGISTER_BANK[31] <= 0;
	end
    else begin
        if(JalSig) 
            REGISTER_BANK[RDaddr_i] <= pc_source_i;	
	end
end
endmodule