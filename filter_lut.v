`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:22:20 04/02/2016 
// Design Name: 
// Module Name:    filter_lut 
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

// 4-tap FIR Filter

`include "encdec.v"
`include "ctrl_ckt.v"
`include "mem_arr.v"
`include "barrel_shift.v"
`include "nor_cell.v"
//`include "dualport_mult.v"

module filter_lut(output reg [11:0] filtop,
						input [7:0] x,
						input clk);

parameter h0=8'b10001111,		//-15
			 h1=8'b10001010,		//-10
			 h2=8'b00001001,		//9
			 h3=8'b00000101;		//5

parameter zero=4'b0000;

wire [7:0] address0,address1;
wire [11:0] m0_0,m0_1,m1_0,m1_1,m2_0,m2_1,m3_0,m3_1;
wire [11:0] yp0_0,yp0_1,yp1_0,yp1_1,yp2_0,yp2_1,yp3_0,yp3_1;
wire [11:0] yps0_0,yps0_1,yps1_0,yps1_1,yps2_0,yps2_1,yps3_0,yps3_1;
wire [11:0] y0,y1,y2,y3;
reg [11:0] y0_2s,y1_2s,y2_2s,y3_2s;
reg [11:0] ry1,ry2,ry3;
reg [11:0] ry1_2s,ry2_2s,ry3_2s;
wire s00,s01,s10,s11,rst0,rst1;

initial begin
	ry1=0;
	ry2=0;
	ry3=0;
	filtop=0;
	h0_2s=h0;
	h1_2s=h1;
	h2_2s=h2;
	h3_2s=h3;
	y0_2s=0;
	y1_2s=0;
	y2_2s=0;
	y3_2s=0;
end

reg [7:0] h0_2s,h1_2s,h2_2s,h3_2s; 

//Converting filter coefficients to 2's Compliment for easy viewing
always @ (*) begin
	if (h0[7]) h0_2s = {h0[7],{~h0_2s[6:0] +1}};
	
	if (h1[7]) h1_2s = {h1[7],{~h1_2s[6:0] +1}};
	if (h2[7]) h2_2s = {h2[7],{~h2_2s[6:0] +1}};
	if (h3[7]) h3_2s = {h3[7],{~h3_2s[6:0] +1}};
end


// Address encoder decoder for memory address
encdec encdec_0(address0,x[3:0]);
encdec encdec_1(address1,x[7:4]);


//Memory Array
mem_arr mem_blk_0(m0_0,m0_1,address0,address1,h0);
mem_arr mem_blk_1(m1_0,m1_1,address0,address1,h1);
mem_arr mem_blk_2(m2_0,m2_1,address0,address1,h2);
mem_arr mem_blk_3(m3_0,m3_1,address0,address1,h3);

// Control Signal Circuit
ctrl_ckt ctrl_ckt_0(s00,s01,rst0,x[3:0]);
ctrl_ckt ctrl_ckt_1(s10,s11,rst1,x[7:4]);


//Barrel Shifters
barrel_shift bs_0_0(yps0_0,m0_0,s00,s01);
barrel_shift bs_0_1(yps0_1,m0_1,s10,s11);

barrel_shift bs_1_0(yps1_0,m1_0,s00,s01);
barrel_shift bs_1_1(yps1_1,m1_1,s10,s11);

barrel_shift bs_2_0(yps2_0,m2_0,s00,s01);
barrel_shift bs_2_1(yps2_1,m2_1,s10,s11);

barrel_shift bs_3_0(yps3_0,m3_0,s00,s01);
barrel_shift bs_3_1(yps3_1,m3_1,s10,s11);


// NOR Cell Block
nor_cell nor_0_0(yp0_0,yps0_0,rst0);
nor_cell nor_0_1(yp0_1,yps0_1,rst1);

nor_cell nor_1_0(yp1_0,yps1_0,rst0);
nor_cell nor_1_1(yp1_1,yps1_1,rst1);

nor_cell nor_2_0(yp2_0,yps2_0,rst0);
nor_cell nor_2_1(yp2_1,yps2_1,rst1);

nor_cell nor_3_0(yp3_0,yps3_0,rst0);
nor_cell nor_3_1(yp3_1,yps3_1,rst1);


//Shift and addition for each multiplication
assign y0[11]=yp0_1[11] | yp0_0[11];
assign y0[10:0]={yp0_1[10:0],zero}+yp0_0[10:0];

assign y1[11]=yp1_1[11] | yp1_0[11];
assign y1[10:0]={yp1_1[10:0],zero}+yp1_0[10:0];

assign y2[11]=yp2_1[11] | yp2_0[11];
assign y2[10:0]={yp2_1[10:0],zero}+yp2_0[10:0];

assign y3[11]=yp3_1[11] |yp3_0[11];
assign y3[10:0]={yp3_1[10:0],zero}+yp3_0[10:0];


//Converting multiplier outputs to 2's Compliment for easy viewing
always @(*) begin
	if (y0[11]) y0_2s={y0[11],{~y0[10:0]+1}};
	else y0_2s=y0;
	if (y1[11]) y1_2s={y1[11],{~y1[10:0]+1}};
	else y1_2s=y1;
	if (y2[11]) y2_2s={y2[11],{~y2[10:0]+1}};
	else y2_2s=y2;
	if (y3[11]) y3_2s={y3[11],{~y3[10:0]+1}};
	else y3_2s=y3;
end

always @(posedge clk) begin
	ry3<=y3;
	
	if (ry3[11] != y2[11]) begin
		if (ry3[10:0]>y2[10:0]) begin
		ry2[10:0]<=ry3[10:0]+ ~(y2[10:0]) + 1;
		ry2[11]<=ry3[11];
		end	
		else if (ry3[10:0]<y2[10:0]) begin
		ry2[10:0]<= y2[10:0] + ~(ry3[10:0]) + 1;
		ry2[11]<=y2[11];
		end
	end
	else if (ry3[11] == y2[11]) begin
		ry2[10:0]<=ry3[10:0]+ y2[10:0];
		ry2[11]<=ry3[11];
	end
	
	if (ry2[11] != y1[11]) begin
		if (ry2[10:0]>y1[10:0]) begin
		ry1[10:0]<=ry2[10:0]+ ~(y1[10:0]) + 1;
		ry1[11]<=ry2[11];
		end	
		else if (ry2[10:0]<y1[10:0]) begin
		ry1[10:0]<= y1[10:0] + ~(ry2[10:0]) + 1;
		ry1[11]<=y1[11];
		end
	end
	else if (ry2[11] == y1[11]) begin
		ry1[10:0]<=ry2[10:0]+ y1[10:0];
		ry1[11]<=ry2[11];
	end	
		
end

always @(*) begin
	if (ry1[11] != y0[11]) begin
		if (ry1[10:0]>y0[10:0]) begin
		filtop[10:0]<=ry1[10:0]+ ~(y0[10:0]) + 1;
		filtop[11]<=ry1[11];
		end	
		else if (ry1[10:0]<y0[10:0]) begin
		filtop[10:0]<= y0[10:0] + ~(ry1[10:0]) + 1;
		filtop[11]<=y0[11];
	end
	end
	else if (ry1[11] == y0[11]) begin
		filtop[10:0]<=ry1[10:0]+ y0[10:0];
		filtop[11]<=ry1[11];
	end
end


//Converting Adder-Shifter outputs to 2's Compliment for easy viewing
always @(*) begin
	if (ry1[11]) ry1_2s={ry1[11],{~ry1[10:0]+1}};
	else ry1_2s=ry1;
	if (ry2[11]) ry2_2s={ry2[11],{~ry2[10:0]+1}};
	else ry2_2s=ry2;
	if (ry3[11]) ry3_2s={ry3[11],{~ry3[10:0]+1}};
	else ry3_2s=ry3;
end

endmodule

