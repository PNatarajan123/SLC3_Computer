module regfile(
    input logic [15:0] bus, 
    input logic [2:0] sr1mux, sr2mux, drmux, 
    input logic ld_reg,
    input logic clk,
    input logic reset,

    output logic [15:0] regout1, regout2
    );

    // only load into drmux if ld_reg is high
    // pick sr2 and sr1 based on sr2mux and sr1mux


    logic [15:0] reg_unit [8]; 

    assign regout1 = reg_unit[sr1mux];
    assign regout2 = reg_unit[sr2mux];
    
    always_ff @ (posedge clk) begin
        if(reset) begin
            reg_unit[0]<=16'h0000;
            reg_unit[1]<=16'h0000;
            reg_unit[2]<=16'h0000;
            reg_unit[3]<=16'h0000;
            reg_unit[4]<=16'h0000;
            reg_unit[5]<=16'h0000;
            reg_unit[6]<=16'h0000;
            reg_unit[7]<=16'h0000;

        end else if(ld_reg) begin
            reg_unit[drmux] <= bus;
        end
    end

    // logic ld1, ld2, ld3, ld4, ld5, ld6, ld7, ld8;
    // logic [15:0] regs [7:0];

    // // logic for the 8 registers
    // always_ff @ (posedge clk) begin
    //     if (reset) begin
    //         for (int i = 0; i < 8; i++) begin
    //             regs[i] <= 16'h0000;
    //         end
    //     end else if (ld_reg) begin
    //         case (drmux)
    //             3'b000: regs[0] <= bus;
    //             3'b001: regs[1] <= bus;
    //             3'b010: regs[2] <= bus;
    //             3'b011: regs[3] <= bus;
    //             3'b100: regs[4] <= bus;
    //             3'b101: regs[5] <= bus;
    //             3'b110: regs[6] <= bus;
    //             3'b111: regs[7] <= bus;
    //             default: // do nothing
    //                 ;
    //         endcase
    //     end
    // end

    // always_comb begin
    //     case (sr1mux)
    //         3'b000: regout1 = regs[0];
    //         3'b001: regout1 = regs[1];
    //         3'b010: regout1 = regs[2];
    //         3'b011: regout1 = regs[3];
    //         3'b100: regout1 = regs[4];
    //         3'b101: regout1 = regs[5];
    //         3'b110: regout1 = regs[6];
    //         3'b111: regout1 = regs[7];
    //         default: regout1 = 0;
    //     endcase

    //     case (sr2mux)
    //         3'b000: regout2 = regs[0];
    //         3'b001: regout2 = regs[1];
    //         3'b010: regout2 = regs[2];
    //         3'b011: regout2 = regs[3];
    //         3'b100: regout2 = regs[4];
    //         3'b101: regout2 = regs[5];
    //         3'b110: regout2 = regs[6];
    //         3'b111: regout2 = regs[7];
    //         default: regout2 = 0;
    //     endcase
    // end
    

    // always_comb begin 
    //     case (drmux) 
    //         3'b000: ld1 = ld_reg;
    //         3'b001: ld2 = ld_reg;
    //         3'b010: ld3 = ld_reg;
    //         3'b011: ld4 = ld_reg;
    //         3'b100: ld5 = ld_reg;
    //         3'b101: ld6 = ld_reg;
    //         3'b110: ld7 = ld_reg;
    //         3'b111: ld8 = ld_reg;
    //         default: ld1 = 1'b0;
    //     endcase
    // end 
    // // 8 registers    
    
    // load_reg #(.DATA_WIDTH(16)) reg1 (
    //     .clk(clk),
    //     .reset(reset),

    //     .load(ld1),
    //     .data_i(bus), // double check

    //     .data_q(r1)
    // );

    // load_reg #(.DATA_WIDTH(16)) reg2 (
    //     .clk(clk),
    //     .reset(reset),

    //     .load(ld2),
    //     .data_i(bus), // double check

    //     .data_q(r2)
    // );

    // load_reg #(.DATA_WIDTH(16)) reg3 (
    //     .clk(clk),
    //     .reset(reset),

    //     .load(ld3),
    //     .data_i(bus), // double check

    //     .data_q(r3)
    // );

    // load_reg #(.DATA_WIDTH(16)) reg4 (
    //     .clk(clk),
    //     .reset(reset),

    //     .load(ld4),
    //     .data_i(bus), // double check

    //     .data_q(r4)
    // );

    // load_reg #(.DATA_WIDTH(16)) reg5 (
    //     .clk(clk),
    //     .reset(reset),

    //     .load(ld5),
    //     .data_i(bus), // double check

    //     .data_q(r5)
    // );

    // load_reg #(.DATA_WIDTH(16)) reg6 (
    //     .clk(clk),
    //     .reset(reset),

    //     .load(ld6),
    //     .data_i(bus), // double check

    //     .data_q(r6)
    // );

    // load_reg #(.DATA_WIDTH(16)) reg7 (
    //     .clk(clk),
    //     .reset(reset),

    //     .load(ld7),
    //     .data_i(bus), // double check

    //     .data_q(r7)
    // );

    // load_reg #(.DATA_WIDTH(16)) reg8 (
    //     .clk(clk),
    //     .reset(reset),

    //     .load(ld8),
    //     .data_i(bus), // double check

    //     .data_q(r8)
    // );


    // always_comb begin
    //     case (sr1mux)
    //         3'b000: regout1 = r1;
    //         3'b001: regout1 = r2;
    //         3'b010: regout1 = r3;
    //         3'b011: regout1 = r4;
    //         3'b100: regout1 = r5;
    //         3'b101: regout1 = r6;
    //         3'b110: regout1 = r7;
    //         3'b111: regout1 = r8;
    //         default: regout1 = 16'bX;
    //     endcase

    //     case (sr2mux)
    //         3'b000: regout2 = r1;
    //         3'b001: regout2 = r2;
    //         3'b010: regout2 = r3;
    //         3'b011: regout2 = r4;
    //         3'b100: regout2 = r5;
    //         3'b101: regout2 = r6;
    //         3'b110: regout2 = r7;
    //         3'b111: regout2 = r8;
    //         default: regout2 = 16'bX;
    //     endcase
    // end
endmodule






// //------------------------------------------------------------------------------
// // Company: 		 UIUC ECE Dept.
// // Engineer:		 Stephen Kempf
// //
// // Create Date:    
// // Design Name:    ECE 385 Given Code - SLC-3 core
// // Module Name:    SLC3
// //
// // Comments:
// //    Revised 03-22-2007
// //    Spring 2007 Distribution
// //    Revised 07-26-2013
// //    Spring 2015 Distribution
// //    Revised 09-22-2015 
// //    Revised 06-09-2020
// //	  Revised 03-02-2021
// //    Xilinx vivado
// //    Revised 07-25-2023 
// //    Revised 12-29-2023
// //------------------------------------------------------------------------------

// module cpu (
//     input   logic        clk,
//     input   logic        reset,

//     input   logic        run_i,
//     input   logic        continue_i,
//     output  logic [15:0] hex_display_debug,
//     output  logic [15:0] led_o,
   
//     input   logic [15:0] mem_rdata,
//     output  logic [15:0] mem_wdata,
//     output  logic [15:0] mem_addr,
//     output  logic        mem_mem_ena,
//     output  logic        mem_wr_ena
// );


// // Internal connections
// logic ld_mar; 
// logic ld_mdr; 
// logic ld_ir; 
// logic ld_ben; 
// logic ld_cc; 
// logic ld_reg; 
// logic ld_pc; 
// logic ld_led;

// logic gate_pc;
// logic gate_mdr;
// logic gate_alu; 
// logic gate_marmux;

// // select bits
// logic [1:0] pcmux;
// logic       drmux;
// logic       sr1mux;
// logic       sr2mux;
// logic       addr1mux;
// logic [1:0] addr2mux; 
// logic [1:0] aluk;
// logic       mio_en;

// // registers
// logic [15:0] mdr_in;
// logic [15:0] mar; 
// logic [15:0] mdr;
// logic [15:0] ir;
// logic [15:0] pc;
// logic ben;


// //  defining bus val and pcmuxout
// logic [15:0] bus, pcmuxout;


// // State machine, you need to fill in the code here as well
// // .* auto-infers module input/output connections which have the same name
// // This can help visually condense modules with large instantiations, 
// // but can also lead to confusing code if used too commonly
// control cpu_control (
//     .*
// );


// // add additional logic for mem mem enable, 33, loading MDR with value at location MAR 

// assign mem_addr = mar; // FIXME: CHANGE THIS
// assign mem_wdata = mdr; // FIXME: CHANGE THIS
// assign led_o = ir;
// assign hex_display_debug = ir;

// // setting mux for loading mdr 
// logic [15:0] mdrmux;


// logic [2:0] drmuxout, sr1muxout;
// logic [15:0] sr2muxout, alumuxout, addr2muxout, addr1muxout;
// logic [2:0] nzp_vals;

// logic [15:0] regout1, regout2;

// Branch_En BR_Enable(.*, .BEN_out(ben));

// // Register File
// regfile regfile_inst (  
//     .bus(bus),
//     .sr1mux(sr1muxout),
//     .sr2mux(ir[2:0]), // FIXME: CHANGE THIS could be sr2muxout
//     .drmux(drmuxout),
//     .ld_reg(ld_reg),
//     .clk(clk),
//     .reset(reset),
//     .regout1(regout1), 
//     .regout2(regout2)  
// );   

// // Destination Register Mux
// bit321mux drmux_inst (
//     .a(ir[11:9]),
//     .b(3'b111), //3'b111
//     .enablebit(drmux),
//     .out(drmuxout) 
// );

// // Source Register 1 Mux
// bit321mux sr1mux_inst (
//     .a(ir[11:9]),
//     .b(ir[8:6]), //ir[8:6]
//     .enablebit(sr1mux),
//     .out(sr1muxout) // goes into register unit 
// );

// // Source Register 2 Mux
// // TODO: change the b input to the correct value so that sr2 output of register
// mux21 sr2mux_inst (
//     .a({{16{ir[4]}}, ir[4:0]}), // FIXME: decide whether inputs need to be changed
//     .b(regout2), 
//     .mio_en(sr2mux), 
//     .out(sr2muxout) 
// );


// // ALU Unit
// // TODO: change the inputs to the correct values for sr2 and sr1
// alu alu_inst (
//     .A(regout1), // sr1
//     .B(sr2muxout), // sr2
//     .aluk(aluk),
//     .R(alumuxout)
// );


// // mdr mux 
// mux21 mdrmux_inst( //TODO: double check this
//     .b(bus),
//     .a(mem_rdata),
//     .mio_en(mio_en),
//     //.out(mdrmux)
//     .out(mdr_in)
// );

// muxadder2 addr2mux_inst(
//     .a({{16{ir[10]}},ir[10:0]}),
//     .b({{16{ir[8]}},ir[8:0]}),
//     .c({{16{ir[5]}},ir[5:0]}),
//     .d({16{0}}),
//     .addr2enable(addr2mux),
//     .out(addr2muxout)
// );


// // Address 1 Mux
// mux21 addr1mux_inst(
//     .a(pc), 
//     .b(regout1), //TODO: implement the output of this in the register file
//     .mio_en(addr1mux),
//     .out(addr1muxout)
// );

// logic [15:0] adderout;

// // always_ff @ (posedge clk)
// // begin
// //     if(reset)
// //         begin
// //             adderout <= 16'h0000;
// //         end
// //     else begin
// //         adderout <= addr1muxout + addr2muxout;
// //     end
// // end

// assign adderout = addr1muxout + addr2muxout;

// // Update the instantiations of this 
// BUSMux busmux_inst (
//     .MDR(mdr),         
//     .ALU(alumuxout),        
//     .PC(pc),           
//     .MARMUX(adderout),   // TODO: change this 

//     .GateMDR(gate_mdr),    
//     .GateALU(gate_alu),    
//     .GatePC(gate_pc),      
//     .GateMARMUX(gate_marmux),
    
//     .BUS(bus)
// );

// // Branch Enable Logic
// //branch ben_inst (
// //    .clk(clk),
// //    .ir(ir),
// //    .nzp_vals(nzp_vals),
// //    .ld_ben(ld_ben),
// //    .ben(ben)
// //);

// // instantiate a register for MAR and MDR
// load_reg #(.DATA_WIDTH(16)) MAR (
//     .clk    (clk),
//     .reset  (reset),

//     .load   (ld_mar),
//     .data_i (bus),          // double check

//     .data_q (mar)
// );


// // load_reg #(.DATA_WIDTH(3)) nzp (
// //     .clk(clk),
// //     .reset(reset),

// //     .load(ld_cc),
// //     .data_i(bus[7:5]), // double check

// //     .data_q(nzp_vals)
// // );



// // confirm the input to the mdr 
// // could be a mux with the MIO enable signal 
// // for now set to bus
// load_reg #(.DATA_WIDTH(16)) MDR (
//     .clk    (clk),
//     .reset  (reset),

//     .load   (ld_mdr),
//     .data_i (mdr_in),          // double check

//     .data_q (mdr)
// );

// load_reg #(.DATA_WIDTH(16)) ir_reg (
//     .clk    (clk),
//     .reset  (reset),

//     .load   (ld_ir),
//     .data_i (bus),          // double check 

//     .data_q (ir)
// );

// load_reg #(.DATA_WIDTH(16)) pc_reg (
//     .clk(clk),
//     .reset(reset),

//     .load(ld_pc),
//     .data_i(pcmuxout), // double check

//     .data_q(pc)
// );


// // ==============================================================================
// // DONE
// //PCMux pcmux1 (.pc_select(pcmux), );
// PCMux pcmux_inst (
//     .pc_original(pc),
//     .BUS(bus),
//     .add(adderout),          // TODO: change this to output wire from adder mux? towards middle of data path
//     .pc_select(pcmux),
//     .pc(pcmuxout)
// );


// endmodule





// // assign mem_addr = mar;
// // assign mem_wdata = mdr;

// // logic [15:0] bus, pcmuxout;

// // assign led_o = ir;
// // assign hex_display_debug = ir;

// // logic [15:0] mdrmux;


// // logic [2:0] drmuxout, sr1muxout;
// // logic [15:0] sr2muxout, alumuxout, addr2muxout, addr1muxout;
// // logic [2:0] nzp_vals;

// // logic [15:0] regout1, regout2;


// // logic [15:0] adderout;

// // always_ff @ (posedge clk)
// // begin
// //     if(reset)
// //         begin
// //             adderout <= 16'h0000;
// //         end
// //     else begin
// //         adderout <= addr1muxout + addr2muxout;
// //     end
// // end



// // PCMux pcmux_inst (
// //     .pc_original(pc),
// //     .BUS(bus),
// //     .adder(adderout),          // TODO: change this to output wire from adder mux? towards middle of data path
// //     .pc_select(pcmux),
// //     .pc(pcmuxout)
// // );


// // // Address 1 Mux
// // mux21 addr1mux_inst(
// //     .a(pcmuxout), 
// //     .b(regout1), //TODO: implement the output of this in the register file
// //     .mio_en(addr1mux),
// //     .out(addr1muxout)
// // );


// // BUSMux busmux_inst (
// //     .MDR(mdr),         
// //     .ALU(alumuxout),        
// //     .PC(pc),           
// //     .MARMUX(adderout),   // TODO: change this 

// //     .GateMDR(gate_mdr),    
// //     .GateALU(gate_alu),    
// //     .GatePC(gate_pc),      
// //     .GateMARMUX(gate_marmux),
    
// //     .BUS(bus)
// // );


// // load_reg #(.DATA_WIDTH(16)) pc_reg (
// //     .clk(clk),
// //     .reset(reset),

// //     .load(ld_pc),
// //     .data_i(pcmuxout), // double check

// //     .data_q(pc)
// // );



// // endmodule