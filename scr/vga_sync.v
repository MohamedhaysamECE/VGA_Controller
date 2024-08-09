`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2024 05:12:29 PM
// Design Name: 
// Module Name: vga_sync
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


module vga_sync(
                input clk,
                output reg [9:0] pixel_x = 0,
                output reg [9:0] pixel_y = 0,
                output video_on,vsync,hsync 
                );
                
 // horizontal counter 
 always@(posedge clk)
    begin
        if(pixel_x == 10'd799)
            pixel_x <= 0; 
        else
            pixel_x <= pixel_x + 1;
            
    end 
      
 // vertical counter
 always@(posedge clk)
    begin
        if(pixel_x == 10'd799 )
            pixel_y <= pixel_y + 1;
        else if(pixel_y == 10'd524)
            pixel_y <= 0;
        else
            pixel_y <= pixel_y;     
    end
//applying hsync,vsyncand vido on signals

assign hsync = ((pixel_x < 656) || (pixel_x > 751))? 1'b1 : 1'b0;

assign vsync = ((pixel_y == 490 )||(pixel_y == 491 ))? 1'b0 : 1'b1;

assign video_on = ((pixel_x < 640) && (pixel_y < 480 ))? 1'b1 : 1'b0;

 endmodule
