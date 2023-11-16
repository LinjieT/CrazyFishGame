
module  fish_left_RAM
(
		input [18:0] read_address,
		input Clk,
		output logic [3:0] fish_address
);

// mem has width of 4 bits and a total of 307200 addresses
//logic [3:0] mem [0:307199];
logic [3:0] fish_mem [0:1023];
initial
begin
	 $readmemh("picture/fish_left.txt", fish_mem);
end


always_ff @ (posedge Clk) begin
	fish_address<= fish_mem[read_address];
end

endmodule


module  fish_right_RAM
(
		input [18:0] read_address,
		input Clk,
		output logic [3:0] fish_address
);

// mem has width of 4 bits and a total of 307200 addresses
//logic [3:0] mem [0:307199];
logic [3:0] fish_mem [0:1023];
initial
begin
	 $readmemh("picture/fish_right.txt", fish_mem);
end


always_ff @ (posedge Clk) begin
	fish_address<= fish_mem[read_address];
end

endmodule



module  shark_left_RAM
(
		input [18:0] read_address,
		input Clk,
		output logic [3:0] shark_address
);

// mem has width of 4 bits and a total of 307200 addresses
//logic [3:0] mem [0:307199];
logic [3:0] shark_mem [0:49151];
initial
begin
	 $readmemh("picture/shark_left.txt", shark_mem);
end


always_ff @ (posedge Clk) begin
	shark_address<= shark_mem[read_address];
end

endmodule


module  shark_right_RAM
(
		input [18:0] read_address,
		input Clk,
		output logic [3:0] shark_address
);

// mem has width of 4 bits and a total of 307200 addresses
//logic [3:0] mem [0:307199];
logic [3:0] shark_mem [0:49151];
initial
begin
	 $readmemh("picture/shark_right.txt", shark_mem);
end


always_ff @ (posedge Clk) begin
	shark_address<= shark_mem[read_address];
end

endmodule
