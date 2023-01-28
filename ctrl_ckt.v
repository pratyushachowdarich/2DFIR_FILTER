`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:20:49 03/28/2016 
// Design Name: 
// Module Name:    ctrl_ckt 
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
module ctrl_ckt(output s0,
					 output s1,
					 output rst,
					 input [3:0] inp);

assign s0= ~((~(inp[1] | (~inp[2]))) | inp[0]);
assign s1= ~(inp[0] | inp[1]);
assign rst=  (~(inp[0] | inp[1])) & (~(inp[2] | inp[3])) ;

endmodule
