module main(in,out);
    input [7:0] in;				// 8路输入，高电平1为有效电平
    output reg[6:0] out;			// 7路输出，用于七段管十进制数的显示
    always@(in)
        begin
            if(in[7])				// 第7路输入
            out=7'b1111000;	// 七段管显示7
            else if(in[6])			// 第6路输入
        		out=7'b0000010; 	// 七段管显示6
            else if(in[5])			// 第5路输入
        		out=7'b0010010;  	// 七段管显示5
            else if(in[4])			// 第4路输入
                out=7'b0011001;  	// 七段管显示4
            else if(in[3])			// 第3路输入
                out=7'b0110000;	// 七段管显示3
            else if(in[2])			// 第2路输入
                out=7'b0100100;	// 七段管显示2
            else if(in[1])			// 第1路输入
                out=7'b1111001;	// 七段管显示1
            else if(in[0])			// 第0路输入
                out=7'b1000000;	// 七段管显示0
    		   else					// 没有输入
                out=7'b1111111;	// 七段管不显示
        end
endmodule
