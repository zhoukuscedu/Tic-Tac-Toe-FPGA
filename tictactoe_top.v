`timescale 1ns / 1ps

module tictactoe_top
		(input		ClkPort,	
	// Project Specific Inputs
	input		BtnL, BtnU, BtnD, BtnR, BtnC,
	input Sw0,
	
	//VGA signal
	output hSync, vSync,
	output [3:0] vgaR, vgaG, vgaB,
	
	/*  OUTPUTS */
	// Control signals on Memory chips 	(to disable them)
	output 	MemOE, MemWR, RamCS, QuadSpiFlashCS                 
	  );

	/*  INPUTS */
	// Clock 
	
	/*  LOCAL SIGNALS */
	wire		Reset;

	wire		board_clk;
	
	wire BtnR_Pulse, BtnU_Pulse, BtnD_Pulse, BtnL_Pulse, BtnC_Pulse;
    
    wire bright;
	wire[9:0] hc, vc;
	wire[15:0] score;
    wire [11:0] rgb;
    
    reg [25:0]	    DIV_CLK;

	wire F0, F1, F2, F3, F4, F5, F6, F7, F8, P;
	wire game;
    wire won, tie;
    
    assign Reset = Sw0;
    
	assign {MemOE, MemWR, RamCS, QuadSpiFlashCS} = 5'b11111;
	
	assign vgaR = rgb[11 : 8];
	assign vgaG = rgb[7  : 4];
	assign vgaB = rgb[3  : 0];
	
	BUFGP BUFGP1 (board_clk, ClkPort); 		
	
	assign	sys_clk = board_clk;
    
// INPUT: BUTTONS
    ee201_debouncer #(.N_dc(28)) ee201_debouncer_4 
        (.CLK(sys_clk), .RESET(Reset), .PB(BtnL), .DPB( ), 
		.SCEN(BtnL_Pulse), .MCEN( ), .CCEN( ));

    ee201_debouncer #(.N_dc(28)) ee201_debouncer_3 
        (.CLK(sys_clk), .RESET(Reset), .PB(BtnR), .DPB( ), 
		.SCEN(BtnR_Pulse), .MCEN( ), .CCEN( ));

    ee201_debouncer #(.N_dc(28)) ee201_debouncer_2 
        (.CLK(sys_clk), .RESET(Reset), .PB(BtnU), .DPB( ), 
		.SCEN(BtnU_Pulse), .MCEN( ), .CCEN( )); 
    
    ee201_debouncer #(.N_dc(28)) ee201_debouncer_1  
        (.CLK(sys_clk), .RESET(Reset), .PB(BtnD), .DPB( ), 
		.SCEN(BtnD_Pulse), .MCEN( ), .CCEN( ));

    ee201_debouncer #(.N_dc(28)) ee201_debouncer_0  
        (.CLK(sys_clk), .RESET(Reset), .PB(BtnC), .DPB( ), 
		.SCEN(BtnC_Pulse), .MCEN( ), .CCEN( ));

// the state machine module
    tictactoe_sm tictactoe_sm_0(.Clk(sys_clk), .reset(Reset), .BtnC(BtnC_Pulse), .BtnU(BtnU_Pulse), 
                              .BtnD(BtnD_Pulse), .BtnR(BtnR_Pulse), .BtnL(BtnL_Pulse), .F0(F0), .F1(F1),
							  .F2(F2), .F3(F3), .F4(F4), .F5(F5), .F6(F6), .F7(F7), .F8(F8), .game(game), .won(won), .tie(tie), .P(P));

//display controller                              
    display_controller dc(.clk(sys_clk), .hSync(hSync), .vSync(vSync), .bright(bright), .hCount(hc), .vCount(vc));

	vga_bitchange vbc(.F0(F0), .F1(F1), .F2(F2), .F3(F3), .F4(F4), .F5(F5), .F6(F6), .F7(F7), .F8(F8), .P(P), .game(game), .won(won), .tie(won), .reset(Reset), 
					  .clk(sys_clk), .bright(bright), .button(), .hCount(hc), .vCount(vc), .rgb(rgb), .score(score));

endmodule