`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:14:27 04/07/2015 
// Design Name: 
// Module Name:    KBDController 
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
module KBDController(
    input Clock,
    input reset,
	 input rfromGameLoop,
	 input [7:0] rx,
	 output reg isPressEnter,
	 output reg isp1R,
	 output reg isp1L,
	 output reg isp2R,
	 output reg isp2L
    );
	 reg[2:0] pstate;
	 reg[2:0] nstate;
	 //--------- ClickEnter
	 reg CEnter;
	 always@(posedge Clock)
	  begin
		if(reset||rfromGameLoop)
		  isPressEnter <=0;
		else if(CEnter==1) isPressEnter<=1;
	  end
	 //--------- ClickRightArrow
	 reg CRightArrow;
	  always@(posedge Clock)
	  begin
		if(reset||rfromGameLoop)
		  isp1R <=0;
		else if(CRightArrow==1) isp1R<=1;
	  end
	 //--------- ClickLeftArrow
	  reg CLeftArrow;
	  always@(posedge Clock)
	  begin
		if(reset||rfromGameLoop)
		  isp1L <=0;
		else if(CLeftArrow==1) isp1L<=1;
	  end
	 //--------- ClickX
	  reg ClickX;
	  always@(posedge Clock)
	  begin
		if(reset||rfromGameLoop)
		  isp2R <=0;
		else if(ClickX==1) isp2R<=1;
	  end
	  //--------- ClickZ
	  reg ClickZ;
	  always@(posedge Clock)
	  begin
		if(reset||rfromGameLoop)
		  isp2L <=0;
		else if(ClickZ==1) isp2L<=1;
	  end
	  always@(posedge Clock)
	  begin if(reset) pstate<=0;
	  else pstate<=nstate;
	  end
	  always@(*)
	  begin
	  case(pstate)
	  0: nstate=1;
	  1: if(rx==13) nstate=2;
		  else  if(rx==90) nstate=3;
		  else  if(rx==58) nstate=4;
		  else  if(rx==37) nstate=5;
		  else  if(rx==39) nstate=6;
		  else nstate=1;
	  2: begin
		  nstate=1;
		  CEnter=1;
		  end
	  3: begin
		  nstate=1;
		  ClickZ=1;
		  end
	  4: begin
		  nstate=1;
		  ClickX=1;
		  end
	  5: begin
		  nstate=1;
		  CLeftArrow=1;
		  end
	  6: begin
		  nstate=1;
		  CRightArrow=1;
		  end
	  endcase
	  end
endmodule
