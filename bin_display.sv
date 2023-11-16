//takes input of current score. outputs the addresses of the digits in the numbers rom
module number_display (
								input [7:0] number,
								output [7:0] number_address
								);

	always_comb
	begin

		case(number)//user1
		
			8'd0: number_address = 8'd0;
			
			8'd1: number_address = 8'd16;
			
			8'd2: number_address = 8'd32;
			
			8'd3: number_address = 8'd48;

			8'd4: number_address = 8'd64;
			
			8'd5: number_address = 8'd80;
			
			8'd6: number_address = 8'd96;
			
			8'd7: number_address = 8'd112;
			
			8'd8: number_address = 8'd128;
			
			8'd9: number_address = 8'd144;
			
			default:number_address = 8'd0;
			
		endcase
		
	end
	
endmodule 
