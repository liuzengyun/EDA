module lab2(hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7,key,ledr,ledg,clk_50);
    input clk_50;//50MHz时钟
    input[3:0] key;//四个按键
    output reg[6:0] hex0,hex1,hex2,hex3,hex4,hex5,hex6,hex7;//七个数码管输出
    output reg[17:0] ledr=18'b000000000000000000;//红灯，初始化为灭
    output reg[8:0] ledg=9'b000000000;//绿灯，初始化为灭
    reg[8:0] ztimer=0,ntimer=0;//计时器，控制灯亮的时间
    reg[9:0] hour=0,minute=0,second=0,nhour=11,nminute=11,nsecond=11,th=0,tm=0,ts=0;//计时器和闹钟的时分秒
    reg[5:0] state=0,zstate=0,nstate=0,temp=0,t1,t2,t3,t4,t5,t6;//1、切换时钟与闹钟 2、切换时钟调整时的时分秒  3、切换闹钟调整时的时分秒

    divclk dc(clk_50,clk1);//

    always@(negedge key[2])//改state
        begin
            state=(state+1)%2;
        end


    always@(negedge key[1])//改zstate和nstate
        begin
            temp=state;
            if(temp==0)//如果在计时状态
                begin
                    zstate=(zstate+1)%4;
                end
            else//闹钟状态
                begin
                    nstate=(nstate+1)%4;
                end
        end


    always@(negedge key[0])//增加
        begin
            t4=state;
            t5=zstate;
            t6=nstate;
            th=hour;
            tm=minute;
            ts=second;
            if(t4==0)//如果在计时状态
                begin
                    if(t5==1)
                        begin
                            if(th==23) th=0;
                            else th=th+1;
                        end
                    if(t5==2)
                        begin
                            if(tm==59) tm=0;
                            else tm=tm+1;
                        end
                    if(t5==3)
                        begin
                            if(ts==59) ts=0;
                            else ts=ts+1;
                        end
                end
            else//闹钟状态
                begin
                    if(t6==1)
                        begin
                            if(nhour==23) nhour=0;
                            else nhour=nhour+1;
                        end
                    if(t6==2)
                        begin
                            if(nminute==59) nminute=0;
                            else nminute=nminute+1;
                        end
                    if(t6==3)
                        begin
                            if(nsecond==59) nsecond=0;
                            else nsecond=nsecond+1;
                        end
                end
        end




    always@(posedge clk1,negedge key[3])
        begin
            t1=state;
            t2=zstate;
            t3=nstate;
            if(!key[3])//按下置零
                begin
                    hour=0;
                    minute=0;
                    second=0;
                    show(hour/10,hex7);
                    show(hour%10,hex6);
                    show(minute/10,hex5);
                    show(minute%10,hex4);
                    show(second/10,hex3);
                    show(second%10,hex2);
                    show(10,hex1);
                    show(zstate+12,hex0);
                end
            else//clk1来了
                begin
                    if(t1==0)
                        begin
                            if(t2==0)
                                begin
                                    //下面是正常的计时
                                    if(second==59)
                                        begin
                                            second=0;
                                            if(minute==59)
                                                begin
                                                    minute=0;
                                                    if(hour==23) hour=0;
                                                    else hour=hour+1;
                                                end
                                            else minute=minute+1;
                                        end
                                    else
                                        begin
                                            second=second+1;
                                        end
                                    show(hour/10,hex7);
                                    show(hour%10,hex6);
                                    show(minute/10,hex5);
                                    show(minute%10,hex4);
                                    show(second/10,hex3);
                                    show(second%10,hex2);
                                    show(10,hex1);
                                    show(12,hex0);
                                    //以上是正常的计时,以下是报时和闹钟
                                    if(minute==0&&second==0) ztimer=59;
                                    else ztimer=0;
                                    if(hour==nhour&&minute==nminute&&second==nsecond) ntimer=59;
                                    else ntimer=0;
                                    if(ztimer>0)
                                        begin
                                            ledr=18'b111111111111111111;//亮红灯 
                                            ztimer=ztimer-1;
                                        end
                                    else    ledr=18'b000000000000000000;//关红灯
                                    if(ntimer>0)
                                        begin
                                            ledg=9'b111111111;//亮绿灯 
                                            ntimer=ntimer-1;
                                        end
                                    else    ledg=9'b000000000;
                                end
                            else if(t2==1)
                                begin
                                    hour=th;
                                    show(hour/10,hex7);
                                    show(hour%10,hex6);
                                    show(minute/10,hex5);
                                    show(minute%10,hex4);
                                    show(second/10,hex3);
                                    show(second%10,hex2);
                                    show(10,hex1);
                                    show(t2+12,hex0);
                                end
                            else if(t2==2)
                                begin
                                    minute=tm;
                                    show(hour/10,hex7);
                                    show(hour%10,hex6);
                                    show(minute/10,hex5);
                                    show(minute%10,hex4);
                                    show(second/10,hex3);
                                    show(second%10,hex2);
                                    show(10,hex1);
                                    show(t2+12,hex0);
                                end
                            else if(t2==3)
                                begin
                                    second=ts;
                                    show(hour/10,hex7);
                                    show(hour%10,hex6);
                                    show(minute/10,hex5);
                                    show(minute%10,hex4);
                                    show(second/10,hex3);
                                    show(second%10,hex2);
                                    show(10,hex1);
                                    show(t2+12,hex0);
                                end
                        end
                    else if(t1==1)
                        begin
                            show(nhour/10,hex7);
                            show(nhour%10,hex6);
                            show(nminute/10,hex5);
                            show(nminute%10,hex4);
                            show(nsecond/10,hex3);
                            show(nsecond%10,hex2);
                            show(11,hex1);
                            show(nstate+12,hex0);
                        end
                end

        end

    task show;
        input reg[3:0] result;			
        output reg[6:0] out;				
        if(result==0) 	 out=7'b1000000;	// 显示0
        else if(result==1) out=7'b1111001;	// 显示1
        else if(result==2) out=7'b0100100;	// 显示2
        else if(result==3) out=7'b0110000;	// 显示3
        else if(result==4) out=7'b0011001;	// 显示4
        else if(result==5) out=7'b0010010;	// 显示5
        else if(result==6) out=7'b0000010;	// 显示6
        else if(result==7) out=7'b1111000;	// 显示7
        else if(result==8) out=7'b0000000;	// 显示8
        else if(result==9) out=7'b0011000;	// 显示9
        else if(result==10)out=7'b0111111;	// 显示-
        else if(result==11)out=7'b1110110;	// 显示=
        else if(result==12)out=7'b1111111;	// 显示“  ”
        else if(result==13)out=7'b0001001;	// 显示H
        else if(result==14)out=7'b0001110;	// 显示F
        else if(result==15)out=7'b0010010;	// 显示S
        else 			 out=7'b1111111;	// 不显示
    endtask

endmodule

module divclk(clk_50,clk1); 
    input clk_50;		// clk50：输入50MHz信号；reset：复位信号 
    output reg clk1=1;	 // clk1：新产生的1Hz信号 
    integer i=0;			 
    always@(posedge clk_50) 
        begin 
            if(i==25000000) 
                begin 
                    i=0; 
                    clk1=~clk1;
                end 
            else i=i+1; 
        end 
endmodule 