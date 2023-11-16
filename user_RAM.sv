
module  user_left_RAM
(
		input [18:0] read_address,
		input Clk,
		output logic [3:0] user_address
);

// mem has width of 4 bits and a total of 307200 addresses
//logic [3:0] mem [0:307199];
logic [3:0] user_mem [0:3071];
initial
begin
	 $readmemh("picture/user1_left.txt", user_mem);
end


always_ff @ (posedge Clk) begin
	user_address<= user_mem[read_address];
end

endmodule


module  user_right_RAM
(
		input [18:0] read_address,
		input Clk,
		output logic [3:0] user_address
);

// mem has width of 4 bits and a total of 307200 addresses
//logic [3:0] mem [0:307199];
logic [3:0] user_mem [0:3071];
initial
begin
	 $readmemh("picture/user1_right.txt", user_mem);
end


always_ff @ (posedge Clk) begin
	user_address<= user_mem[read_address];
end

endmodule



module  user2_left_RAM
(
		input [18:0] read_address,
		input Clk,
		output logic [3:0] user_address
);

// mem has width of 4 bits and a total of 307200 addresses
//logic [3:0] mem [0:307199];
logic [3:0] user_mem [0:3071];
initial
begin
	 $readmemh("picture/user2_left.txt", user_mem);
end


always_ff @ (posedge Clk) begin
	user_address<= user_mem[read_address];
end

endmodule



module  user2_right_RAM
(
		input [18:0] read_address,
		input Clk,
		output logic [3:0] user_address
);

// mem has width of 4 bits and a total of 307200 addresses
//logic [3:0] mem [0:307199];
logic [3:0] user_mem [0:3071];
initial
begin
	 $readmemh("picture/user2_right.txt", user_mem);
end


always_ff @ (posedge Clk) begin
	user_address<= user_mem[read_address];
end

endmodule