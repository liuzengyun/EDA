module main(ina,inb,out,out1,out2,out3,out4,out5,result1,result2,result3,result4,result5); 
    input[7:0] ina;
	input[7:0] inb;
    output reg[3:0] result1;
    output reg[3:0] result2;
    output reg[3:0] result3;
    output reg[3:0] result4;
    output reg[3:0] result5;
    output reg[15:0] out;
    output reg[6:0] out1;
    output reg[6:0] out2;
    output reg[6:0] out3;
    output reg[6:0] out4;
    output reg[6:0] out5;
    always@(ina,inb)
    begin
        out=ina*inb;	
        result1=out/10000;
        result2=out/1000%10;
        result3=out/100%10;
        result4=out/10%10;
        result5=out%10;
        
        if(out<=9)
            begin
                out1=7'b1111111;
                out2=7'b1111111;
                out3=7'b1111111;
                out4=7'b1111111;
                show(result5,out5);
            end
        else if(out<=99)
            begin
                out1=7'b1111111;
                out2=7'b1111111;
                out3=7'b1111111;
                show(result4,out4);
                show(result5,out5);
            end
        else if(out<=999)
            begin
                out1=7'b1111111;
                out2=7'b1111111;
                show(result3,out3);
                show(result4,out4);
                show(result5,out5);
            end
        else if(out<=9999)
            begin
                out1=7'b1111111;
                show(result2,out2);
                show(result3,out3);
                show(result4,out4);
                show(result5,out5);
            end
        else
            begin
                show(result1,out1);
                show(result2,out2);
                show(result3,out3);
                show(result4,out4);
                show(result5,out5);
            end
    end 

	task show;
        input integer result;
        output[6:0] out;
        if(result==0) out=7'b0111111; 
		  else if(result==1) out=7'b0000110;
		  else if(result==2) out=7'b1011011;
        else if(result==3) out=7'b1001111;
        else if(result==4) out=7'b1100110;
        else if(result==5) out=7'b1101101;
        else if(result==6) out=7'b1111101;
        else if(result==7) out=7'b0000111;
        else if(result==8) out=7'b1111111;
        else if(result==9) out=7'b1100111;
        else out=7'b1111111;   
    endtask
endmodule 