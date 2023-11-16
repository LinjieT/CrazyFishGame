
//use 0 and 1 to plot the score

module numbers (
					input [7:0] address,
					output [7:0] data
				);
	
	logic [255:0][7:0] ROM = 
	{

		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00011110,
		8'b00110000,
		8'b01100000,
		8'b01100000,
		8'b01100000,
		8'b01111110,
		8'b01100011,
		8'b01100011,
		8'b01100011,
		8'b00111110,
		8'b00000000,
		8'b00000000,

		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00111110,
		8'b01100011,
		8'b01100011,
		8'b01100011,
		8'b01100011,
		8'b00111110,
		8'b01100011,
		8'b01100011,
		8'b01100011,
		8'b00111110,
		8'b00000000,
		8'b00000000,

		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00001100,
		8'b00001100,
		8'b00001100,
		8'b00001100,
		8'b00011000,
		8'b00110000,
		8'b01100000,
		8'b01100000,
		8'b01100011,
		8'b01111111,
		8'b00000000,
		8'b00000000,

		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00111110,
		8'b01100011,
		8'b01100011,
		8'b01100011,
		8'b01100011,
		8'b00111111,
		8'b00000011,
		8'b00000011,
		8'b00000110,
		8'b00011100,
		8'b00000000,
		8'b00000000,

		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00111110,
		8'b01100011,
		8'b01100000,
		8'b01100000,
		8'b01100000,
		8'b00111111,
		8'b00000011,
		8'b00000011,
		8'b00000011,
		8'b01111111,
		8'b00000000,
		8'b00000000,

		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b01111000,
		8'b00110000,
		8'b00110000,
		8'b00110000,
		8'b01111111,
		8'b00110011,
		8'b00110110,
		8'b00111100,
		8'b00111000,
		8'b00110000,
		8'b00000000,
		8'b00000000,

		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00111110,
		8'b01100011,
		8'b01100000,
		8'b01100000,
		8'b01100000,
		8'b00111100,
		8'b01100000,
		8'b01100000,
		8'b01100011,
		8'b00111110,
		8'b00000000,
		8'b00000000,

		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b01111111,
		8'b01100011,
		8'b00000011,
		8'b00000110,
		8'b00001100,
		8'b00011000,
		8'b00110000,
		8'b01100000,
		8'b01100011,
		8'b00111110,
		8'b00000000,
		8'b00000000,

		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b01111110,
		8'b00011000,
		8'b00011000,
		8'b00011000,
		8'b00011000,
		8'b00011000,
		8'b00011000,
		8'b00011110,
		8'b00011100,
		8'b00011000,
		8'b00000000,
		8'b00000000,

		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00000000,
		8'b00111110,
		8'b01100011,
		8'b01100011,
		8'b01100111,
		8'b01101111,
		8'b01111011,
		8'b01110011,
		8'b01100011,
		8'b01100011,
		8'b00111110,
		8'b00000000
		
	};
	
	assign data = ROM[address];

endmodule 







module alarm (
					input [4:0] address,
					output [63:0] data
				);
	
	logic [31:0][63:0] ROM = 
	{
			64'b1111111111111111111111111111111111111111111111111111111111111111,
			64'b1111111111111111111111111111111111111111111111111111111111111111,
			64'b0111111111111111111111111111111111111111111111111111111111111110,
			64'b0111111111000000000000000000000000000000000000000000001111111110,
			64'b0011111111100000000000000000000000000000000000000000011111111100,
			64'b0011111111100000000000000000011111100000000000000000011111111100,
			64'b0001111111111000000000000000011111100000000000000000111111111000,
			64'b0001111111111000000000000000011111100000000000000000111111111000,
			64'b0000111111111100000000000000011111100000000000000001111111110000,
			64'b0000111111111100000000000000011111100000000000000001111111110000,
			64'b0000011111111110000000000000011111100000000000000011111111100000,
			64'b0000011111111110000000000000000000000000000000000011111111100000,
			64'b0000001111111111000000000000000000000000000000000111111111000000,
			64'b0000001111111111000000000000000000000000000000000111111111000000,
			64'b0000000111111111100000000000000000000000000000001111111110000000,
			64'b0000000111111111100000000000011111100000000000001111111110000000,
			64'b0000000011111111110000000000011111100000000000011111111100000000,
			64'b0000000011111111110000000000011111100000000000011111111100000000,
			64'b0000000001111111111000000000011111100000000000111111111000000000,
			64'b0000000001111111111000000000011111100000000000111111111000000000,
			64'b0000000000111111111100000000011111100000000001111111110000000000,
			64'b0000000000111111111100000000011111100000000001111111110000000000,
			64'b0000000000011111111110000000011111100000000011111111100000000000,
			64'b0000000000011111111110000000011111100000000011111111100000000000,
			64'b0000000000001111111111000000011111100000000111111111000000000000,
			64'b0000000000001111111111000000011111100000000111111111000000000000,
			64'b0000000000000111111111100000011111100000001111111110000000000000,
			64'b0000000000000111111111100000011111100000001111111110000000000000,
			64'b0000000000000011111111110000011111100000011111111100000000000000,
			64'b0000000000000011111111110000011111100000011111111100000000000000,
			64'b0000000000000001111111111000011111100000111111111000000000000000,
			64'b0000000000000001111111111000011111100000111111111000000000000000,
			64'b0000000000000000111111111000011111100001111111110000000000000000,
			64'b0000000000000000011111111100000000000011111111100000000000000000,
			64'b0000000000000000001111111110000000000111111111000000000000000000,
			64'b0000000000000000000111111111000000001111111110000000000000000000,
			64'b0000000000000000000011111111100000011111111100000000000000000000,
			64'b0000000000000000000001111111111111111111111000000000000000000000,
			64'b0000000000000000000000111111111111111111110000000000000000000000,
			64'b0000000000000000000000011111111111111111100000000000000000000000
             
	};
	
	assign data = ROM[address];
	
endmodule 





