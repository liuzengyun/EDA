module divclk(clkin,clkout);
input clkin;
output reg clkout;
integer i;
always@(posedge clkin)
 if(i==24999999) 
 begin i<=0;clkout<=~clkout;end
else i<=i+1;


endmodule