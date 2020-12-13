module main(clk50,clr,clk1,key0,key1,out0,out1,out2,out3,out4);
    input clk50,clr,key0,key1;
    output clk1;
    output reg [6:0] out0;  // 输出到7段管的信号
    output reg [6:0] out1;  // 输出到7段管的信号
    output reg [6:0] out2;  // 输出到7段管的信号
    output reg [6:0] out3;  // 输出到7段管的信号
    output reg [6:0] out4;  // 输出到7段管的信号

    reg [1:0] state=0;   
    reg [2:0] S=3'b000;     // 状态，'HELLO' 'ELLOH' 'LLOHE' 'LOHEL' 'OHELL'
    integer i=0;      

    clk50mto1 dc(clk50,clk1); 

    always@(posedge clr,posedge key0,posedge key1)
        begin
            if(clr)       state=0; 
            else if(key0) state=0; 
            else if(key1) state=1; 
        end

    always @(posedge clk1,posedge clr)
        begin
            if(clr) // 复位
                S=3'b000;
            else
                begin
                    if(state)   
                        begin
                            if(i==3)  
                                begin
                                    i=0;
                                    case(S)
                                        3'b000: S<=3'b001;  // 'HELLO'->'ELLOH'
                                        3'b001: S<=3'b010;  // 'ELLOH'->'LLOHE'
                                        3'b010: S<=3'b011;  // 'LLOHE'->'LOHEL'
                                        3'b011: S<=3'b100;  // 'LOHEL'->'OHELL'
                                        3'b100: S<=3'b000;  // 'OHELL'->'HELLO'
                                        default:S<=3'b000;  // 'HELLO'
                                    endcase
                                end 
                            else
                                i=i+1;
                        end  
                    else    
                        begin
                            case(S)
                                3'b000: S<=3'b001;  // 'HELLO'->'ELLOH'
                                3'b001: S<=3'b010;  // 'ELLOH'->'LLOHE'
                                3'b010: S<=3'b011;  // 'LLOHE'->'LOHEL'
                                3'b011: S<=3'b100;  // 'LOHEL'->'OHELL'
                                3'b100: S<=3'b000;  // 'OHELL'->'HELLO'
                                default:S<=3'b000;  // 'HELLO'
                            endcase
                        end 
                end
        end

    always@(S)
        begin
            case(S) 
                3'b000:
                    begin
                        out0=7'b0001001;  
                        out1=7'b0000110;  
                        out2=7'b1000111;  
                        out3=7'b1000111;  
                        out4=7'b1000000;  
                    end
                3'b001: 
                    begin
                        out0=7'b0000110;  
                        out1=7'b1000111;  
                        out2=7'b1000111;  
                        out3=7'b1000000;  
                        out4=7'b0001001;  
                    end
                3'b010: 
                    begin
                        out0=7'b1000111;  
                        out1=7'b1000111;  
                        out2=7'b1000000;  
                        out3=7'b0001001;  
                        out4=7'b0000110;  
                    end
                3'b011: 
                    begin
                        out0=7'b1000111;  
                        out1=7'b1000000;  
                        out2=7'b0001001;  
                        out3=7'b0000110;  
                        out4=7'b1000111;  
                    end
                3'b100: 
                    begin
                        out0=7'b1000000;  
                        out1=7'b0001001;  
                        out2=7'b0000110;  
                        out3=7'b1000111;  
                        out4=7'b1000111;  
                    end
                default:
                    begin
                        out0=7'b0001001;  
                        out1=7'b0000110;  
                        out2=7'b1000111;  
                        out3=7'b1000111;  
                        out4=7'b1000000;  
                    end
            endcase
        end  

endmodule

module clk50mto1(clk50,clk1); 
    input clk50;                
    output reg clk1=1;          
    integer i=0;                
    always@(posedge clk50)      
        begin 
            if(i==25000000)     
                begin 
                    i=0;        
                    clk1=~clk1; 
                end 
            else i=i+1; 
        end 
endmodule 