`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:54:09 03/28/2016 
// Design Name: 
// Module Name:    nor_cell 
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
module nor_cell(output [11:0] prtprod,
					 input [11:0] shifted,
					 input rst);
					 
assign prtprod = ~(shifted | {12{rst}});					 

endmodule
