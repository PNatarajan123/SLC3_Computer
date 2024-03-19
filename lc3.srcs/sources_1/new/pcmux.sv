module PCMux(
    input logic [15:0] pc_original,
    input logic [15:0] BUS,
    input logic [15:0] adder,
    input logic [1:0] pc_select, // select bit
 
    output logic [15:0] pc
    );
    
    logic [15:0] pc_increment;
    logic cout;
        
//    ripple_adder RA(.a(pc_original), .b(4'h0000), .s(pc_increment), .cin(1), .cout(cout));
    assign pc_increment = pc_original  + 1;     
   // double check if always comb is needed
    always_comb begin
        case (pc_select)
            2'b01: pc = BUS;
            2'b10: pc = adder;
            2'b00: pc = pc_increment;       
            default: pc = 16'b0;
        endcase
    end
       
endmodule