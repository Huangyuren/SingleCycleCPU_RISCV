`timescale 1ns/1ps

module alu_last(
            src1, 
            src2,
            less, 
            A_invert,
            B_invert,
            cin,
            operation,
            result,
            cout,
            set,  //SLT
            overflow
            );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;            
input [2-1:0] operation;

output  reg result;
output  reg cout;
output      set;
output      overflow;

wire        set;
wire        overflow;

reg s1, s2;
reg done;

assign overflow = cin ^ cout;
assign set = (~overflow & (s1 ^ s2 ^ cin)) ? 1: (s1 & s2) ? 1: 0;

always@( * )begin

    done = 0;

    if(done == 0)begin
        if (A_invert) s1 = ~src1;   else s1 = src1;
        if (B_invert) s2 = ~src2;   else s2 = src2;

        case (operation)
            2'b00:begin//and
                result = s1 & s2;
                cout = 0;
                end
            2'b01:begin//or
                result = s1 | s2;
                cout = 0;
                end
            2'b10:begin//add
                result = s1 ^ s2 ^ cin;
                cout = (s1 & s2) + (s1 & cin) + (s2 & cin);
                end
            2'b11:begin//less
                result = less;
                cout = (s1 & s2) + (s1 & cin) + (s2 & cin);
                end
        endcase
        done = 1;
        $display(" Overflow: %b    Set: %b    cout: %b\n", overflow, set, cout);
    end
    else begin
        result = result;
        cout = cout;
    end

end

endmodule
