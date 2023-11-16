
module  user_top (  
						input 	Clk,                // 50 MHz clock
									Reset,              // Active-high reset signal
                        	frame_clk,          // The clock indicating a new frame (~60Hz)
						
						input [7:0]	  	keycode,		// keyboard press
						input [9:0]   	DrawX, DrawY,   // Current pixel coordinates
						
						input [23:0]user1_RGB,
						input [9:0] user1_sizeX,user1_sizeY,
						input user1_exist,
						
						output is_user1,//,fish_check			
						output [3:0] user1_address
              );
				 
		logic [18:0] read_fish1_address;
		
		user user1( 
						.*, 
						//.user_X(user1_X), .user_Y(user1_Y), 
						.user_exist(user1_exist),
						//.user_sizeX(user1_sizeX),.user_sizeY(user1_sizeY),
						.is_user(is_user1),          
						.read_address(read_user1_address),
						//.user_address(user1_address),
		);
		
		user_RAM user_RAM1(.*, .read_address(read_user1_address), .user_address(user1_address));//display next user position

endmodule