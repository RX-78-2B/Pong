//Hellooooo
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:04:34 03/28/2015 
// Design Name: 
// Module Name:    SerialTransmitter 
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
module Messenger(
	input  bounderClock,
    input reset,
    input [7:0] in_data,
    input in_send,
    output txbit,
	output OUT_STATUS_READY
    );


reg [4:0]  pState;
reg [4:0] nState;
reg [7:0] storage;
reg [3:0] i;
reg bitOut=1;
reg outStat;

// reg signal
reg clrbitOut;
reg sending;
reg clrOutStat;
reg isSending;
reg clrI;
reg incI;
reg clrSt;
reg loadSt;
reg beginSend;



assign txbit = bitOut;
assign OUT_STATUS_READY = outStat;

//datapath

//bitOut
always@(posedge bounderClock)
begin
	if(clrbitOut) bitOut<=1;
	else if(beginSend) bitOut<=0;
	else if(sending) bitOut<=storage[i];
end


//outStat
always@(posedge bounderClock)
begin
	if(clrOutStat) outStat<=0;
	else if(isSending) outStat<=1;
end

//I
always@(posedge bounderClock)
begin
	if(clrI) i<=0;
	else if(incI) i<=i+1;
end

//Storage
always@(posedge bounderClock)
begin
	if(clrSt) storage<=0;
	else if(loadSt) storage<=in_data;
end


//combinatorial
always@(*)
begin
	if(reset) pState=0;
	else pState=nState;
end



//controlunit
always@(*)
begin
clrbitOut=0;
sending=0;
clrOutStat=0;
isSending=0;
clrI=0;
incI=0;
clrSt=0;
loadSt=0;
beginSend=0;
case(pState)
0:begin
clrbitOut=1;
clrOutStat=1;
clrI=1;
clrSt=1;
nState=1;
end
1:begin
if(in_send) nState=2;
else nState=0;

end
2:begin
loadSt=1;
nState=7;
end
3:begin//ส่งครบ 8 ตัวรึยัง

if(i<=7)
nState=4;
else nState=5;
end
4:begin//เริ่มส่ง isSending คือ statOutให้เป็น 1  beginSending คือทำให้ tx เป็น 0 1 clock
isSending=1;
beginSending=1;
nState =8;
end
5:begin// stage สุดท้าย ส่งเสร็จ เคลีย statOut ให้เป็น0
clrOutStat=1;
nState=0;
end
6:begin // เพิ่ม i ไป 1
inc=1;
nState=7;
end

7:begin // ย้อนไปก่อน stage ว่าครบ 8 รึยัง
nState=3;
end

8:begin // ส่งหนึ่งบิตที่เก็บใน storage ไป
sending=1;
nState=6;
end
endcase
end


	//fill your code here
endmodule