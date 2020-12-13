module show1(in5,hex);
input[4:0] in5;
output reg[6:0] hex;
always@(in5)
begin
case(in5)
5'h0:hex=7'b1000000;//0
5'h1:hex=7'b1111001;//1
5'h2:hex=7'b0100100;
5'h3:hex=7'b0110000;
5'h4:hex=7'b0011001;
5'h5:hex=7'b0010010;
5'h6:hex=7'b0000010;
5'h7:hex=7'b1111000;
5'h8:hex=7'b0000000;
5'h9:hex=7'b0010000;
5'hA:hex=7'b0001000;
5'hB:hex=7'b0000011;
5'hC:hex=7'b1000110;
5'hD:hex=7'b0100001;
5'hE:hex=7'b0000110;
5'hF:hex=7'b0001110;//F
5'd17:hex=7'b0111111;//fuhao -
default:hex=7'b1111111;//in5>=16,则七段管不亮
endcase
end
endmodule
