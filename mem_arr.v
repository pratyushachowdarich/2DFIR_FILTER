`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:28:23 03/28/2016 
// Design Name: 
// Module Name:    mem_arr 
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
module mem_arr(output reg [11:0] memwrd0,
					output reg [11:0] memwrd1,
					input [7:0] address0,
					input [7:0] address1,
					input [7:0] h);

reg [11:0] memory [7:0];
parameter z = 1'b0;
wire [11:0] a = {h[7],{4{z}},h[6:0]};

initial begin
	memory[0]= ~ a;
	memory[1]= ~(3 * a);
	memory[2]= ~(5 * a);
	memory[3]= ~(7 * a);
	memory[4]= ~(9 * a);
	memory[5]= ~(11 * a);
	memory[6]= ~(13 * a);
	memory[7]= ~(15 * a);
end

always @(*) begin
	case (address1)
		1: memwrd1=memory[0];
		2: memwrd1=memory[1];
		4: memwrd1=memory[2];
		8: memwrd1=memory[3];
		16: memwrd1=memory[4];
		32: memwrd1=memory[5];
		64: memwrd1=memory[6];
		128: memwrd1=memory[7];
		default: memwrd1=0;
	endcase
	
	case (address0)
		1: memwrd0=memory[0];
		2: memwrd0=memory[1];
		4: memwrd0=memory[2];
		8: memwrd0=memory[3];
		16: memwrd0=memory[4];
		32: memwrd0=memory[5];
		64: memwrd0=memory[6];
		128: memwrd0=memory[7];
		default: memwrd0=0;
	endcase
end	

endmodule
