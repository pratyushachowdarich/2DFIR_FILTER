`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:07:38 03/28/2016 
// Design Name: 
// Module Name:    barrel_shift 
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
`include "aoi_cell.v"

module barrel_shift(output [11:0] shifted,
						  input [11:0] toshift,
						  input s0,
						  input s1);


wire [11:0] mid;
wire s0b = ~s0;
wire s1b = ~s1;

assign shifted[11]=toshift[11];
aoi_cell aoi_0_10(mid[10],toshift[10],toshift[9],s0b,s0);
aoi_cell aoi_0_9(mid[9],toshift[9],toshift[8],s0b,s0);
aoi_cell aoi_0_8(mid[8],toshift[8],toshift[7],s0b,s0);
aoi_cell aoi_0_7(mid[7],toshift[7],toshift[6],s0b,s0);
aoi_cell aoi_0_6(mid[6],toshift[6],toshift[5],s0b,s0);
aoi_cell aoi_0_5(mid[5],toshift[5],toshift[4],s0b,s0);
aoi_cell aoi_0_4(mid[4],toshift[4],toshift[3],s0b,s0);
aoi_cell aoi_0_3(mid[3],toshift[3],toshift[2],s0b,s0);
aoi_cell aoi_0_2(mid[2],toshift[2],toshift[1],s0b,s0);
aoi_cell aoi_0_1(mid[1],toshift[1],toshift[0],s0b,s0);
aoi_cell aoi_0_0(mid[0],toshift[0],s0,s0b,s0);



aoi_cell aoi_1_10(shifted[10],mid[10],mid[8],s1b,s1);
aoi_cell aoi_1_9(shifted[9],mid[9],mid[7],s1b,s1);
aoi_cell aoi_1_8(shifted[8],mid[8],mid[6],s1b,s1);
aoi_cell aoi_1_7(shifted[7],mid[7],mid[5],s1b,s1);
aoi_cell aoi_1_6(shifted[6],mid[6],mid[4],s1b,s1);
aoi_cell aoi_1_5(shifted[5],mid[5],mid[3],s1b,s1);
aoi_cell aoi_1_4(shifted[4],mid[4],mid[2],s1b,s1);
aoi_cell aoi_1_3(shifted[3],mid[3],mid[1],s1b,s1);
aoi_cell aoi_1_2(shifted[2],mid[2],mid[0],s1b,s1);
aoi_cell aoi_1_1(shifted[1],mid[1],s1b,s1b,s1);
aoi_cell aoi_1_0(shifted[0],mid[0],s1b,s1b,s1);



endmodule
