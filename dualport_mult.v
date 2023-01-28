`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:10:53 04/02/2016 
// Design Name: 
// Module Name:    dualport_mult 
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

`include "encdec.v"
`include "ctrl_ckt.v"
//`include "mem_arr.v"
`include "barrel_shift.v"
`include "nor_cell.v"


module dualport_mult(output [15:0] ax,
							output [7:0] address0,
							output [7:0] address1,
							input [11:0] memwrd0,
							input [11:0] memwrd1,
							input [7:0] x);


parameter zero=4'b0000;

//wire [7:0] address0,address1;
//wire [11:0] memwrd0,memwrd1,shifted0,shifted1,prtprod0,prtprod1;
wire [11:0] shifted0,shifted1,prtprod0,prtprod1;
wire s00,s01,s10,s11,rst0,rst1;

encdec encdec_1(address0,x[3:0]);
encdec encdec_2(address1,x[7:4]);

//mem_arr mem_arr_1(memwrd0,memwrd1,address0,address1);


ctrl_ckt ctrl_ckt_0(s00,s01,rst0,x[3:0]);
ctrl_ckt ctrl_ckt_1(s10,s11,rst1,x[7:4]);

barrel_shift barrel_shift_0(shifted0,memwrd0,s00,s01);
barrel_shift barrel_shift_1(shifted1,memwrd1,s10,s11);

nor_cell nor_cell_0(prtprod0,shifted0,rst0);
nor_cell nor_cell_1(prtprod1,shifted1,rst1);

assign ax={prtprod1,zero}+prtprod0;

endmodule

