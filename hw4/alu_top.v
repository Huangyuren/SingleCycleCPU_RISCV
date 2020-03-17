`timescale 1ns/1ps

module alu_top(
            src1_i, 
            src2_i,
            A_invert,
            B_invert,
            cin,
            operation,
            result_o,
            cout
            );

input         src1_i;
input         src2_i;
input         A_invert;
input         B_invert;
input         cin;            
input [2-1:0] operation;

output  reg result_o;
output  reg cout;

reg s1, s2;
reg done;

always@( * )begin

    done = 0;

    if(done == 0)begin
        if (A_invert) s1 = ~src1_i;   else s1 = src1_i;
        if (B_invert) s2 = ~src2_i;   else s2 = src2_i;

        case (operation)
            2'b00:begin//and
                result_o = s1 & s2;
                cout = 0;
                end
            2'b01:begin//or
                result_o = s1 | s2;
                cout = 0;
                end
            2'b10:begin//add
                result_o = s1 ^ s2 ^ cin;
                cout = (s1 & s2) + (s1 & cin) + (s2 & cin);
                end
        endcase
        done = 1;
    end
    else begin
        result_o = result_o;
        cout = cout;
    end

end

endmodule
