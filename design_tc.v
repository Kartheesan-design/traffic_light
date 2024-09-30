`timescale 1ns / 1ps
module design_tc(

input wire [4:0] i_NS_count,
input wire [3:0] i_EW_count,
input wire [1:0] yellow_count,
input wire       NS_vehicle_detect,
input wire       EW_vehicle_detect,

output reg NS_red,
output reg NS_green,
output reg NS_yellow,
output reg EW_red,
output reg EW_green,
output reg EW_yellow
    );
    
    initial begin
    
    NS_red <= 1'b0;
    NS_yellow <= 1'b0;
    NS_green <= 1'b1;
    EW_red <= 1'b1;
    EW_yellow <= 1'b0;
    EW_green <= 1'b0;
    
    end
    
    always@(i_NS_count)begin
    
        if(i_NS_count == 31 & EW_vehicle_detect & NS_green)begin
            
            NS_red <= 1'b0;
            NS_yellow <= 1'b1;
            NS_green <= 1'b0;
            EW_red <= 1'b1;
            EW_yellow <= 1'b0;
            EW_green <= 1'b0;
            
         end
         
     end
     
    always@(i_EW_count)begin
    
        if(i_EW_count == 15 & NS_vehicle_detect & EW_green)begin
            
            NS_red <= 1'b1;
            NS_yellow <= 1'b0;
            NS_green <= 1'b0;
            EW_red <= 1'b0;
            EW_yellow <= 1'b1;
            EW_green <= 1'b0;
            
         end
         
     end
     
    always@(yellow_count)begin
    
        if(yellow_count == 3 & NS_yellow)begin
            
            NS_red <= 1'b1;
            NS_yellow <= 1'b0;
            NS_green <= 1'b0;
            EW_red <= 1'b0;
            EW_yellow <= 1'b0;
            EW_green <= 1'b1;
            
         end
         
    
        if(yellow_count == 3 & EW_yellow)begin
            
            NS_red <= 1'b0;
            NS_yellow <= 1'b0;
            NS_green <= 1'b1;
            EW_red <= 1'b1;
            EW_yellow <= 1'b0;
            EW_green <= 1'b0;
            
         end
         
     
     end
endmodule

module NS_Count(

input wire i_clk,
output reg [4:0] o_count
);

initial
    o_count = 0;
    
always@(negedge i_clk)
    o_count[0] <= ~o_count[0];

always@(negedge o_count[0])
    o_count[1] <= ~o_count[1];
    
always@(negedge o_count[1])
    o_count[2] <= ~o_count[2];
  
always@(negedge o_count[2])
    o_count[3] <= ~o_count[3];
  
always@(negedge o_count[3])
    o_count[4] <= ~o_count[4];
        
endmodule

module yellow_counter(

input wire i_clk,
output reg [1:0] o_count
);

initial
    o_count = 0;
    
always@(negedge i_clk)
    o_count[0] <= ~o_count[0];

always@(negedge o_count[0])
    o_count[1] <= ~o_count[1];
    
always@(negedge o_count[1])
    o_count[2] <= ~o_count[2];
  
always@(negedge o_count[2])
    o_count[3] <= ~o_count[3];
       
endmodule

module EW_Count(

input wire i_clk,
output reg [4:0] o_count
);

initial
    o_count = 0;
    
always@(negedge i_clk)
    o_count[0] <= ~o_count[0];

always@(negedge o_count[0])
    o_count[1] <= ~o_count[1];
        
endmodule
