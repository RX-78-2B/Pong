`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:55:46 04/07/2015 
// Design Name: 
// Module Name:    BaudClockGenerator 
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
module bounderClock(
    input Clock,
    input reset,
    output reg bounderClock
    );
	
	parameter BAUD_RATE = 57600; // actual hardware baud rate
	parameter CLOCK_RATE = 25000000;
	parameter CLOCKS_WAIT = (CLOCK_RATE /BAUD_RATE) / 2;
	
	reg [15:0] counter;
	
	always @(posedge Clock) 
		begin
		if (reset) begin
			bounderClock <= 0;
			counter <= 0;
		end
		else if (counter >= CLOCKS_WAIT)
		begin
			counter <= 0;
			bounderClock <= ~bounderClock;
		end
		else begin
			counter <= counter + 1;
		end
	end

endmodule

