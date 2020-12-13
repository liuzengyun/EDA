module main(clk50,clk1,key,button_add,button_state,out0,out1,out2,out3,out4,out5);
    input clk50; 			// clk50：输入50MHz信号；reset：复位信号 
    input key;		 //翻转信号 1：左移  0：右移
    input button_add,button_state; //增加按钮和状态按钮
    output wire clk1;	 // clk1：新产生的1Hz信号 
    output reg[6:0] out0=7'b0000000;  //初始化不显示
    output reg[6:0] out1=7'b0000000;  //不显示
    output reg[6:0] out2=7'b0000000;  //不显示
    output reg[6:0] out3=7'b0000000;  //不显示
    output reg[6:0] out4=7'b0000000;  //不显示
    output reg[6:0] out5=7'b0000000;  //不显示

    reg[4:0] hour=0;
    reg[5:0] minutes=0;
    reg[5:0] seconds=0;
    reg[2:0] state=0;
    //模块调用
    div_clk dc(clk50,clk1);  //产生clk1（即频率为1Hz的数字信号）
    always@(posedge button_state,posedge key) 
        begin 
            if(key) 
                begin
                    state=0; 
                end
            else state=(state+1)%4; 
        end
 
    always@(posedge clk1,posedge key)  //在测试时，此处clk1变为clk50
        begin
            if(key)
                begin
                    hour=0; 
                    minutes=0;
                    seconds=0;
                    out0=7'b0111111;  //显示为0
                    out1=7'b0111111;  
                    out2=7'b0111111;  
                    out3=7'b0111111;  
                    out4=7'b0111111;  
                    out5=7'b0111111;
                end
            else
                begin
                    if(state==1)//调整秒位
                        begin
                            if(button_add)  //增加秒位
                                begin
                                    if(seconds<59)  seconds=seconds+1;
                                    else  
                                        begin
                                            if(seconds==59) 
                                                begin
                                                    seconds=0;
                                                end
                                        end
                                end
                        end
                    else if(state==2)//调整分位
                        begin
                            if(button_add) 
                                begin
                                    if(minutes<59)  minutes=minutes+1;
                                    else
                                        begin
                                            if(minutes==59)
                                                begin
                                                    minutes=0;
                                                end
                                        end
                                end
                        end
                    else if(state==3) //调整时位
                        begin
                            if(button_add)
                                begin
                                    if(hour<23) hour=hour+1;
                                    else
                                        begin 
                                            if(hour==23) hour=0;
                                        end
                                end
                        end
                    else   //确定调整结束,正常计数
                        begin
                            if(seconds==59) 
                                begin
                                    seconds=0;
                                    if(minutes<59)  minutes=minutes+1;
                                    else
                                        begin
                                            if(minutes==59)
                                                begin
                                                    minutes=0;
                                                    if(hour<23) hour=hour+1;
                                                    else
                                                        begin
                                                            if(hour==23) hour=0;
                                                        end
                                                end
                                        end
                                end
										 else
											seconds=seconds+1;
                        end

                    trans(hour/10,out0);
                    trans(hour%10,out1);
                    trans(minutes/10,out2);
                    trans(minutes%10,out3);
                    trans(seconds/10,out4);
                    trans(seconds%10,out5);   

                end    

        end


    task trans;  //定义转换函数
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
        else out=7'b0000000;   
    endtask


endmodule

// 分频电路，将50MHz转化成1Hz
module div_clk(clk50,clk); 
    input clk50;		// clk50：输入50MHz信号；reset：复位信号 
    output reg clk=1;	 // clk1：新产生的1Hz信号 
    integer i=0;			 
    always@(posedge clk50) 
        begin 
            if(i==25000000) 
                begin 
                    i=0; 
                    clk=~clk;
                end 
            else i=i+1; 
        end 
endmodule 