module main(in,out1,out2,out3);
    input [7:0] in;      // 8路输入，高电平1为有效电平
    output reg[6:0] out1; //个位的数码管
    output reg[6:0] out2; // 十位的数码管
    output reg[6:0] out3; // 百位的数码管
    wire[3:0] bai;  
    wire[3:0] shi;  
    wire[3:0] ge;   
    
    assign ge=in%10;                     // 个位赋值
    assign shi=(in/10)%10;                // 十位赋值
    assign bai=in/100;                // 百位赋值
    
    always@(in)
        begin
            if(in<10)        
                begin
                    show(ge,out1);     // 第一个七段管 显示个位
                    out2=7'b1111111;        // 第二个七段管不显示
                    out3=7'b1111111;        // 第三个七段管不显示
                end
            else if(in<100)      
                begin
                    show(ge,out1);     // 第一个七段管 显示个位
                    show(shi,out2);     // 第二个七段管 显示十位
                    out3=7'b1111111;        // 第三个七段管不显示
                end
            else                
                begin
                    show(ge,out1);     // 第一个七段管 显示个位
                    show(shi,out2);     // 第二个七段管 显示十位
                    show(bai,out3); // 第三个七段管 显示百位
                end
        end
    
    task show;//参考周孟卿的代码
        input integer decc;                 // 输入，十进制数
        output reg[6:0] outt;               // 输出，7位二进制数值
        if(decc==0)      outt=7'b1000000;   // 七段管显示0
        else if(decc==1) outt=7'b1111001;   // 七段管显示1
        else if(decc==2) outt=7'b0100100;   // 七段管显示2
        else if(decc==3) outt=7'b0110000;   // 七段管显示3
        else if(decc==4) outt=7'b0011001;   // 七段管显示4
        else if(decc==5) outt=7'b0010010;   // 七段管显示5
        else if(decc==6) outt=7'b0000010;   // 七段管显示6
        else if(decc==7) outt=7'b1111000;   // 七段管显示7
        else if(decc==8) outt=7'b0000000;   // 七段管显示8
        else if(decc==9) outt=7'b0011000;   // 七段管显示9
        else             outt=7'b1111111;   // 七段管不显示
    endtask
    
endmodule