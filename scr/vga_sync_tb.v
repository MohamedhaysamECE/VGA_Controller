`timescale 1ns / 1ps


module vga_sync_tb();
     reg clk;
     wire [9:0] pixel_x,pixel_y;
     wire video_on,vsync,hsync;
     
 // instance ov vga_sync
 vga_sync v0(
           .clk(clk),
           .pixel_x(pixel_x),.pixel_y(pixel_y),
           .video_on(video_on),.vsync(vsync),.hsync(hsync) 
             );
       
 // generte clock with frequency 25MHZ ==> period 40ns 
  
 always #20 clk = ~clk;
 
initial
 begin
  clk = 0;
  #20E6 $stop; 
 end
   
endmodule 