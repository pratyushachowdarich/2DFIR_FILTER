`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:44:31 04/03/2016
// Design Name:   filter_lut
// Module Name:   C:/XilinxWork/VLSIDSP/filter_lut/test_filter1.v
// Project Name:  filter_lut
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: filter_lut
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_filter1;

	// Inputs
	reg [7:0] x;
	reg clk;

	// Outputs
	wire [11:0] filtop;

	// Instantiate the Unit Under Test (UUT)
	filter_lut uut (
		.filtop(filtop), 
		.x(x), 
		.clk(clk)
	);


//Converting filter output to 2's Compliment for easy viewing
reg [11:0] out_2s;
always @(*) begin
	if (filtop[11]) out_2s={filtop[11],{~filtop[10:0]+1}};
	else out_2s=filtop;
	
end

	initial begin
		clk = 0;
		forever #10 clk=~clk;
	end
	
	initial begin
		// Initialize Inputs
		x = 0;
		

		// Add stimulus here
		#50	x=6;
		#20 	x=9;
      		#20 	x=0;
		#20 	x=2;
		#20 	x=11;
		#20 	x=36;
		#20 	x=21;
		#20 	x=2;
		#20 	x=1;
		#20 	x=15;
		#20 	x=18;
		
		

	end
      
endmodule

