/*
 * ECE385-HelperTools/PNG-To-Txt
 * Author: Rishi Thakkar
 *
 */
module background (
	input Clk, 
	//input background_exist,
	input		[9:0] DrawX, DrawY,
	output 	[3:0] background_address,
	output 			is_background
);
	// screen size
	parameter [9:0] SCREEN_WIDTH =  10'd480;
   parameter [9:0] SCREEN_LENGTH = 10'd640;
	parameter  scale =  10'd2;
	parameter [9:0] RESHAPE_LENGTH = SCREEN_LENGTH/scale;

	logic [18:0] read_address;
	
	assign read_address = DrawX/scale + DrawY/scale*RESHAPE_LENGTH;//row, col, 4 pixel 1 color
	
	//assign read_address = DrawX + DrawY*SCREEN_LENGTH;//SCREEN_LENGTH
	background_RAM background_RAM_inst(.*);

//
//always_comb begin
//	is_background = 1'b0;
//	if (background_exist == 1'b1)
//		is_background = 1'b1;
//end
assign is_background = 1'b1;
endmodule

module  background_RAM
(
		input [18:0] read_address,
		input Clk,

		output [3:0] background_address
);

// mem has width of 4 bits and a total of 307200 addresses
//logic [3:0] mem [0:307199];
logic [3:0] background_mem [0:76799];
initial
begin
	 $readmemh("picture/bg_final.txt", background_mem);
end


always_ff @ (posedge Clk) begin
	background_address<= background_mem[read_address];
end

endmodule




module title (
	input Clk, 
	//input background_exist,
	input		[9:0] DrawX, DrawY,
	output 	[3:0] title_address,
	output 			is_title
);
	logic [18:0] read_address;
	
	logic	[9:0] 	left, up;
	logic	[9:0] 	tempX, tempY;

	always_comb
	begin
		left	= 270;
		up		= 0;
		tempX	=	DrawX - left;
		tempY	=	DrawY - up;
		if (tempX >= 0 && tempX < 100 && tempY > 0 && tempY <= 48) 
			is_title = 1'b1;
		else 
			is_title = 1'b0;
		if(is_title == 1'b1)
			read_address	=	tempY * 100 + tempX;
		else
			read_address	=	19'd0;//FFFFFF, white
	end	
		
	title_RAM title_RAM_inst(.*);
		
		
		
endmodule




module  title_RAM
(
		input [18:0] read_address,
		input Clk,

		output [3:0] title_address
);

// mem has width of 4 bits and a total of 307200 addresses
//logic [3:0] mem [0:307199];
logic [3:0] title_mem [0:4799];
initial
begin
	 $readmemh("picture/feed.txt", title_mem);
end


always_ff @ (posedge Clk) begin
	title_address<= title_mem[read_address];
end

endmodule

