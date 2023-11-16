//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  10-06-2017                               --
//                                                                       --
//    Fall 2017 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 8                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------

// color_mapper: Decide which color to be output to VGA for each pixel.

module  color_mapper (  input is_background,
								input [3:0] background_address,
								
								input is_title,
								input [3:0] title_address,
								
								input start_address,user1win_address,user2win_address,
								input	is_start,is_user1win,is_user2win,
								
								
								input is_user1,
								input [3:0] user1_address,
								input user1_exist,
								
								input is_user2,
								input [3:0] user2_address,	
								input user2_exist,							
								
								
								input [3:0] fish1_address,fish2_address,fish3_address,fish4_address,fish5_address,fish6_address,fish7_address,fish8_address,fish9_address,
								input is_fish1,is_fish2,is_fish3,is_fish4,is_fish5,is_fish6,is_fish7,is_fish8,is_fish9,
								input fish1_exist,fish2_exist,fish3_exist,fish4_exist,fish5_exist,fish6_exist,fish7_exist,fish8_exist,fish9_exist,

								input is_shark1,
								input [3:0] shark1_address,
								input shark1_exist,
								
								//score of the two user
								input [7:0] score1,score2,
								
								//input [23:0] BG_RGB,
								//input 		is_ball,            // Whether current pixel belongs to ball 
                                                              //   or background (computed in ball.sv)
								input  [9:0] DrawX, DrawY,       // Current pixel coordinates
								output [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
   logic [7:0] Red, Green, Blue;
	
	 
   // Output colors to VGA
   assign VGA_R = Red;
   assign VGA_G = Green;
   assign VGA_B = Blue;
    
		
		
	//start, user1win , user2win
	logic [23:0] color[1:0];//8
	logic [23:0] start_display;
	logic [23:0] user1win_display;
	logic [23:0] user2win_display;
	assign color='{24'h4472c4,24'hffffff};
	assign start_display=color[start_address];
	assign user1win_display=color[user1win_address];
	assign user2win_display=color[user2win_address];
	 
	//title 
	logic [23:0] title_color[7:0];//8
	logic [23:0] title_display;
	assign title_color='{24'hd42b30,24'h174672,24'h59337c,24'ha69fbc,
								24'h68648b,24'h4b356c,24'h6b8277,24'h4a4d60};
	assign title_display=title_color[title_address];
	
	//BG
	logic [23:0] BG_color[6:0];
	logic [23:0] BG_display;
	assign BG_color='{24'h002E36,24'h84C8F2,24'h6A3B37,24'h6B8FB6,24'h235F97,24'hB1A591,24'h62BEEA};
	//assign BG_color= '{24'h325086,24'h665657,24'h22273A,24'h32425C,
//							24'h3A4D5C,24'h2F2C3F,24'h5477AD,24'h407AB9,
//							24'h5B9AD0,24'h386DAF,24'h1F2130,24'h8B8086,
//							24'h508DC4,24'h3475B7,24'h6888B9,24'h202133};
	assign BG_display=BG_color[background_address];
	 
	 
	 //user1
	logic [23:0] user1_color[15:0];//16 color
	logic [23:0] user1_display;
	assign user1_color='{24'hFFFFFF,24'h060303,24'hE89DA1,24'h6BADD7,
								24'h8A9A91,24'hC0B1A2,24'hFCE3C4,24'hF6D0BC,
								24'hF7DFC5,24'hF7DEB8,24'hA9C7C6,24'h60A5D8,
								24'h67AAD5,24'hC8D6D9,24'hF1E0C6,24'hE7ACA5};
	assign user1_display=user1_color[user1_address];							
								
	 //user2
	logic [23:0] user2_color[10:0];//11
	logic [23:0] user2_display;
	assign user2_color='{	24'hFFFFFF,24'h67ABD8,24'h98D0DD,24'h5A7B83,
									24'h5E9CC5,24'h548BAF,24'hF8DFC0,24'hEA9EA0,
									24'h010000,24'h28231E,24'h67AAD7};
	assign user2_display=user2_color[user2_address];							
									
	//fish1
	logic [23:0] fish_color[4:0];//5
	logic [23:0] fish1_display,fish2_display,fish3_display,fish4_display,fish5_display,fish6_display,fish7_display,fish8_display,fish9_display;
	assign fish_color='{24'hFFFFFF,24'h00FF00,24'hFF0000,24'h000000,24'h00FFFF};			
	assign fish1_display=fish_color[fish1_address];
	assign fish2_display=fish_color[fish2_address];
	assign fish3_display=fish_color[fish3_address];
	assign fish4_display=fish_color[fish4_address];
	assign fish5_display=fish_color[fish5_address];
	assign fish6_display=fish_color[fish6_address];
	assign fish7_display=fish_color[fish7_address];
	assign fish8_display=fish_color[fish8_address];
	assign fish9_display=fish_color[fish9_address];
	
	//shark1
	logic [23:0] shark1_color[5:0];//6
	logic [23:0] shark1_display;
	//assign shark1_color='{24'hFFFFFF,24'h000000,24'h632122,24'hC8C8C8,24'hFFFFFE,24'h6C5156};
	assign shark1_color='{24'h6C5156,24'hFFFFFE,24'hC8C8C8,24'h632122,24'h000000,24'hFFFFFF};
	assign shark1_display=shark1_color[shark1_address];

	//score digits 1 and 2
	logic [7:0] n_addr1,n_addr2;
	number_display number_display1(.number(score1),.number_address(n_addr1));
	number_display number_display2(.number(score2),.number_address(n_addr2));
	
	logic [7:0] number_data1,number_data2;
	numbers number1(.address(n_addr1_Y), .data(number_data1));
	numbers number2(.address(n_addr2_Y), .data(number_data2));
	
	//the score of the two user
	parameter [23:0] score_color=24'hFF0000;//2
	logic is_score1,is_score2;
	logic [7:0] n_addr1_X,n_addr1_Y,n_addr2_X,n_addr2_Y;

	
	assign n_addr1_X = DrawX - 62;//offset of X
	assign n_addr1_Y = DrawY - 11 + n_addr1;//offset of Y
	assign n_addr2_X = DrawX - 601;//offset of X
	assign n_addr2_Y = DrawY - 11 + n_addr2;//offset of Y
	
   // Assign color based on is_ball signal
   always_comb
   begin
	
		if (DrawX >= 62 && DrawX < 70 && DrawY > 11 && DrawY <= 27 && number_data1[n_addr1_X] == 1'b1 )
			is_score1=1'b1;
		else
			is_score1=1'b0;
		
		if (DrawX > 600 && DrawX <= 608  && DrawY > 11 && DrawY <= 27 && number_data2[n_addr2_X] == 1'b1 )
			is_score2=1'b1;
		else
			is_score2=1'b0;
	
		if	(is_start== 1'b0)
		begin
			Red = start_display[23:16];
			Green = start_display[15:8];
			Blue = start_display[7:0];
		end
		else if	(is_user1win == 1'b1)
		begin
			Red = user1win_display[23:16];
			Green = user1win_display[15:8];
			Blue = user1win_display[7:0];
		end
		else  if	(is_user2win == 1'b1)
		begin
			Red = user2win_display[23:16];
			Green = user2win_display[15:8];
			Blue =user2win_display[7:0];
		end
		else if (is_score1 == 1'b1)
		begin
			Red = score_color[23:16];
			Green = score_color[15:8];
			Blue = score_color[7:0];
		end
		else if (is_score2 == 1'b1)
		begin
			Red = score_color[23:16];
			Green = score_color[15:8];
			Blue = score_color[7:0];
		end
		else if ( is_title == 1'b1 )
		begin
			Red = title_display[23:16];
			Green = title_display[15:8];
			Blue = title_display[15:8];
		end
		else if ( DrawY <= 48 )
		begin
			Red = 8'hff - DrawY[8:1];
			Green = 8'hff;
			Blue = 8'hff ;
		end
		else if (is_user1 == 1'b1 && user1_exist==0)
		begin
			Red = user1_display[23:16];
         Green = user1_display[15:8];
         Blue = user1_display[7:0];
		end
		else if (is_user2 == 1'b1 && user2_exist==0)
		begin
			Red = user2_display[23:16];
         Green = user2_display[15:8];
         Blue = user2_display[7:0];
		end
		else if (is_shark1 == 1'b1 && shark1_exist==0)
		begin
			Red = shark1_display[23:16];
         Green = shark1_display[15:8];
         Blue = shark1_display[7:0];
		end
		
			
		else if (is_fish1 == 1'b1 && fish1_exist==0)
		begin
			Red = fish1_display[23:16];
         Green = fish1_display[15:8];
         Blue = fish1_display[7:0];
		end
		else if (is_fish2 == 1'b1 && fish2_exist==0)
		begin
			Red = fish2_display[23:16];
         Green = fish2_display[15:8];
         Blue = fish2_display[7:0];
		end
		else if (is_fish3 == 1'b1 && fish3_exist==0)
		begin
			Red = fish3_display[23:16];
         Green = fish3_display[15:8];
         Blue = fish3_display[7:0];
		end
		else if (is_fish4 == 1'b1 && fish4_exist==0)
		begin
			Red = fish4_display[23:16];
         Green = fish4_display[15:8];
         Blue = fish4_display[7:0];
		end
		else if (is_fish5 == 1'b1 && fish5_exist==0)
		begin
			Red = fish5_display[23:16];
         Green = fish5_display[15:8];
         Blue = fish5_display[7:0];
		end
		else if (is_fish6 == 1'b1 && fish6_exist==0)
		begin
			Red = fish6_display[23:16];
         Green = fish6_display[15:8];
         Blue = fish6_display[7:0];
		end
		else if (is_fish7 == 1'b1 && fish7_exist==0)
		begin
			Red = fish7_display[23:16];
         Green = fish7_display[15:8];
         Blue = fish7_display[7:0];
		end
		else if (is_fish8 == 1'b1 && fish8_exist==0)
		begin
			Red = fish8_display[23:16];
         Green = fish8_display[15:8];
         Blue = fish8_display[7:0];
		end
		else if (is_fish9 == 1'b1 && fish9_exist==0)
		begin
			Red = fish9_display[23:16];
         Green = fish9_display[15:8];
         Blue = fish9_display[7:0];
		end
		
		
		//object above the background
		else if (is_background == 1'b1 )
		begin
			Red = BG_display[23:16];
         Green = BG_display[15:8];
         Blue = BG_display[7:0];
		end
		else
		begin
			Red = 8'hff - DrawY[8:1];
			Green = 8'hff;
			Blue = 8'hff ;
		end
    end 
    
endmodule
