`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:37:59 03/28/2016 
// Design Name: 
// Module Name:    aoi_cell 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module aoi_cell(output out,
					 input inl,
					 input inr,
					 input sl,
					 input sr);
					 
assign out = ~((inl & sl) | (inr & sr));					 

endmodule
