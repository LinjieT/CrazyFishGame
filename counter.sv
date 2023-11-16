//module counter (
//input logic Reset,
//input logic Clk,
//
//input logic user1_eat_fish1,user1_eat_fish2,user1_eat_fish3,user1_eat_fish4,user1_eat_fish5,user1_eat_fish6,user1_eat_fish7,user1_eat_fish8,user1_eat_fish9,
//input logic user2_eat_fish1,user2_eat_fish2,user2_eat_fish3,user2_eat_fish4,user2_eat_fish5,user2_eat_fish6,user2_eat_fish7,user2_eat_fish8,user2_eat_fish9,
////the bumber of fish each user eat
//output logic [7:0] score1,
//output logic [7:0] score2
//
//
//);
//
//
//	assign score1=user1_eat_fish1+user1_eat_fish2+user1_eat_fish3+user1_eat_fish4+user1_eat_fish5+user1_eat_fish6+user1_eat_fish7+user1_eat_fish8+user1_eat_fish9;
//	assign score2=user2_eat_fish1+user2_eat_fish2+user2_eat_fish3+user2_eat_fish4+user2_eat_fish5+user2_eat_fish6+user2_eat_fish7+user2_eat_fish8+user2_eat_fish9;
//
//endmodule
////
//module count_time (	
//			input logic Reset,
//			input logic Clk,
//
//			//the bumber of fish each user eat
//			)
//output logic t0, t1, t2, t3, t4, t5, gg1
//logic [32:0] count;

////logic addingfirst;
//
//always_ff @ (posedge Clk)
//begin
//   if (Reset) begin
//	   t0 <= 1'b0;
//		t1 <= 1'b0;
//		t2 <= 1'b0;
//		t3 <= 1'b0;
//		t4 <= 1'b0;
//		t5 <= 1'b0;
//		gg1 <= 1'b0;
//		count <= 33'b0;
////		addingfirst <= 1'b0;
//		end
//	else begin
//	   t0 <= t0_temp;
//		t1 <= t1_temp;
//		t2 <= t2_temp;
//		t3 <= t3_temp;
//		t4 <= t4_temp;
//		t5 <= t5_temp;
//		gg1 <= gg1_temp;
//		
////		if (adding_on && (count > 2**30))
////		begin
////		count <= count - 2**30;
////		addingfirst <= 1'b1;
////		end
//		if (~t5)
//		begin
//		count <= count + 1;
//		end
//		end
//end

