module lab1(sw,hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7);
    input[17:0] sw;

    output[6:0] hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7;
    reg[4:0] h7,h6,h5,h4,h3,h2,h1,h0;
    reg[15:0] o1,o2,s;
    reg[17:0] sw0;


    always@(*)
        begin


            if(sw[3:0]>9) sw0[3:0]=9;
            else sw0[3:0]=sw[3:0];

            if(sw[7:4]>9) sw0[7:4]=9;
            else sw0[7:4]=sw[7:4];

            if(sw[11:8]>9) sw0[11:8]=9;
            else sw0[11:8]=sw[11:8];

            if(sw[15:12]>9) sw0[15:12]=9;
            else sw0[15:12]=sw[15:12];


            if(sw[17:16]==0)
                begin 
                    h7=16;
                    h6=16;
                    h5=16;
                    h0=sw[15:0]%10;
                    h1=sw[15:0]/10%10;
                    h2=sw[15:0]/100%10;
                    h3=sw[15:0]/1000%10;
                    h4=sw[15:0]/10000;
                    show(h0,hex0);
                    show(h1,hex1);
                    show(h2,hex2);
                    show(h3,hex3);
                    show(h4,hex4);
                end
            else if(sw[17:16]==1)
                begin  
                    o1=sw0[15:12]*10+sw0[11:8];
                    o2=sw0[7:4]*10+sw0[3:0];
                    s=o1+o2;
                    h7=sw0[15:12];
                    h6=sw0[11:8];
                    h5=sw0[7:4];
                    h0=s%10;
                    h1=s/10%10;
                    h2=s/100;
                    h3=16;
                    h4=sw0[3:0];
                    show(h0,hex0);
                    show(h1,hex1);
                    show(h2,hex2);
                    show(h3,hex3);
                    show(h4,hex4);
                    show(h5,hex5);
                    show(h6,hex6);
                    show(h7,hex7);
                end
            else if(sw[17:16]==2)
                begin  
                    o1=sw0[15:12]*10+sw0[11:8];
                    o2=sw0[7:4]*10+sw0[3:0];
                    s=o1*o2;
                    h7=sw0[15:12];
                    h6=sw0[11:8];
                    h5=sw0[7:4];
                    h0=s%10;
                    h1=s/10%10;
                    h2=s/100%10;
                    h3=s/1000%10;
                    h4=sw0[3:0];
                    show(h0,hex0);
                    show(h1,hex1);
                    show(h2,hex2);
                    show(h3,hex3);
                    show(h4,hex4);
                    show(h5,hex5);
                    show(h6,hex6);
                    show(h7,hex7);
                end
            else if(sw[17:16]==3)
                begin  
                    o1=sw0[15:12]*10+sw0[11:8];
                    o2=sw0[7:4]*10+sw0[3:0];
                    if(o1>=o2)
                        begin
                            s=o1-o2;
                            h7=sw0[15:12];
                            h6=sw0[11:8];
                            h5=sw0[7:4];
                            h0=s%10;
                            h1=s/10%10;
                            h2=s/100%10;
                            h3=16;
                            h4=sw0[3:0];
                            show(h0,hex0);
                            show(h1,hex1);
                            show(h2,hex2);
                            show(h3,hex3);
                            show(h4,hex4);
                            show(h5,hex5);
                            show(h6,hex6);
                            show(h7,hex7); 
                        end
                    else
                        begin
                            s=o2-o1;
                            h7=sw0[15:12];
                            h6=sw0[11:8];
                            h5=sw0[7:4];
                            h0=s%10;
                            h1=s/10%10;
                            h2=s/100%10;
                            h3=10;
                            h4=sw0[3:0];
                            show(h0,hex0);
                            show(h1,hex1);
                            show(h2,hex2);
                            show(h3,hex3);
                            show(h4,hex4);
                            show(h5,hex5);
                            show(h6,hex6);
                            show(h7,hex7); 
                        end

                end


        end


    task show;
        input reg[3:0] decc;				// 输入，无符号二进制数
        output reg[6:0] out;				// 输出，7位二进制数值
        if(decc==0) 	 out=7'b1000000;	// 七段管显示0
        else if(decc==1) out=7'b1111001;	// 七段管显示1
        else if(decc==2) out=7'b0100100;	// 七段管显示2
        else if(decc==3) out=7'b0110000;	// 七段管显示3
        else if(decc==4) out=7'b0011001;	// 七段管显示4
        else if(decc==5) out=7'b0010010;	// 七段管显示5
        else if(decc==6) out=7'b0000010;	// 七段管显示6
        else if(decc==7) out=7'b1111000;	// 七段管显示7
        else if(decc==8) out=7'b0000000;	// 七段管显示8
        else if(decc==9) out=7'b0011000;	// 七段管显示9
        else if(decc==10)out=7'b0111111;	// 七段管显示-
        else 			 out=7'b1111111;	// 七段管不显示
    endtask


endmodule






