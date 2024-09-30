`timescale 1ns / 1ps

module tb();

wire [4:0]i_NS_count;
wire [3:0]i_EW_count;
wire [1:0]yellow_count;
reg CLK;
wire NS_red;   
wire NS_green; 
wire NS_yellow;
wire EW_red;   
wire EW_green; 
wire EW_yellow; 
reg NS_vehicle_detect;
reg EW_vehicle_detect;

initial begin
    CLK = 1'b0;
    NS_vehicle_detect = 1'b0;
    EW_vehicle_detect = 1'b0;
    
    $display("    NS    |    EW    ");
    $display("  R  G  Y   R  G  Y  ");
    $monitor("  %h  %h  %h  %h  %h  %h  ", NS_red , NS_green , NS_yellow , EW_red , EW_green , EW_yellow);
    
   #1000 $finish();
end

always
    #5 CLK = ~CLK;
    
always@(CLK)begin
    if($time % 21 == 0)begin
        NS_vehicle_detect = ~NS_vehicle_detect;
        EW_vehicle_detect = ~EW_vehicle_detect;
    end
end
 
design_tc CORE(
        .i_NS_count(i_NS_count),       
        .i_EW_count(i_EW_count),       
        .yellow_count(yellow_count),     
        .NS_vehicle_detect(NS_vehicle_detect),
        .EW_vehicle_detect(EW_vehicle_detect),
        
        .NS_red(NS_red),  
        .NS_green(NS_green),
        .NS_yellow(NS_yellow),
        .EW_red(EW_red),  
        .EW_green(EW_green),
        .EW_yellow(EW_yellow)
);

NS_Count  i_NS_count_0(
.i_clk (CLK),
.o_count (i_NS_count)
);

EW_Count  i_EW_count_0(
.i_clk (CLK),
.o_count (i_EW_count)
);

yellow_counter  i_yellow_count_0(
.i_clk (CLK),
.o_count (yellow_count)
);
endmodule
