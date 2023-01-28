`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:59:45 03/27/2016 
// Design Name: 
// Module Name:    encdec 
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
module encdec(output reg [7:0] address,
				  input [3:0] inp);


reg [2:0] enc;

always @(*) begin
	enc[0]= (~((~(inp[0] & inp[1])) & (~(inp[1] & inp[2])))) | ( ~((~(inp[2] & inp[3]))| inp[0]));
	enc[1]=  ~((~(inp[0] & inp[2])) & ((~(inp[1] & inp[3])) | inp[0]));
	enc[2]=  inp[0] & inp[3] ;

	case (enc)
	0: address=1;
	1: address=2;
	2: address=4;
	3: address=8;
	4: address=16;
	5: address=32;
	6: address=64;
	7: address=128;
	endcase
end
endmodule
