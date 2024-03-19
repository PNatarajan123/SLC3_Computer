module BUSMux(
    input logic [15:0] MDR,
    input logic [15:0] ALU,
    input logic [15:0] PC,
    input logic [15:0] MARMUX,
    
    input logic GateMDR,
    input logic GateALU,
    input logic GatePC,
    input logic GateMARMUX,
    
    output logic [15:0] BUS
    );
    
    always_comb begin
        if (GateMDR) begin
            BUS = MDR;
        end else if (GateALU) begin
            BUS = ALU;
        end else if (GatePC) begin
            BUS = PC;
        end else if (GateMARMUX) begin
            BUS = MARMUX;
        end else begin
            BUS = 16'bX;
        end
    end

endmodule


module mux21(
    input logic [15:0] a, b,
    input logic mio_en,
    output logic [15:0] out
);

    always_comb begin
        if (mio_en) begin
            out = b;
        end else begin
            out = a;
        end
    end
    
endmodule

// 3 bit 2 to 1 mux
module bit321mux(
    input logic [2:0] a,b,
    input logic enablebit,
    output logic [2:0] out
);
    always_comb begin
        if (enablebit) begin
            out = b;
        end else begin
            out = a;
        end
    end
endmodule


module muxadder2( // 2 to 1 mux for adder 2 
    input logic [15:0] a,b,c,d,
    input logic [1:0] addr2enable,
    output logic [15:0] out
);

always_comb begin
        case (addr2enable) // double check if the outputs are correct 
            2'b11: out = a; //leftmost
            2'b10: out = b;
            2'b01: out = c;
            2'b00: out = d; // If addr2enable is 11, select input d (rightmost)
            default: out = 16'bx; // Undefined state
        endcase
    end
    
endmodule
