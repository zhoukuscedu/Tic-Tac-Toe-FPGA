`timescale 1ns / 1ps

module tictactoe_sm(Clk, reset, BtnC, BtnU, BtnD, BtnR, BtnL, F0, F1, F2, 
                    F3, F4, F5, F6, F7, F8, game, won, tie, P);

	/*  INPUTS */
	// Clock, Reset, Push-Buttons
	input BtnC, BtnU, BtnD, BtnR, BtnL, Clk, reset;
	
	/*  OUTPUTS */
	// store current state
	reg [11:0] pos;
	reg [11:0] state;
    reg playervec [1:0][8:0];
    reg  P;
    wire won, tie;
    output reg F0, F1, F2, F3, F4, F5, F6, F7, F8;
    output reg game;
    integer i;
    integer j;
    output won, tie, P;

	localparam
	    QI		   = 12'b100000000000,
	    Q0	       = 12'b010000000000,
	    Q1	       = 12'b001000000000,
	    Q2         = 12'b000100000000,
	    Q3	       = 12'b000010000000,
	    Q4         = 12'b000001000000,
	    Q5         = 12'b000000100000,
	    Q6         = 12'b000000010000,
	    Q7         = 12'b000000001000, 
	    Q8         = 12'b000000000100, 
	    QWINCON    = 12'b000000000010,
        QDONE      = 12'b000000000001,
	    UNK        = 12'bXXXXXXXXXXXX;
	
	initial state = QI; 
	initial game = 0;
	// NSL AND SM
	
	always @ (posedge Clk, posedge reset)
	begin
		if(reset)
		  begin
			state <= QI;
			game <=0;
		  end		
		else
		  begin
	           case(state)
			  	    QI:
			  		    begin
			  		    P <= 0;
			  		    state <= Q4;
			  		    for (i = 0; i < 9; i = i + 1)
                            begin
                                for (j = 0; j < 2; j = j + 1)
                                    begin
                                        playervec[j][i] = 0;
                                    end
                            end
                        game <=1'b1;
                        F0 <= 0; 
                        F1 <= 0; 
                        F2 <= 0; 
                        F3 <= 0; 
                        F4 <= 0; 
                        F5 <= 0;
                        F6 <= 0; 
                        F7 <= 0;
                        F8 <= 0;  
                        pos <= Q4;
                    end
			 	    Q0:		
				        if(BtnD)
                            state <= Q3;
                        else if(BtnR)
                            state <= Q1;
                        else if(BtnL)
                            state <= Q2;
                        else if(BtnU)
                            state <=Q6;    
                        else if((BtnC) && (F0 == 0)) 
                            begin
                                pos <= Q0;
                                F0 <= 1'b1;
                                state <= QWINCON;
                                playervec[P][0] <= 1;
                            end
				    Q1:
				        if(BtnD)
                            state <= Q4;
                        else if(BtnR)
                            state <= Q2;
                        else if(BtnL) 
                            state <= Q0;
                        else if(BtnU)
                            state <= Q7;
                        else if((BtnC) && (F1 == 0)) 
                            begin
                                pos <= Q1;
                                F1 <= 1'b1;
                                state <= QWINCON;
                                playervec[P][1] <= 1;
                            end
				    Q2:
				        if(BtnD)
                            state <= Q5;
                        else if(BtnL) 
                            state <= Q1;
                        else if(BtnR)
                            state <= Q0;
                        else if(BtnU)
                            state <= Q8;
                        else if((BtnC) && (F2 == 0)) 
                            begin
                                pos <= Q2;
                                F2 <= 1'b1;
                                state <= QWINCON;
                                playervec[P][2] <= 1;
                            end
				    Q3:
				        if(BtnU)
                            state <= Q0;
                        else if(BtnD)
                            state <= Q6;
                        else if(BtnR)
                            state <= Q4;
                        else if(BtnL)
                            state <= Q5;
                        else if((BtnC) && (F3 == 0)) 
                            begin
                                pos <= Q3;
                                F3 <= 1'b1;
                                state <= QWINCON;
                                playervec[P][3] <= 1;
                            end
				    Q4:
				        if(BtnU)
                            state <= Q1;
                        else if(BtnD)
                            state <= Q7;
                        else if(BtnR)
                            state <= Q5;
                        else if(BtnL) 
                            state <= Q3;
                        else if((BtnC) && (F4 == 0)) 
                            begin
                                pos <= Q4;
                                F4 <= 1'b1;
                                state <= QWINCON;
                                playervec[P][4] <= 1;
                            end
				    Q5:
				        if(BtnU)
                            state <= Q2;
                        else if(BtnD)
                            state <= Q8;
                        else if(BtnL) 
                            state <= Q4;
                        else if(BtnR)
                            state <= Q3;
                        else if(BtnC && (F5 ==0)) 
                            begin
                                pos <= Q5;
                                F5 <= 1'b1;
                                state <= QWINCON;
                                playervec[P][5] <= 1;
                            end
				    Q6:
				        if(BtnU)
                            state <= Q3;
                        else if(BtnR)
                            state <= Q7;
                        else if(BtnD)
                            state <= Q0;
                        else if(BtnL)
                            state <= Q8;
                        else if((BtnC) && (F6 == 0)) 
                            begin
                                pos <= Q6;
                                F6 <= 1'b1;
                                state <= QWINCON;
                                playervec[P][6] <= 1;
                            end
                    Q7:
                        if(BtnU)
                            state <= Q4;
                        else if(BtnR)
                            state <= Q8;
                        else if(BtnL) 
                            state <= Q6;
                        else if (BtnD)
                            state <= Q1;
                        else if((BtnC) && (F7 == 0)) 
                            begin
                                pos <= Q7;
                                F7 <= 1'b1;
                                state <= QWINCON;
                                playervec[P][7] <= 1;
                            end
                    Q8:
                        if(BtnU)
                            state <= Q5;
                        else if(BtnL)
                            state <= Q7;
                        else if(BtnR)
                            state <= Q6;
                        else if(BtnD)
                            state <= Q2;
                        else if((BtnC) && (F8 == 0)) 
                            begin
                                pos <= Q8;
                                F8 <= 1'b1;
                                playervec[P][8] <= 1;
                                state <= QWINCON;
                            end
				    QWINCON:
                        begin
                            if (won || tie)
				                begin
				                    state <= QDONE;
				                    game <= 0;
				                end
                            else if (P == 0)
                                begin
                                    P <= 1;
                                    state <= pos;
                                end
                            else if (P == 1)
                                begin
                                    P <= 0;
                                    state <= pos;
                                end
                        end
                    QDONE:
                        begin
                                state <= QI;
                        end
			  endcase
		end
	end

    
    assign won = (playervec[P][0] && playervec[P][1] && playervec[P][2]) ||
                 (playervec[P][0] && playervec[P][3] && playervec[P][6]) ||
                 (playervec[P][0] && playervec[P][4] && playervec[P][8]) ||
                 (playervec[P][1] && playervec[P][4] && playervec[P][7]) ||
                 (playervec[P][2] && playervec[P][5] && playervec[P][8]) ||
                 (playervec[P][3] && playervec[P][4] && playervec[P][5]) ||
                 (playervec[P][6] && playervec[P][7] && playervec[P][8]) ||
                 (playervec[P][2] && playervec[P][4] && playervec[P][6]);
    
    assign tie = (F0 && F1 && F2 && F3 && F4 && F5 && F6 && F7 && F8 && !won);
    
endmodule