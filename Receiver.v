`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:59:08 03/28/2015 
// Design Name: 
// Module Name:    SerialReceiver 
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
module Receiver(
	 input bounderClock,
	 input reset,
    input rxbit,
    output [7:0] dataout,
	output OUT_STATUS_READY
    );	
	reg [7:0] temp;
	reg resetTemp;
	reg keepTemp;
	reg [7:0] data;
	reg loadData;
	reg ready;
	reg resetData;
	reg [2:0] pstate = 0;
	reg [2:0] nstate= 0;
	reg [3:0] counter= 0;
	reg resetcounter=0;
	reg addcounter=0;
	always @(posedge bounderClock) 
	begin
		if (resetTemp)
			temp <= 0;
		else if (keepTemp)
			temp <= (temp >> 1) | (rxbit << 7);
	end
	always @(posedge bounderClock)
	begin
		if (resetData)
			data <= 0;
		else if (loadData)
			data <= temp;
	end
	always @(posedge bounderClock)
	begin
		if (resetcounter)
			counter <= 0;
		else if (addcounter)
			counter <= counter+1;
	end
	always @(posedge bounderClock)
	begin
		if (reset)
			pstate <= 0;
		else
			pstate <= nstate;
	end
	always@(*)
	begin
		resetTemp=0;
		resetData=0;
		loadData=0;
		keepTemp=0;
		ready=0;
		resetcounter=0;
		addcounter=0;
	case(pstate)
	0: begin
		resetTemp=1;
		resetData=1;
		keepTemp=0;
		ready=0;
		resetcounter=1;
		nstate=1;
		end
	1: begin
		resetTemp=0;
		resetcounter=1;
		nstate=2;
		end
	2: begin
		if(rxbit==0) nstate=3;
		else nstate=2;
		end
	3: begin
		loadData=0;
		ready=0;
		keepTemp=1;
		addcounter=1;
		if(counter>=8) nstate=4;
		else nstate=3;
		end
	4: begin
		loadData=1;
		ready=1;
		nstate=1;
		end
   endcase
	end
	assign dataout = data;
	assign OUT_STATUS_READY = ready;

endmodule
