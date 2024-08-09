`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/08/2024 10:01:41 AM
// Design Name: 
// Module Name: vga_top_module
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


module vga_top_module(input clk,
                      output reg [2:0] rgb,
                      output  vsync,hsync
                      );
                      
wire video_on;
wire [9:0] pixel_x,pixel_y;
wire [7:0] pixel_y_c;
wire [8:0] pixel_x_c;
wire [2:0] pixel;
wire [15:0] address;

assign pixel_x_c = pixel_x[9:1];
assign pixel_y_c = pixel_y[9:2];
assign address = pixel_y_c*240 + pixel_x_c;

vga_sync V30(      .clk(clk),
                 .pixel_x(pixel_x) ,
                 .pixel_y(pixel_y),
                 .video_on(video_on),.vsync(vsync),.hsync(hsync) 
                );


//ROM has the image
rom_data R1(
         .addr(address),
         .data(pixel)
               );

// pixel generator circuit                               
always@(*)
begin
if(~video_on)
 rgb <= 3'b000;
else
 rgb <= pixel;    
end

endmodule
