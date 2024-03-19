//`timescale 1ns/1ps

//module slc3_tb;

//    logic Clk;
//    logic reset;
//    logic run_i;
//    logic continue_i;
//    logic [15:0] sw_i;
//    logic [15:0] sram_rdata;

//    logic [15:0] led_o;
//    logic [7:0] hex_seg_o;
//    logic [3:0] hex_grid_o;
//    logic [7:0] hex_seg_debug;
//    logic [3:0] hex_grid_debug;
//    logic [15:0] sram_wdata;
//    logic [15:0] sram_addr;
//    logic sram_mem_ena;
//    logic sram_wr_ena;
    
////     logic [15:0] led_o;
//	logic [7:0]  hex_seg_left;
//	logic [3:0]  hex_grid_left;
//	logic [7:0]  hex_seg_right;
//    logic [3:0]  hex_grid_right;

////    slc3 uut (
////        .clk(Clk),
////        .reset(reset),
////        .run_i(run_i),
////        .continue_i(continue_i),
////        .sw_i(sw_i),
////        .led_o(led_o),
////        .hex_seg_o(hex_seg_o),
////        .hex_grid_o(hex_grid_o),
////        .hex_seg_debug(hex_seg_debug),
////        .hex_grid_debug(hex_grid_debug),
////        .sram_rdata(sram_rdata),
////        .sram_wdata(sram_wdata),
////        .sram_addr(sram_addr),
////        .sram_mem_ena(sram_mem_ena),
////        .sram_wr_ena(sram_wr_ena)
////    );

        
//    processor_top processor_tb(
//       .clk(Clk),
//       .*
//    );
    
//	initial begin: CLOCK_INITIALIZATION
//		Clk = 1;
//	end 

//	always begin : CLOCK_GENERATION
//		#1 Clk = ~Clk;
//	end

//    initial begin
               
//        reset = 1;
//        run_i = 0;
//        continue_i = 0;
//        sw_i = 0;
////        sram_rdata = 0;

//        #10;
//        reset = 0;

//        #10;
//        sw_i = 16'hA5A5;
//        run_i = 1;
//        #10;
//        run_i = 0;
        
//        #20;
//        continue_i = 1;
//        #20;
//        continue_i = 0;
        
//      #20;
//        continue_i = 1;
//        #20;
//        continue_i = 0;
//          #20;
//        continue_i = 1;
//        #20;
//        continue_i = 0;
            
//        #1000;
//        $finish;
//    end

//    initial begin
//        $monitor("Time=%0t clk=%0b reset=%0b run_i=%0b continue_i=%0b led_o=%h hex_seg_o=%h hex_grid_o=%h sram_addr=%h sram_wdata=%h sram_mem_ena=%b sram_wr_ena=%b",
//                 $time, Clk, reset, run_i, continue_i, led_o, hex_seg_o, hex_grid_o, sram_addr, sram_wdata, sram_mem_ena, sram_wr_ena);
//    end

//endmodule




module testbench();
    timeunit 10ns;    // This is the amount of time represented by #1 
    timeprecision 1ns;
    
    logic		clk; 
	logic 		reset; // this is a button

	logic 		run_i; // this is a button
	logic 		continue_i; //this is a button
	logic [15:0] sw_i; // these are switches

	logic [15:0] led_o;
	logic [7:0]  hex_seg_left;
	logic [3:0]  hex_grid_left;
	logic [7:0]  hex_seg_right;
	logic [3:0]  hex_grid_right;
	
	processor_top processor(.*);
	
	initial begin: CLOCK_INITIALIZATION
        clk = 1;
    end
    
    always begin: CLOCK_GENERATION
        #1 clk = ~clk;
    end
    
    initial begin: TEST_VECTORS

    reset<= 1'b1;
    continue_i <= 1'b0;
    repeat (4) @(posedge clk);
    reset <= 1'b0;
    
    sw_i <= 16'h000b;
    repeat (4) @(posedge clk);
    
    run_i <= 1'b1;
    repeat (4) @ (posedge clk);
    run_i <= 1'b0;
    repeat(4) @(posedge clk);
    
//    continue_i = 1;
//    repeat (4) @ (posedge clk);
//    continue_i = 0;
//    repeat (4) @ (posedge clk);
    
//    continue_i = 1;
//    repeat (4) @ (posedge clk);
//    continue_i = 0;
//    repeat (4) @ (posedge clk);
    
//    continue_i = 1;
//    repeat (4) @ (posedge clk);
//    continue_i = 0;
//    repeat (4) @ (posedge clk);
    
    
       
//       #15 continue_i = 1;
//       #15 continue_i = 0;
       
//       #15 continue_i = 1;
//       #15 continue_i = 0;
       
//       #15 continue_i = 1;
//       #15 continue_i = 0;
       
 
    repeat (50) @ (posedge clk);

     sw_i <= 16'h0010;
    repeat (50) @(posedge clk);
    continue_i = 1'b1;
 
    repeat(4) @(posedge clk);
    continue_i = 1'b0;
 

    repeat(100) @(posedge clk);
    continue_i = 1'b1;
    
    repeat(4) @(posedge clk);
    continue_i = 1'b0;
        #100 $finish();
    end
    
endmodule