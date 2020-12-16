`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:15:38 12/14/2017 
// Design Name: 
// Module Name:    vgaBitChange 
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
// Date: 04/04/2020
// Author: Yue (Julien) Niu
// Description: Port from NEXYS3 to NEXYS4
//////////////////////////////////////////////////////////////////////////////////
module vga_bitchange(
	input wire F0, F1, F2, F3, F4, F5, F6, F7, F8, 
	input wire game,
	input wire P,
	input wire won,
	input wire tie,
	input wire reset,
	input clk,
	input bright,
	input button,
	input [9:0] hCount, vCount,
	output reg [11:0] rgb,
	output reg [15:0] score
   );
	
	parameter BLACK = 12'b0000_0000_0000;
	parameter WHITE = 12'b1111_1111_1111;
	parameter RED   = 12'b1111_0000_0000;
	parameter GREEN = 12'b0000_1111_0000;
	parameter BLUE = 12'b0000_0000_1111;

	wire bottom;
	wire top;
	wire left;
	wire right;
	wire TopLeft;
	wire TopMid;
	wire TopRight;
	wire MidLeft;
	wire Mid;
	wire MidRight;
	wire BottomLeft;
	wire BottomMid;
	wire BottomRight;
	
	reg played0;
	reg [11:0] c0;
	reg played1;
	reg [11:0] c1;
	reg played2;
	reg [11:0] c2;
	reg played3;
	reg [11:0] c3;
	reg played4;
	reg [11:0] c4;
	reg played5;
	reg [11:0] c5;
	reg played6;
	reg [11:0] c6;
	reg played7;
	reg [11:0] c7;
	reg played8;
	reg [11:0] c8;


	always@ (*)
     if((reset || won || tie)& !game)
        begin 
            played0 <= 0;
		    played1 <= 0;
		    played2 <= 0;
		    played3 <= 0;
		    played4 <= 0;
		    played5 <= 0;
		    played6 <= 0;
		    played7 <= 0;
		    played8 <= 0;      
        end
     else
     begin
     if (~bright)
		rgb = BLACK; // force black if not bright
	 else if (bottom == 1) //grid displayed in white colour
		rgb = WHITE;
	 else if (top == 1)
	    rgb = WHITE;
	 else if (left == 1)
	    rgb = WHITE;
	 else if (right == 1)
	    rgb = WHITE;
	 else if(TopLeft==1) //move tracker
        begin
            if(played0 == 0)
                begin
                    if(P == 0)
                        begin
                            rgb = GREEN;
                            c0 = GREEN;
                        end
                    else
                        begin
                            rgb = RED;
                            c0 = RED;
                        end
                    played0 = 1;
                end
           else
                rgb = c0;
        end
     else if(TopMid==1)
         begin
            if(played1 == 0)
                begin
                    if(P == 0)
                        begin
                            rgb = GREEN;
                            c1 = GREEN;
                        end
                    else
                        begin
                            rgb = RED;
                            c1 = RED;
                        end
                    played1 = 1;
                end
           else
                rgb = c1;
        end
     else if(TopRight==1)
         begin
            if(played2 == 0)
                begin
                    if(P == 0)
                        begin
                            rgb = GREEN;
                            c2 = GREEN;
                        end
                    else
                        begin
                            rgb = RED;
                            c2 = RED;
                        end
                    played2 = 1;
                end
           else
                rgb = c2;
        end
     else if(MidLeft==1)
         begin
            if(played3 ==0)
                begin
                    if(P == 0)
                        begin
                            rgb = GREEN;
                            c3 = GREEN;
                        end
                    else
                        begin
                            rgb = RED;
                            c3 = RED;
                        end
                    played3 = 1;
                end
           else
                rgb = c3;
        end
     else if(Mid==1)
         begin
            if(played4 ==0)
                begin
                    if(P == 0)
                        begin
                            rgb = GREEN;
                            c4 = GREEN;
                        end
                    else
                        begin
                            rgb = RED;
                            c4 = RED;
                        end
                    played4 = 1;
                end
           else
                rgb = c4;
        end
     else if(MidRight==1)
         begin
            if(played5 ==0)
                begin
                    if(P == 0)
                        begin
                            rgb = GREEN;
                            c5 = GREEN;
                        end
                    else
                        begin
                            rgb = RED;
                            c5 = RED;
                        end
                    played5 = 1;
                end
           else
                rgb = c5;
        end
     else if(BottomLeft==1)
         begin
            if(played6 ==0)
                begin
                    if(P == 0)
                        begin
                            rgb = GREEN;
                            c6 = GREEN;
                        end
                    else
                        begin
                            rgb = RED;
                            c6 = RED;
                        end
                    played6 = 1;
                end
           else
                rgb = c6;
        end
     else if(BottomMid==1)
         begin
            if(played7 ==0)
                begin
                    if(P == 0)
                        begin
                            rgb = GREEN;
                            c7 = GREEN;
                        end
                    else
                        begin
                            rgb = RED;
                            c7 = RED;
                        end
                    played7 = 1;
                end
           else
                rgb = c7;
        end
     else if(BottomRight==1)
         begin
            if(played8 ==0)
                begin
                    if(P == 0)
                        begin
                            rgb = GREEN;
                            c8 = GREEN;
                        end
                    else
                        begin
                            rgb = RED;
                            c8 = RED;
                        end
                    played8 = 1;
                end
           else
                rgb = c8;
        end
	 else
		rgb = BLACK; // background color
    end
	

    //write horitzonal and veritcal bars
	assign bottom = ((hCount >= 10'd0) && (hCount <= 10'd800)) && ((vCount >= 10'd345) && (vCount <= 10'd355)) ? 1 : 0;
    
    assign top = ((hCount >= 10'd0) && (hCount <= 10'd800)) && ((vCount >= 10'd165) && (vCount <= 10'd175)) ? 1 : 0;
    
    assign left = ((hCount >= 10'd340) && (hCount <= 10'd350)) && ((vCount >= 10'd0) && (vCount <= 10'd800)) ? 1 : 0;
    
    assign right = ((hCount >= 10'd560) && (hCount <= 10'd570)) && ((vCount >= 10'd0) && (vCount <= 10'd800)) ? 1 : 0;
    
    //squares
    assign TopLeft = ((F0 == 1) && (hCount >= 10'd180) && (hCount <= 10'd220)) && ((vCount >= 10'd55) && (vCount <= 10'd95)) ? 1 : 0;
 
    assign TopMid = ((F1 == 1) && (hCount >= 10'd435) && (hCount <= 10'd475)) && ((vCount >= 10'd55) && (vCount <= 10'd95)) ? 1 : 0;
    
    assign TopRight = ((F2 == 1) && (hCount >= 10'd690) && (hCount <= 10'd730)) && ((vCount >= 10'd55) && (vCount <= 10'd95)) ? 1 : 0;
    
    assign MidLeft = ((F3 == 1) && (hCount >= 10'd180) && (hCount <= 10'd220)) && ((vCount >= 10'd240) && (vCount <= 10'd280)) ? 1 : 0;
 
    assign Mid = ((F4 == 1) && (hCount >= 10'd435) && (hCount <= 10'd475)) && ((vCount >= 10'd240) && (vCount <= 10'd280)) ? 1 : 0;
    
    assign MidRight = ((F5 == 1) && (hCount >= 10'd690) && (hCount <= 10'd730)) && ((vCount >= 10'd240) && (vCount <= 10'd280)) ? 1 : 0;
    
    assign BottomLeft = ((F6 == 1) && (hCount >= 10'd180) && (hCount <= 10'd220)) && ((vCount >= 10'd425) && (vCount <= 10'd465)) ? 1 : 0;
 
    assign BottomMid = ((F7 == 1) && (hCount >= 10'd435) && (hCount <= 10'd475)) && ((vCount >= 10'd425) && (vCount <= 10'd465)) ? 1 : 0;
    
    assign BottomRight = ((F8 == 1) && (hCount >= 10'd690) && (hCount <= 10'd730)) && ((vCount >= 10'd425) && (vCount <= 10'd465)) ? 1 : 0;
    
    
endmodule