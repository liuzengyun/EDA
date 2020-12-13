module main(clk50,sw,clk1,out0,out1,out2,out3,out4,out5,out6,out7);
    input clk50,sw;
    output wire clk1;
    output reg[6:0] out0=7'b1110110;  //显示H
    output reg[6:0] out1=7'b1111001;  //显示E
    output reg[6:0] out2=7'b0111000;  //显示L
    output reg[6:0] out3=7'b0111000;  //显示L
    output reg[6:0] out4=7'b0111111;  //显示O
    output reg[6:0] out5=7'b0000000;  //不显示
    output reg[6:0] out6=7'b0000000;  //不显示
    output reg[6:0] out7=7'b0000000;  //不显示
    clk50mto1 test(clk50,clk1);
    always@(posedge clk1) 
        begin 
            if(sw)
                begin
                    out0<=out1;
                    out1<=out2;
                    out2<=out3;
                    out3<=out4;
                    out4<=out5;
                    out5<=out6;
                    out6<=out7;
                    out7<=out0;
                end
            else
                begin
                    out7<=out6;
                    out6<=out5;
                    out5<=out4;
                    out4<=out3;
                    out3<=out2;
                    out2<=out1;
                    out1<=out0;
                    out0<=out7;
                end
        end
endmodule

module clk50to1(clk50,clk1);
    input wire clk1;
    output reg clk1=1;
    integer i=0;
    always@(posedge clk50)
        begin
            if(i=25000000)
                begin
                   i=0;
                    clk1=~clk1;
                end
            else
                begin
                   i=i+1; 
                end
        end
    