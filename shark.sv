

module  shark (  	input Clk,                // 50 MHz clock
                        Reset,              // Active-high reset signal
                        frame_clk,          // The clock indicating a new frame (~60Hz)
								
						input [9:0]   DrawX, DrawY,       // Current pixel coordinates
						
						//input is_user1,is_user2,
						input is_start,
						output shark_exist,
						output is_shark,          // check if shark 
						output [3:0] shark_address,
						input [9:0] user1_X_Pos,user1_Y_Pos,
						input [9:0] user2_X_Pos,user2_Y_Pos
              );
    
    parameter [9:0] shark_X_Center = 10'd400;  // Center position on the X axis
    parameter [9:0] shark_Y_Center = 10'd400;  // Center position on the Y axis
    parameter [9:0] shark_X_Min = 10'd0;       // Leftmost point on the X axis
    parameter [9:0] shark_X_Max = 10'd639;     // Rightmost point on the X axis
    parameter [9:0] shark_Y_Min = 10'd48;       // Topmost point on the Y axis
    parameter [9:0] shark_Y_Max = 10'd479;     // Bottommost point on the Y axis
	 
    parameter [9:0] shark_X_Step = 10'd1;      // Step size on the X axis
    parameter [9:0] shark_Y_Step = 10'd1;      // Step size on the Y axis
    //parameter [9:0] shark_Size = 10'd4;      // shark size
	parameter [9:0] shark_sizeX=10'd256;
	parameter [9:0] shark_sizeY=10'd192;
   
	
		logic [9:0] shark_X_Pos,shark_Y_Pos;
		logic [9:0] shark_X_Pos_in, shark_X_Motion_in, shark_Y_Pos_in, shark_Y_Motion_in;
    
	 
		logic [9:0] shark_X_Motion=0, shark_Y_Motion=0;

	 
		logic [3:0] shark_address_left, shark_address_right;
		
		shark_left_RAM shark_left(.*,.shark_address(shark_address_left),.read_address(read_shark_address));
		
		shark_right_RAM shark_right(.*,.shark_address(shark_address_right),.read_address(read_shark_address));
	 
	 
	 
    //////// Do not modify the always_ff blocks. ////////
    // Detect rising edge of frame_clk
    logic frame_clk_delayed, frame_clk_rising_edge;
    always_ff @ (posedge Clk) begin
        frame_clk_delayed <= frame_clk;
        frame_clk_rising_edge <= (frame_clk == 1'b1) && (frame_clk_delayed == 1'b0);
    end
	 
	 
	 
	 always_ff @ (posedge Clk)
    begin
        if (Reset)
        begin
            shark_X_Pos <= shark_X_Center;
            shark_Y_Pos <= shark_Y_Center;
            shark_X_Motion <= shark_X_Step;
            shark_Y_Motion <= shark_Y_Step;
        end
        else
        begin
            shark_X_Pos <= shark_X_Pos_in;
            shark_Y_Pos <= shark_Y_Pos_in;
            shark_X_Motion <= shark_X_Motion_in;
            shark_Y_Motion <= shark_Y_Motion_in;
        end
		  
	end
	 
	  // You need to modify always_comb block.
    always_comb
    begin

			if ( shark_X_Motion_in[9] == 1'b1)
				shark_address=shark_address_left;
			else if ( shark_X_Motion_in[9] == 1'b0)
				shark_address=shark_address_right;
			else 
				if (  shark_X_Motion[9] == 1'b1)
					shark_address=shark_address_left;
				else 
					shark_address=shark_address_right;
			
        // By default, keep motion and position unchanged
        shark_X_Pos_in = shark_X_Pos;
        shark_Y_Pos_in = shark_Y_Pos;
        shark_X_Motion_in = shark_X_Motion;
        shark_Y_Motion_in = shark_Y_Motion;
		  
		  
        // Update position and motion only at rising edge of frame clock
        if (frame_clk_rising_edge)
        begin
		  
		  
			if( user1_Y_Pos > user2_Y_Pos)
			begin
				if( shark_Y_Pos > user1_Y_Pos  ) 
                shark_Y_Motion_in = (~(shark_Y_Step) + 1'b1);  // 2's complement. 
				else if ( shark_Y_Pos < user1_Y_Pos  )
					shark_Y_Motion_in = shark_Y_Step;
				else 
					shark_Y_Motion_in = 0;
					
				
				if( shark_X_Pos > user1_X_Pos  )  
                shark_X_Motion_in = (~(shark_X_Step) + 1'b1);  // 2's complement. 
				else if ( shark_X_Pos < user1_X_Pos  )
					shark_X_Motion_in = shark_X_Step;
				else 
					shark_X_Motion_in = 0;
			end
			else
			begin
				if( shark_Y_Pos > user2_Y_Pos  ) 
                shark_Y_Motion_in = (~(shark_Y_Step) + 1'b1);  // 2's complement. 
				else if ( shark_Y_Pos < user2_Y_Pos  )
					shark_Y_Motion_in = shark_Y_Step;
				else 
					shark_Y_Motion_in = 0;
					
				
				if( shark_X_Pos > user2_X_Pos  )  
                shark_X_Motion_in = (~(shark_X_Step) + 1'b1);  // 2's complement. 
				else if ( shark_X_Pos < user2_X_Pos  )
					shark_X_Motion_in = shark_X_Step;
				else 
					shark_X_Motion_in = 0;
			end
				
				
				
				
            if( shark_Y_Pos + shark_sizeY >= shark_Y_Max + 90  )  // shark is at the bottom edge, BOUNCE!
                shark_Y_Motion_in = (~(shark_Y_Step) + 1'b1);  // 2's complement.  
            else if ( shark_Y_Pos + 90 <= shark_Y_Min + shark_sizeY )  // shark is at the top edge, BOUNCE!
                shark_Y_Motion_in = shark_Y_Step;
            if( shark_X_Pos + shark_sizeX >= shark_X_Max + 120)  // shark is at the right edge, BOUNCE!
                shark_X_Motion_in = (~(shark_X_Step) + 1'b1);  // 2's complement.  
            else if ( shark_X_Pos + 120 <= shark_X_Min + shark_sizeX )  // shark is at the left edge, BOUNCE!
                shark_X_Motion_in = shark_X_Step;
					 
            // Update the shark's position with its motion
				if (is_start == 1)
				begin
					shark_X_Pos_in = shark_X_Pos + shark_X_Motion_in;
					shark_Y_Pos_in = shark_Y_Pos + shark_Y_Motion_in;
            end
				else
				begin
					shark_X_Pos_in = shark_X_Pos;
					shark_Y_Pos_in = shark_Y_Pos;
            end
		end
		  
		  
				
        
    end
		//assign shark_address=shark_address_left;
		//assign shark_address=shark_address_right;
		
		//assign shark_X_Pos=shark_X_Center;
		//assign shark_Y_Pos=shark_Y_Center;
	
		logic is_shark_temp;
		
		logic [18:0] read_shark_address;
		logic	[9:0] 	left, up;
		logic	[9:0] 	tempX, tempY;
		//logic				shark_on;
		always_comb
		begin
			left	= shark_X_Pos - shark_sizeX/2;
			up		= shark_Y_Pos - shark_sizeY/2;
			tempX	=	DrawX - left;
			tempY	=	DrawY - up;
			if (tempX >= 0 && tempX < shark_sizeX && tempY >= 0 && tempY < shark_sizeY) 
				is_shark_temp = 1'b1;
			else 
				is_shark_temp = 1'b0;
			if(is_shark_temp == 1'b1)
				read_shark_address	=	tempY * shark_sizeX + tempX ;
			else
				read_shark_address	=	19'd0;//FFFFFF, white
				
			if( shark_address != 0)
				is_shark=is_shark_temp;
			else
				is_shark=1'b0;
		end
		
 
endmodule
