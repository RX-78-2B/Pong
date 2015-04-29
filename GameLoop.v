`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:11:34 04/30/2015 
// Design Name: 
// Module Name:    GameLoop 
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
module GameLoop(
input Clock,
input Reset,
input isEnter,
input isZ,
input isX,
input isLeft,
input isRight

    );
parameter paddleheight=2;
parameter paddleweight=10;
//---------------
reg[2:0] score1;
reg[2:0] score2;
reg [18:0] CounterX;
wire CounterXmaxed = (CounterX==400000);
always @(posedge clk)
if(CounterXmaxed)
  CounterX <= 0;
else
  CounterX <= CounterX + 1;
  //-----------------
reg [6:0] P1Position;
reg [6:0] P2Position;
