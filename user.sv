

module  user (  	input Clk,                // 50 MHz clock
                        Reset,              // Active-high reset signal
                        frame_clk,          // The clock indicating a new frame (~60Hz)
								
						input [9:0]   DrawX, DrawY,       // Current pixel coordinates
						input [7:0]	  keycode,keycode_0,				 // keyboard press
						input is_shark,
						input is_start,
						output user_exist,
						output is_user,          // check if user 
						output [3:0] user_address,
						output [9:0] user_X_Pos,user_Y_Pos
						
              );
    
    parameter [9:0] user_X_Center = 10'd70;  // Center position on the X axis
    parameter [9:0] user_Y_Center = 10'd70;  // Center position on the Y axis
    parameter [9:0] user_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] user_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] user_Y_Min = 10'd48;       // Topmost point on the Y axis
    parameter [9:0] user_Y_Max = 10'd479;     // Bottommost point on the Y axis
	 
    parameter [9:0] user_X_Step = 10'd3;      // Step size on the X axis
    parameter [9:0] user_Y_Step = 10'd3;      // Step size on the Y axis
    //parameter [9:0] user_Size = 10'd4;      // user size
	
    parameter [9:0] user_sizeX = 10'd64;
	 parameter [9:0] user_sizeY = 10'd48;
	 
	 //logic [9:0] user_X_Pos,user_Y_Pos;
    logic [9:0] user_X_Pos_in, user_X_Motion_in, user_Y_Pos_in, user_Y_Motion_in;
    
	 logic [9:0] user_X_Motion=0, user_Y_Motion=0;
	 
	 
	 	 //check whether hit
	logic hit=1'b0;
	logic hit_in=1'b0;
	logic user_exist_in=1'b0;
	 
	 
	 
		logic [3:0] user_address_left, user_address_right;
		
		user_left_RAM user_left(.*,.user_address(user_address_left),.read_address(read_user_address));
		
		user_right_RAM user_right(.*,.user_address(user_address_right),.read_address(read_user_address));
	 
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
            user_X_Pos <= user_X_Center;
            user_Y_Pos <= user_Y_Center;
            user_X_Motion <= 10'd0;
            user_Y_Motion <= 10'd0;
				hit<=1'b0;
				user_exist<=1'b0;
        end
        else
        begin
            user_X_Pos <= user_X_Pos_in;
            user_Y_Pos <= user_Y_Pos_in;
            user_X_Motion <= user_X_Motion_in;
            user_Y_Motion <= user_Y_Motion_in;
				hit<=hit_in;
				user_exist<=user_exist_in;
        end
    end
    //////// Do not modify the always_ff blocks. ////////
    
	 
    // You need to modify always_comb block.
    always_comb
    begin
	 
			if ( user_X_Motion_in[9] == 1'b1)
				user_address=user_address_left;
			else if ( user_X_Motion_in[9] == 1'b0)
				user_address=user_address_right;
			else 
				if ( user_X_Motion[9] == 1'b1)
					user_address=user_address_left;
				else 
					user_address=user_address_right;
					
	
        // By default, keep motion and position unchanged
        user_X_Pos_in = user_X_Pos;
        user_Y_Pos_in = user_Y_Pos;
        user_X_Motion_in = user_X_Motion;
        user_Y_Motion_in = user_Y_Motion;
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin

				
			case(keycode)
				 	// key A, clear y directional motion and moving left
				 	8'h04: begin
				 				user_X_Motion_in = (~(user_X_Step) + 1'b1);
				 				user_Y_Motion_in = 10'h000;
				 			end
							
				 	// key D, clear y directional motion and moving right
				 	8'h07: begin
				 				user_X_Motion_in = user_X_Step;
				 				user_Y_Motion_in = 10'h000;
				 			end
					
				 	// key W, clear x directional motion and moving up
				 	8'h1a: begin
				 				user_X_Motion_in = 10'h000;
				 				user_Y_Motion_in = (~(user_Y_Step) + 1'b1);
				 			end
					
				 	// key S, clear x directional motion and moving down
				 	8'h16: begin
				 				user_X_Motion_in = 10'h000;
				 				user_Y_Motion_in = user_Y_Step;
				 			end
							
				 	// default does nothing
				 	default:
				 		begin
							case(keycode_0)
				 	// key A, clear y directional motion and moving left
							8'h04: begin
									user_X_Motion_in = (~(user_X_Step) + 1'b1);
									user_Y_Motion_in = 10'h000;
				 			end
							
				 	// key D, clear y directional motion and moving right
							8'h07: begin
									user_X_Motion_in = user_X_Step;
									user_Y_Motion_in = 10'h000;
				 			end
					
				 	// key W, clear x directional motion and moving up
							8'h1a: begin
									user_X_Motion_in = 10'h000;
									user_Y_Motion_in = (~(user_Y_Step) + 1'b1);
				 			end
					
				 	// key S, clear x directional motion and moving down
							8'h16: begin
									user_X_Motion_in = 10'h000;
									user_Y_Motion_in = user_Y_Step;
				 			end
							
				 	// default does nothing
						default:
							begin
							end
							endcase	
				 		end
				endcase

				
            // Be careful when using comparators with "logic" datatype because compiler treats 
            //   both sides of the operator as UNSIGNED numbers.
            // e.g. user_Y_Pos - user_Size <= user_Y_Min 
            // If user_Y_Pos is 0, then user_Y_Pos - user_Size will not be -4, but rather a large positive number.
            if( user_Y_Pos + user_sizeY >= user_Y_Max )  // user is at the bottom edge, BOUNCE!
                user_Y_Motion_in = (~(user_Y_Step) + 1'b1);  // 2's complement.  
            else if ( user_Y_Pos <= user_Y_Min + user_sizeY )  // user is at the top edge, BOUNCE!
                user_Y_Motion_in = user_Y_Step;
					 
            // TODO: Add other boundary detections and handle keypress here.
        
            if( user_X_Pos + user_sizeX >= user_X_Max )  // user is at the right edge, BOUNCE!
                user_X_Motion_in = (~(user_X_Step) + 1'b1);  // 2's complement.  
            else if ( user_X_Pos <= user_X_Min + user_sizeX )  // user is at the left edge, BOUNCE!
                user_X_Motion_in = user_X_Step;
					 
            // Update the user's position with its motion
				
				
            
				
				if (is_start == 1)
				begin
					user_X_Pos_in = user_X_Pos + user_X_Motion_in;
					user_Y_Pos_in = user_Y_Pos + user_Y_Motion_in;
            end
				else
				begin
					user_X_Pos_in = user_X_Pos;
					user_Y_Pos_in = user_Y_Pos;
            end
				
        end
        
			
				
			
    end
    
		logic is_user_temp;
		logic [18:0] read_user_address;
		logic	[9:0] 	left, up;
		logic	[9:0] 	tempX, tempY;
		//logic				user_on;
		always_comb
		begin
			left	= user_X_Pos - user_sizeX/2;
			up		= user_Y_Pos - user_sizeY/2;
			tempX	=	DrawX - left;
			tempY	=	DrawY - up;
			if (tempX >= 0 && tempX < user_sizeX && tempY >= 0 && tempY < user_sizeY) 
				is_user_temp = 1'b1;
			else 
				is_user_temp = 1'b0;
			if(is_user_temp == 1'b1)
				read_user_address	=	tempY * user_sizeX + tempX;
			else
				read_user_address	=	19'd0;//FFFFFF, white
				
			if( user_address != 0)
				is_user=is_user_temp;
			else
				is_user=1'b0;
			
			
			//compute the exist, eat?
			//compute the exist, eat?
			if(is_shark && is_user && (is_start==1))
				hit_in=1'b1;
			else
				hit_in=hit;
			if (hit==1)	
				user_exist_in=1'b1;
			else
				user_exist_in=user_exist;
			
				
		end
		
 
endmodule
