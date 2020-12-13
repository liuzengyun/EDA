module main(a,b,c,d,e,f,g,out);	// 模块定义
	input a,b,c,d,e,f,g;	// 输入
	output out;		// 输出，1：表决通过，0：表决不通过
	wire[2:0] sum;
	assign sum=a+b+c+d+e+f+g;
	assign out=sum[2]?1:0;
endmodule
