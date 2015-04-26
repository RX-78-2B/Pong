`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:05:08 04/10/2015 
// Design Name: 
// Module Name:    ProjectPon_VCentury 
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
module pong(
    input CLK,
    input IN_PB_RESET,
    input IN_SERIAL_RX,
    output OUT_SERIAL_TX,
	output OUT_LED,
	output OUT_BUZZER
    );
	
	wire RESET;
	assign RESET = ~IN_PB_RESET;
	
	/*
	* Serial interface
	*/
	wire BCLK;
	bounderClock BC(CLK, RESET, BCLK);
	
	wire [7:0] rxData;
	wire rxReady;
	Receiver rec(BCLK, RESET, IN_SERIAL_RX, rxData, rxReady);
	
	wire [7:0] txData;
	wire txSend;
	wire txReady;
	Messenger mes(BCLK, RESET, txData, txSend, OUT_SERIAL_TX, txReady);
	
	wire ramEnable;
	wire ramWrite;
	wire [15:0] ramAddr;
	wire [15:0] ramDataR;
	wire [15:0] ramDataW;
	RAM ram(CLK, ramEnable, ramWrite, ramAddr, ramDataR, ramDataW);
	
   TitleDrawer title(CLK,RESET,rxReady,ramDataR,ramAddr,txData,titlefinish,txSend);
endmodule
