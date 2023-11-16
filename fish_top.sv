
module  fish_top (  
						input 	Clk,                // 50 MHz clock
									Reset,              // Active-high reset signal
                        	frame_clk,          // The clock indicating a new frame (~60Hz)
								
						input [7:0]	  	keycode,keycode_0,			// keyboard press
						input [9:0]   	DrawX, DrawY,   // Current pixel coordinates
						
						input is_user1,is_user2,
						
						output user1_eat_fish1,user1_eat_fish2,user1_eat_fish3,user1_eat_fish4,user1_eat_fish5,user1_eat_fish6,user1_eat_fish7,user1_eat_fish8,user1_eat_fish9,
                  output user2_eat_fish1,user2_eat_fish2,user2_eat_fish3,user2_eat_fish4,user2_eat_fish5,user2_eat_fish6,user2_eat_fish7,user2_eat_fish8,user2_eat_fish9,
								
						input is_start,
						output 	fish1_exist,fish2_exist,fish3_exist,fish4_exist,
									fish5_exist,fish6_exist,fish7_exist,fish8_exist,fish9_exist,
									
						output 	is_fish1,is_fish2,is_fish3,is_fish4,
									is_fish5,is_fish6,is_fish7,is_fish8,is_fish9,
						
						//,fish_check
						output [3:0] 	fish1_address,fish2_address,fish3_address,fish4_address,
											fish5_address,fish6_address,fish7_address,fish8_address,fish9_address,
						
						output shark1_exist,
						output is_shark1,//,fish_check
						output [3:0] shark1_address,
						input [9:0] user1_X_Pos,user1_Y_Pos,
						input [9:0] user2_X_Pos,user2_Y_Pos
              );
	 
	 //logic user1_on;
//		
//		logic [9:0] rand;
//		rand = 10'd0+{$random}%(10'd640-10'd0+1);
		
		fish #(.fish_X_Center(10'd60),.fish_Y_Center(10'd450)) 
		fish1(.*,.fish_address(fish1_address),.fish_exist(fish1_exist),.is_fish(is_fish1),
		.user1_eat_fish(user1_eat_fish1),.user2_eat_fish(user2_eat_fish1) );
		
		fish #(.fish_X_Center(10'd120),.fish_Y_Center(10'd420)) 
		fish2(.*, .fish_address(fish2_address),.fish_exist(fish2_exist),.is_fish(is_fish2),
		.user1_eat_fish(user1_eat_fish2),.user2_eat_fish(user2_eat_fish2));
		
		fish #(.fish_X_Center(10'd180),.fish_Y_Center(10'd390)) 
		fish3(.*, .fish_address(fish3_address),.fish_exist(fish3_exist),.is_fish(is_fish3),
		.user1_eat_fish(user1_eat_fish3),.user2_eat_fish(user2_eat_fish3));
		
		fish #(.fish_X_Center(10'd240),.fish_Y_Center(10'd360)) 
		fish4(.*, .fish_address(fish4_address),.fish_exist(fish4_exist),.is_fish(is_fish4),
		.user1_eat_fish(user1_eat_fish4),.user2_eat_fish(user2_eat_fish4));
		
		fish #(.fish_X_Center(10'd300),.fish_Y_Center(10'd330)) 
		fish5(.*, .fish_address(fish5_address),.fish_exist(fish5_exist),.is_fish(is_fish5),
		.user1_eat_fish(user1_eat_fish5),.user2_eat_fish(user2_eat_fish5));
		
		fish #(.fish_X_Center(10'd360),.fish_Y_Center(10'd300)) 
		fish6(.*, .fish_address(fish6_address),.fish_exist(fish6_exist),.is_fish(is_fish6),
		.user1_eat_fish(user1_eat_fish6),.user2_eat_fish(user2_eat_fish6));
		
		fish #(.fish_X_Center(10'd420),.fish_Y_Center(10'd270)) 
		fish7(.*, .fish_address(fish7_address),.fish_exist(fish7_exist),.is_fish(is_fish7),
		.user1_eat_fish(user1_eat_fish7),.user2_eat_fish(user2_eat_fish7));
		
		fish #(.fish_X_Center(10'd480),.fish_Y_Center(10'd240)) 
		fish8(.*, .fish_address(fish8_address),.fish_exist(fish8_exist),.is_fish(is_fish8),
		.user1_eat_fish(user1_eat_fish8),.user2_eat_fish(user2_eat_fish8));
		
		fish #(.fish_X_Center(10'd540),.fish_Y_Center(10'd210)) 
		fish9(.*, .fish_address(fish9_address),.fish_exist(fish9_exist),.is_fish(is_fish9),
		.user1_eat_fish(user1_eat_fish9),.user2_eat_fish(user2_eat_fish9));
		

		shark shark1(.*,.shark_address(shark1_address),.shark_exist(shark1_exist),.is_shark(is_shark1));
		
endmodule
