//-------------------------------------------------------------------------
//      lab8.sv                                                          --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Modified by Po-Han Huang                                         --
//      10/06/2017                                                       --
//                                                                       --
//      Fall 2017 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 8                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module final_project( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1,
				 output logic [7:0]  LEDG,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA virtical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
             input               OTG_INT,      //CY7C67200 Interrupt
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK      //SDRAM Clock
                    );
    
    logic Reset_h, Clk;
    logic [7:0] keycode,keycode_0;
	 logic [7:0] led;
    
    assign Clk = CLOCK_50;
    always_ff @ (posedge Clk) begin
        Reset_h <= ~(KEY[0]);        // The push buttons are active low
		  LEDG <= led;
    end
    
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs, hpi_reset;
    
	 
	 logic [9:0] DrawX, DrawY;
	 
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            .from_sw_reset(hpi_reset),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),
                            .OTG_RST_N(OTG_RST_N)
    );
     
     // You need to make sure that the port names here match the ports in Qsys-generated codes.
     final_project_soc nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(1'b1),    // Never reset NIOS
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_0_export(keycode_0),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
                             .otg_hpi_reset_export(hpi_reset)
    );
    
    // Use PLL to generate the 25MHZ VGA_CLK.
    // You will have to generate it on your own in simulation.
    vga_clk vga_clk_instance(.inclk0(Clk), .c0(VGA_CLK));
    
    // TODO: Fill in the connections for the rest of the modules 
    VGA_controller vga_controller_instance(.Clk, 
														 .Reset(Reset_h), 
														 .VGA_HS, 
														 .VGA_VS,
														 .VGA_CLK,
														 .VGA_BLANK_N,
														 .VGA_SYNC_N,
														 .DrawX,
														 .DrawY);
														 
						
		logic [9:0] user1_X_Pos,user1_Y_Pos;
		logic [9:0] user2_X_Pos,user2_Y_Pos;
								
		logic start_address,user1win_address,user2win_address;
		logic	is_start=1'b0,is_user1win,is_user2win;											 
														 
		controller controller_inst(.*,.Reset(Reset_h));										 
		
		
		logic [7:0] score1=0,score2=0;
		
		assign score1=user1_eat_fish1+user1_eat_fish2+user1_eat_fish3+user1_eat_fish4+user1_eat_fish5+user1_eat_fish6+user1_eat_fish7+user1_eat_fish8+user1_eat_fish9;
		assign score2=user2_eat_fish1+user2_eat_fish2+user2_eat_fish3+user2_eat_fish4+user2_eat_fish5+user2_eat_fish6+user2_eat_fish7+user2_eat_fish8+user2_eat_fish9;

//		assign score1=8'd0;	
//		assign score2=8'd1;		
	 
		logic user1_eat_fish1,user1_eat_fish2,user1_eat_fish3,user1_eat_fish4,user1_eat_fish5,user1_eat_fish6,user1_eat_fish7,user1_eat_fish8,user1_eat_fish9;
      logic user2_eat_fish1,user2_eat_fish2,user2_eat_fish3,user2_eat_fish4,user2_eat_fish5,user2_eat_fish6,user2_eat_fish7,user2_eat_fish8,user2_eat_fish9;
			
		//counter counter_inst(.*,.Reset(Reset_h));
		
		color_mapper color_instance(.*);
	 
		
		logic [3:0] title_address;
		logic is_title;
		title title_instance(.*);
		
		logic [3:0] background_address;
		logic is_background;
		background background_instance(.*);
	 
		//logic [23:0]user1_RGB;
		logic [3:0] user1_address;
		logic is_user1;//,user1_check
		logic user1_exist;
		//assign user1_exist=1'b0;

	 
		user user1(.*, .Reset(Reset_h), .frame_clk(VGA_VS),
						.is_shark(is_shark1),
						.user_address(user1_address),
						.user_exist(user1_exist),
						.is_user(is_user1),
						.user_X_Pos(user1_X_Pos),
						.user_Y_Pos(user1_Y_Pos)
						);

		//logic [23:0]user2_RGB;
		logic [3:0] user2_address;
		logic is_user2;//,user1_check
		logic user2_exist;
		//assign user2_exist=1'b0;

		user_2 user2(.*, .Reset(Reset_h), .frame_clk(VGA_VS),
						.is_shark(is_shark1),
						.user_address(user2_address),
						.user_exist(user2_exist),
						.is_user(is_user2),
						.user_X_Pos(user2_X_Pos),
						.user_Y_Pos(user2_Y_Pos)
						);
	

		//logic [23:0]fish1_RGB;
		
		
		logic [3:0] fish1_address,fish2_address,fish3_address,fish4_address,fish5_address,fish6_address,fish7_address,fish8_address,fish9_address;
		logic is_fish1,is_fish2,is_fish3,is_fish4,is_fish5,is_fish6,is_fish7,is_fish8,is_fish9;//,user1_check
		logic fish1_exist,fish2_exist,fish3_exist,fish4_exist,fish5_exist,fish6_exist,fish7_exist,fish8_exist,fish9_exist;
		//assign fish1_exist=1'b0;
		
		//logic [23:0]shark1_RGB;
		logic [3:0] shark1_address;
		logic is_shark1;//,user1_check
		logic shark1_exist;
		//assign shark1_exist=1'b0;

		fish_top fish_top1(.*, .Reset(Reset_h), .frame_clk(VGA_VS));
			
		logic [3:0] score1_address;
		logic [3:0] score2_address;
								
								
								
    // Display keycode on hex display
    HexDriver hex_inst_0 ({user1_eat_fish1,user1_eat_fish2,user1_eat_fish3,user1_eat_fish4}, HEX0);
    HexDriver hex_inst_1 ({user2_eat_fish1,user2_eat_fish2,user2_eat_fish3,user2_eat_fish4}, HEX1);
    /**************************************************************************************
        ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
        Hidden Question #1/2:
        What are the advantages and/or disadvantages of using a USB interface over PS/2 interface to
             connect to the keyboard? List any two.  Give an answer in your Post-Lab.
    **************************************************************************************/
endmodule
