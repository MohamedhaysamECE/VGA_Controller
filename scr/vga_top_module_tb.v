`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/08/2024 02:44:29 PM
// Design Name: 
// Module Name: vga_top_module_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vga_top_module_tb();
reg clk;
wire [2:0]rgb;
wire vsync,hsync;

vga_top_module m1(.clk(clk),
               .rgb(rgb),
               .vsync(vsync),.hsync(hsync)
                      );
                      
 // generte clock with frequency 25MHZ ==> period 40ns 
                       
always #20 clk = ~clk;
 
initial
 begin
  clk = 0;
  #20E6 $stop; 
 end
                        
endmodule
