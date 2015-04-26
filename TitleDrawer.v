`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:51:13 04/23/2015 
// Design Name: 
// Module Name:    Pong 
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
module TitleDrawer(
input clock,
input reset,
input ready,
input [15:0] data,
output reg [15:0] address,
output reg [7:0] dataout,
output finish,
output reg sendready
    );
	 reg [7:0] datasend;
	 reg[3:0] pstate;
	 reg[3:0] nstate;
 always@(posedge clock)
	 begin
	 if(reset) pstate<=0;
	 else  	  pstate<=nstate;
	 end
//-----datasend
 reg setdata1;
 reg setdata2;
 always@(posedge clock)
	 begin
	 if(reset) senddata<=0;
	 else if(setdata1) senddata<=data[7:0];
	 else if(setdata2) senddata<=data[15:8];
	 end
//-----dataout
 reg setdatasend;
 always@(posedge clock)
	 begin
	 if(reset) dataout<=0;
	 else if(setdatasend) dataout<=senddata;
	 end
//-----sendready
 reg setready;
 always@(posedge clock)
	 begin
	 if(reset) sendready<=0;
	 else if(setready) sendready<=1;
	 end
//-----address
reg addaddress;
always@(posedge clock)
	 begin
	 if(reset)address<=0;
	 else if(addaddress) address<=address+1;
	 end
//--------------
 always@(*)
    begin
	 setready=0;
	 setdata1=0;
	 setdata2=0;
	 setdatasend=0;
	 case(pstate)
	 0: nstate=1;
	 1: nstate=2;
	 2: begin
		 setdata1=1;
		 setready=0;
		 nstate=3;
		 end
	 3: begin
		 setdatasend=1;
		 setready=1;
		 nstate=4;
		 end
	 4: if(ready==1) nstate=5;
	    else nstate=4;
	 5: begin
		 setdata2=1;
		 setready=0;
		 nstate=6;
		 end
	 6: begin
		 setdatasend=1;
		 setready=1;
		 nstate=7;
		 end
	 7: if(ready==1) nstate=8;
	    else nstate=7;	
	 8: begin
		 addaddress<=1;
		 nstate=9;
	    end
	 9: nstate=9;
	 endcase
	 end
assign senddata= (pstate==8);
endmodule