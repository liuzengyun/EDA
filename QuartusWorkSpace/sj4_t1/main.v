module main(clk,clr,in,out0,out1,count0,count1);
    input clk;				
    input clr;				
    input in;				
    output reg[6:0] out0=0,out1=0;
    output reg[6:0] count0=0,count1=0;
    reg[2:0] state0=3'b000,state1=3'b000;		
    
    always@(posedge clk,posedge clr) 
        begin 
            if(clr) 
                begin
                    state0<=0;
                    state1<=0;
                end
            else
                begin
                    if(in)	
                        begin
                            state0<=3'b000;
                            case(state1)
                        	    3'b000: state1<=3'b001;
                        	    3'b001: state1<=3'b010;
                        	    3'b010: state1<=3'b011;
                        	    3'b011: 
                                	begin
                                        state1<=3'b100;
                                        count1=count1+1;
                                	end
                        	    3'b100:state1<=3'b001;
                        	    default: state1<=3'b000;
                            endcase
                        end
                    else
                        begin
                            state1<=3'b000;
                            case(state0)
                        	    3'b000: state0<=3'b001;
                        	    3'b001: state0<=3'b010;
                        	    3'b010: state0<=3'b011;
                        	    3'b011: 
                                	begin
                                        state0<=3'b100;
                                        count0=count0+1;
                                	end
                        	    3'b100:state0<=3'b001;
                        	    default: state0<=3'b000;
                            endcase
                        end
                end
        end
    always@(count0)
        begin
            show(count0,out0);
        end
    always@(count1)
        begin
            show(count1,out1);
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
