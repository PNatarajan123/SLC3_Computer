//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Given Code - SLC-3 core
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 06-09-2020
//	  Revised 03-02-2021
//    Xilinx vivado
//    Revised 07-25-2023 
//    Revised 12-29-2023
//------------------------------------------------------------------------------

module cpu (
    input   logic        clk,
    input   logic        reset,

    input   logic        run_i,
    input   logic        continue_i,
    output  logic [15:0] hex_display_debug,
    output  logic [15:0] led_o,
   
    input   logic [15:0] mem_rdata,
    output  logic [15:0] mem_wdata,
    output  logic [15:0] mem_addr,
    output  logic        mem_mem_ena,
    output  logic        mem_wr_ena
);


// Internal connections
logic ld_mar; 
logic ld_mdr; 
logic ld_ir; 
logic ld_ben; 
logic ld_cc; 
logic ld_reg; 
logic ld_pc; 
logic ld_led;

logic gate_pc;
logic gate_mdr;
logic gate_alu; 
logic gate_marmux;

// select bits
logic [1:0] pcmux;
logic       drmux;
logic       sr1mux;
logic       sr2mux;
logic       addr1mux;
logic [1:0] addr2mux; 
logic [1:0] aluk;
logic       mio_en;

// registers
logic [15:0] mdr_in;
logic [15:0] mar; 
logic [15:0] mdr;
logic [15:0] ir;
logic [15:0] pc;
logic ben;

//  defining bus val and pcmuxout
logic [15:0] bus, pcmuxout;

assign mem_addr = mar;
assign mem_wdata = mdr;

// State machine, you need to fill in the code here as well
// .* auto-infers module input/output connections which have the same name
// This can help visually condense modules with large instantiations, 
// but can also lead to confusing code if used too commonly
control cpu_control (
    .*
);


// add additional logic for mem mem enable, 33, loading MDR with value at location MAR 

assign led_o = ir;
assign hex_display_debug = ir;

// setting mux for loading mdr 
logic [15:0] mdrmux;


logic [2:0] drmuxout, sr1muxout;
logic [15:0] sr2muxout, alumuxout, addr2muxout, addr1muxout;
logic [2:0] nzp_vals;

logic [15:0] regout1, regout2;

// Register File
regfile regfile_inst (  
    .bus(bus),
    .sr1mux(sr1muxout),
    .sr2mux(ir[2:0]), 
    .drmux(drmuxout),
    .ld_reg(ld_reg),
    .clk(clk),
    .reset(reset),
    .regout1(regout1), // TODO: implement this
    .regout2(regout2)  // TODO: implement this
);   

// Destination Register Mux
bit321mux drmux_inst (
    .a(ir[11:9]),
    .b(3'b111), //3'b111
    .enablebit(drmux),
    .out(drmuxout) // TODO: goes into register unit 
);

// Source Register 1 Mux
bit321mux sr1mux_inst (
    .a(ir[11:9]),
    .b(ir[8:6]), //ir[8:6]
    .enablebit(sr1mux),
    .out(sr1muxout) // goes into register unit 
);

// Source Register 2 Mux
// TODO: change the b input to the correct value so that sr2 output of register
mux21 sr2mux_inst (
    .b({{16{ir[4]}}, ir[4:0]}), // if 0 
    .a(regout2), // TODO: change this, sr2output from register unit
    .mio_en(sr2mux),
    .out(sr2muxout) 
);


// ALU Unit
// TODO: change the inputs to the correct values for sr2 and sr1
alu alu_inst (
    .A(regout1), // sr1
    .B(sr2muxout), // sr2
    .aluk(aluk),
    .R(alumuxout)
);


// NZP and Branch Ebalbe module 
nzpbranch branch_inst( 
    .reset(reset), 
    .clk(clk), 
    .ir(ir), 
    .Bus(bus), 
    .Ld_ben(ld_ben), 
    .ld_cc(ld_cc), 
   
    .Ben(ben) // output
);

// mdr mux 
mux21 mdrmux_inst( //TODO: double check this
    .b(bus),
    .a(mem_rdata),
    .mio_en(mio_en),
    .out(mdr_in)
);

muxadder2 addr2mux_inst(
    .a({{16{ir[10]}},ir[10:0]}),
    .b({{16{ir[8]}},ir[8:0]}),
    .c({{16{ir[5]}},ir[5:0]}),
    .d({16{0}}),
    .addr2enable(addr2mux[1:0]),
    .out(addr2muxout)
);


// Address 1 Mux
mux21 addr1mux_inst(
    .a(pc), 
    .b(regout1), //TODO: implement the output of this in the register file
    .mio_en(addr1mux),
    .out(addr1muxout)
);

logic [15:0] adderout;

// always_comb begin
//     adderout = addr1muxout + addr2muxout;
// end

// always_ff @ (posedge clk)
// begin
//     if(reset)
//         begin
//             adderout <= 16'h0000;
//         end
//     else begin
//         adderout <= addr1muxout + addr2muxout;
//     end
// end

assign adderout = addr1muxout + addr2muxout;


// Update the instantiations of this 
BUSMux busmux_inst (
    .MDR(mdr),         
    .ALU(alumuxout),        
    .PC(pc),           
    .MARMUX(adderout),   // TODO: change this 

    .GateMDR(gate_mdr),    
    .GateALU(gate_alu),    
    .GatePC(gate_pc),      
    .GateMARMUX(gate_marmux),
    
    .BUS(bus)
);

// Branch Enable Logic
//branch ben_inst (
//    .clk(clk),
//    .ir(ir),
//    .nzp_vals(nzp_vals),
//    .ld_ben(ld_ben),
//    .ben(ben)
//);

// instantiate a register for MAR and MDR
load_reg #(.DATA_WIDTH(16)) MAR (
    .clk    (clk),
    .reset  (reset),

    .load   (ld_mar),
    .data_i (bus),          // double check

    .data_q (mar)
);


// load_reg #(.DATA_WIDTH(3)) nzp (
//     .clk(clk),
//     .reset(reset),

//     .load(ld_cc),
//     .data_i(bus[7:5]), // double check

//     .data_q(nzp_vals)
// );



// confirm the input to the mdr 
// could be a mux with the MIO enable signal 
// for now set to bus
load_reg #(.DATA_WIDTH(16)) MDR (
    .clk    (clk),
    .reset  (reset),

    .load   (ld_mdr),
    .data_i (mdr_in),          // double check

    .data_q (mdr)
);

load_reg #(.DATA_WIDTH(16)) ir_reg (
    .clk    (clk),
    .reset  (reset),

    .load   (ld_ir),
    .data_i (bus),          // double check 

    .data_q (ir)
);

load_reg #(.DATA_WIDTH(16)) pc_reg (
    .clk(clk),
    .reset(reset),

    .load(ld_pc),
    .data_i(pcmuxout), // double check

    .data_q(pc)
);


// ==============================================================================
// DONE
//PCMux pcmux1 (.pc_select(pcmux), );
PCMux pcmux_inst (
    .pc_original(pc),
    .BUS(bus),
    .adder(adderout),          // TODO: change this to output wire from adder mux? towards middle of data path
    .pc_select(pcmux),
    .pc(pcmuxout)
);


endmodule