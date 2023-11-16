

module  fish (  	input Clk,                // 50 MHz clock
                        Reset,              // Active-high reset signal
                        frame_clk,          // The clock indicating a new frame (~60Hz)
						
						input is_start,		
						input [9:0]   DrawX, DrawY,       // Current pixel coordinates
						
						output user1_eat_fish,
                  output user2_eat_fish,
						input is_user1,is_user2,
						output fish_exist,
						output is_fish,          // check if fish 
						output [3:0] fish_address
              );
    
    parameter [9:0] fish_X_Center = 10'd100;  // Center position on the X axis
    parameter [9:0] fish_Y_Center = 10'd100;  // Center position on the Y axis
    parameter [9:0] fish_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] fish_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] fish_Y_Min = 10'd48;       // Topmost point on the Y axis
    parameter [9:0] fish_Y_Max = 10'd479;     // Bottommost point on the Y axis
	 
    parameter [9:0] fish_X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] fish_Y_Step = 10'd1;      // Step size on the Y axis
    //parameter [9:0] fish_Size = 10'd4;      // fish size
	 parameter [9:0] fish_sizeX=10'd32;
	 parameter [9:0] fish_sizeY=10'd32;
    
	 logic [9:0] fish_X_Pos,fish_Y_Pos;
    logic [9:0] fish_X_Pos_in, fish_X_Motion_in, fish_Y_Pos_in, fish_Y_Motion_in;
    
	 logic [9:0] fish_X_Motion=0; 
	 logic [9:0] fish_Y_Motion=0;
	 
	 //check whether hit
	logic hit=1'b0;
	logic hit_in=1'b0;
	logic fish_exist_in=1'b0;
	logic user1_eat_fish_in=1'b0;
   logic user2_eat_fish_in=1'b0;
	logic user1_hit_fish=1'b0;
   logic user2_hit_fish=1'b0;
	logic user1_hit_fish_in=1'b0;
   logic user2_hit_fish_in=1'b0;
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
    // Update registers
    always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            fish_X_Pos <= fish_X_Center;
            fish_Y_Pos <= fish_Y_Center;
            fish_X_Motion <= fish_X_Step;
            fish_Y_Motion <= fish_Y_Step;
				//fish_Y_Step;
				hit<=1'b0;
				fish_exist<=1'b0;
            user1_eat_fish<=1'b0;
            user2_eat_fish<=1'b0;
				user1_hit_fish<=1'b0;
				user2_hit_fish<=1'b0;
        end
        else
        begin
            fish_X_Pos <= fish_X_Pos_in;
            fish_Y_Pos <= fish_Y_Pos_in;
            fish_X_Motion <= fish_X_Motion_in;
            fish_Y_Motion <= fish_Y_Motion_in;
            hit<=hit_in;
				user1_hit_fish<=user1_hit_fish_in;
				user2_hit_fish<=user2_hit_fish_in;
				fish_exist<=fish_exist_in;
            user1_eat_fish<=user1_eat_fish_in;
            user2_eat_fish<=user2_eat_fish_in;
        end
		  
	end
  
  
  
    // You need to modify always_comb block.
    always_comb
    begin
	 
			if ( fish_X_Motion_in[9] == 1'b1)
				fish_address=fish_address_left;
			else if ( fish_X_Motion_in[9] == 1'b0)
				fish_address=fish_address_right;
			else 
				if (  fish_X_Motion[9] == 1'b1)
					fish_address=fish_address_left;
				else 
					fish_address=fish_address_right;
					
			
        // By default, keep motion and position unchanged
        fish_X_Pos_in = fish_X_Pos;
        fish_Y_Pos_in = fish_Y_Pos;
        fish_X_Motion_in = fish_X_Motion;
        fish_Y_Motion_in = fish_Y_Motion;
		  
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin

            if( fish_Y_Pos + fish_sizeY >= fish_Y_Max )  // fish is at the bottom edge, BOUNCE!
                fish_Y_Motion_in = (~(fish_Y_Step) + 1'b1);  // 2's complement.  
            else if ( fish_Y_Pos <= fish_Y_Min + fish_sizeY )  // fish is at the top edge, BOUNCE!
                fish_Y_Motion_in = fish_Y_Step;
            if( fish_X_Pos + fish_sizeX >= fish_X_Max )  // fish is at the right edge, BOUNCE!
                fish_X_Motion_in = (~(fish_X_Step) + 1'b1);  // 2's complement.  
            else if ( fish_X_Pos <= fish_X_Min + fish_sizeX )  // fish is at the left edge, BOUNCE!
                fish_X_Motion_in = fish_X_Step;
					 
					 
					 
//				if (is_start == 1)
//				begin
//					user_X_Pos_in = user_X_Pos + user_X_Motion_in;
//					user_Y_Pos_in = user_Y_Pos + user_Y_Motion_in;
//            end
//				else
//				begin
//					fish_X_Pos_in = fish_X_Pos;
//					fish_Y_Pos_in = fish_Y_Pos;
//            end
				
            // Update the fish's position with its motion
            fish_X_Pos_in = fish_X_Pos + fish_X_Motion_in;
            fish_Y_Pos_in = fish_Y_Pos + fish_Y_Motion_in;
        end
		  
			
				
        
    end
		
		
		logic is_fish_temp;
		logic [18:0] read_fish_address;
		logic	[9:0] 	left, up;
		logic	[9:0] 	tempX, tempY;
		//logic				fish_on;
		always_comb
		begin
			left	= fish_X_Pos - fish_sizeX/2;
			up		= fish_Y_Pos - fish_sizeY/2;
			tempX	=	DrawX - left;
			tempY	=	DrawY - up;
			if (tempX >= 0 && tempX < fish_sizeX && tempY >= 0 && tempY < fish_sizeY) 
				is_fish_temp = 1'b1;
			else 
				is_fish_temp = 1'b0;
			if(is_fish_temp == 1'b1)
				read_fish_address	=	tempY * fish_sizeX + tempX;
			else
				read_fish_address	=	19'd0;//FFFFFF, white
			
			
			//
			if( fish_address != 0)
				is_fish=is_fish_temp;
			else
				is_fish=1'b0;
			
			//compute the exist, eat?
			if( ( (is_user1&&is_fish)||(is_user2&&is_fish) ) && (is_start==1 ))
         begin
				hit_in=1'b1;
                if((is_user1&&is_fish)&& (user1_eat_fish==0) && ( user2_eat_fish==0))
                begin
                    user1_hit_fish_in=1'b1;
                    user2_hit_fish_in=1'b0;
                end
                else if((is_user2&&is_fish)&& (user1_eat_fish==0) && ( user2_eat_fish==0))
                begin
                    user2_hit_fish_in=1'b1;
                    user1_hit_fish_in=1'b0;
                end
                else
                begin
                    user1_hit_fish_in=user1_hit_fish;
                    user2_hit_fish_in=user2_hit_fish;
                end
         end
			else
			begin
				hit_in=hit;
				user1_hit_fish_in=user1_hit_fish;
            user2_hit_fish_in=user2_hit_fish;
			end
			
			if (hit==1)
			begin
				fish_exist_in=1'b1;
				if (user1_hit_fish == 1)
				begin
						user1_eat_fish_in=1'b1;
						user2_eat_fish_in=user2_eat_fish;
				end 
				//else if( user2_hit_fish==1 )
				//begin
				//		user2_eat_fish_in=1'b1;
					//	user1_eat_fish_in=user1_eat_fish;
				//end
				else
				begin
					user1_eat_fish_in=user1_eat_fish;
					user2_eat_fish_in=1'b1;
				end
			end
		   else
			begin
				fish_exist_in=fish_exist;
				user1_eat_fish_in=user1_eat_fish;
				user2_eat_fish_in=user2_eat_fish;
			end	
		end
		
		logic [3:0] fish_address_left, fish_address_right;
		
		fish_left_RAM fish_left(.*,.fish_address(fish_address_left),.read_address(read_fish_address));
		fish_right_RAM fish_right(.*,.fish_address(fish_address_right),.read_address(read_fish_address));
		
endmodule

		

